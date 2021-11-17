# Burkina Faso Subnational Injectable Model
library(tidyr)
library(dplyr)
library(jsonlite) 
library(haven)
library(data.table)
library(questionr)

setwd("C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Burkina Faso")
# DHS Labels
#labels <- read.csv("Nigeria DHS Labels.csv")

# FPET Runs
fpet <- read.csv("BFStateFPETRunsAW.csv")
# Population Data
pop <- read.csv("C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Burkina Faso/Burkina_Region_Pop.csv")

levels(as.factor(pop$region_code))

pop2 <- pop %>% 
  group_by(region_code, mid_year) %>%
  summarize(Pop=sum(population_count)) %>% rename(Region=region_code, Year=mid_year) %>% filter(Year>=2019) %>%
  mutate(Region=case_when(
    Region=="Boucle de Mouhoun" ~ "BoucledeMouhoun",
    Region=="Cascades" ~ "Cascades",
    Region=="Centre (including Ouagadougou)" ~ "Centre",
    Region=="Centre-Est" ~ "CentreEst",
    Region=="Centre-Nord" ~ "CentreNord",
    Region=="Centre-Ouest" ~ "CentreOuest",
    Region=="Centre-Sud" ~ "CentreSud",
    Region=="Est" ~ "Est",
    Region=="Hauts Bassins" ~ "HautsBassin",
    Region=="Nord" ~ "Nord",
    Region=="Plateau Central" ~ "PlateauCentral",
    Region=="Sahel" ~ "Sahel",
    Region=="Sud-Ouest" ~ "SudOuest" ))



# Subnational discontinuation- not at this moment, going to stick with national discontinaution

# Updated using API
url<-("http://api.dhsprogram.com/rest/dhs/data?f=json&indicatorIds=FP_DISR_W_ANY&surveyid=all&breakdown=ALL&perpage=20000&APIkey=AVEHTH-279664")
jsondata<-fromJSON(url) 
dta<-data.table(jsondata$Data)

discontinuation<-dta %>% select( CountryName, SurveyId, Value, CharacteristicLabel)   %>% 
  filter(SurveyId=="BF2010DHS") %>%
  filter(CharacteristicLabel=="Pill"  | CharacteristicLabel==  "Injectables"    | CharacteristicLabel==      "Condom" )  %>% 
  spread(CharacteristicLabel, Value) %>% rename(API_ID=SurveyId)  %>%  
  mutate(discon_inj=Injectables/100,  discon_stm=(Pill+Condom)/200) %>%
  mutate(ISO=854)

discontinuation_clean <- discontinuation %>% select(ISO, discon_inj, discon_stm)

# Discontinued because inconveinent to use- API
url<-("http://api.dhsprogram.com/rest/dhs/data?f=json&indicatorIds=FP_RDIS_W_INC&surveyid=all&breakdown=ALL&perpage=20000&APIkey=AVEHTH-279664")
jsondata<-fromJSON(url) 
dta<-data.table(jsondata$Data)
inconv<- dta %>%  filter(SurveyId=="BF2010DHS") %>% filter( CharacteristicLabel==  "Total"    ) %>%
  rename(Disc_Inconv=Value) %>%  mutate(ISO=854) %>%
  select(ISO,  Disc_Inconv)

#################################################################################
# Distance (from national analysis)

distance_full <- read.csv("C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Baseline Data Update 080521/Distance082321.csv")
distance <- filter(distance_full, ISO==854)
#########################################################################################
# Most Recent Survey
women <- read_dta("C:/Users/KristinBietsch/files/DHS Data/Burkina Faso/BFIR62FL.DTA", col_select = any_of(c( "v005", "v024", "v604", "v605", "v312",  "v313", "v326")))

allwomen <- women %>% mutate(mcpr=case_when(v313==3 ~ 1, v313!=3 ~ 0),
                             inject= case_when(v312==3 ~ 1, v312!=3 ~ 0),
                             ltm=case_when(v312==2 |  v312==6 |  v312==11  ~ 1, v312!=2 & v312!=6 & v312!=11 ~ 0 ),
                             stm=case_when(v312==1 |  v312==5 | v312==13 |  v312==14 | v312==15 |  v312==17 | v312==18 ~ 1, 
                                           v312!=1 & v312!=5 & v312!=13 & v312!=14 & v312!=15 & v312!=17 & v312!=18 ~ 0)) %>%
  mutate(public=case_when(v326==11 | v326==12 | v326==13 | v326==14 | v326==16 ~ 1,
                          v326==21 | v326==23 | v326==24 | v326==27 | v326==31 | v326==32 | v326==33 | v326==34 | v326==96 | v326==99 ~ 0),
         GHC=case_when(v326==12 ~ 1, v326!=12 ~ 0),
         Fieldworker=case_when(v326==15 ~ 1, v326!=15 ~ 0)) %>% 
  mutate(one_year=case_when(v604==0 ~ 1),
         one_year=case_when(v605==7 ~ 1,   TRUE ~ one_year),
         one_year=case_when(v604!=0 ~ 0, is.na(v604) ~ 0,  TRUE ~ one_year),
         one_year=case_when(v605==4 | v605==5  ~ 0, TRUE ~ one_year),
         one_year=case_when(v313==3 ~ NA_real_, TRUE ~ one_year)) %>%
  mutate(relevant= 1-one_year)%>%
  mutate(sampleweights=v005/100000) %>%
  mutate(Region=case_when(v024==1 ~ "BoucledeMouhoun",
                          v024==2 ~ "Cascades",
                          v024==3 ~ "Centre",
                          v024==4 ~ "CentreEst",
                          v024==5 ~ "CentreNord",
                          v024==6 ~ "CentreOuest",
                          v024==7 ~ "CentreSud",
                          v024==8 ~ "Est",
                          v024==9 ~ "HautsBassin",
                          v024==10 ~ "Nord",
                          v024==11 ~ "PlateauCentral",
                          v024==12 ~ "Sahel",
                          v024==13 ~ "SudOuest")) 



###########################################################################
# ltm:2 6 11
# stm: 1 5  13 14 15 17 18 
# percent using injectables, ltm, and stm... and % using modern methods
mcpr <-    as.data.frame(prop.table(wtd.table(x= allwomen$mcpr, y=as.factor(allwomen$Region),  weights=allwomen$sampleweights ),2))  %>% rename(mCPR=Freq) %>% filter(Var1==1) %>% mutate(Region=Var2) %>% select(Region, mCPR)
inject <-    as.data.frame(prop.table(wtd.table(x= allwomen$inject, y=as.factor(allwomen$Region),  weights=allwomen$sampleweights ),2))  %>% rename(inject=Freq)   %>% filter(Var1==1) %>% mutate(Region=Var2) %>% select(Region, inject)
stm <-    as.data.frame(prop.table(wtd.table(x= allwomen$stm, y=as.factor(allwomen$Region),  weights=allwomen$sampleweights ),2))  %>% rename(stm=Freq)   %>% filter(Var1==1) %>% mutate(Region=Var2) %>% select(Region, stm)
ltm <-    as.data.frame(prop.table(wtd.table(x= allwomen$ltm, y=as.factor(allwomen$Region),  weights=allwomen$sampleweights ),2))  %>% rename(ltm=Freq)   %>% filter(Var1==1) %>% mutate(Region=Var2) %>% select(Region, ltm)

methodmix <- full_join(mcpr, inject, by="Region") %>% full_join(stm, by="Region") %>% full_join(ltm, by="Region") 

# relevant reasons for not using
relevant <-    as.data.frame(prop.table(wtd.table( x= allwomen$relevant,  y=as.factor(allwomen$Region), weights=allwomen$sampleweights ),2)) %>% rename(ReasonNotUsingSI=Freq)   %>% filter(Var1==1) %>% mutate(Region=Var2) %>% select(Region, ReasonNotUsingSI)


# Injectable source
# table(allwomen$inject, allwomen$sstate)
# In some states not enough users to calculate source, going to use bigger regions (v024)
injectable_users <- allwomen %>% filter(v312==3)

public_source <- as.data.frame(prop.table(wtd.table(x= injectable_users$public, y=as.factor(injectable_users$v024),  weights=injectable_users$sampleweights ),2)) %>% rename(Public_Source=Freq) %>% mutate(Public_Source=Public_Source*100)  %>% filter(Var1==1) %>% mutate(Region=Var2) %>% select(Region, Public_Source)
GHC_source <- as.data.frame(prop.table(wtd.table(x= injectable_users$GHC, y=as.factor(injectable_users$v024),  weights=injectable_users$sampleweights ),2)) %>% rename(GHC_source=Freq) %>% mutate(GHC_source=GHC_source*100)  %>% filter(Var1==1) %>% mutate(Region=Var2) %>% select(Region, GHC_source)

# No Fieldworker data
# Fieldworker_source <- as.data.frame(prop.table(wtd.table(x= injectable_users$Fieldworker, y=as.factor(injectable_users$v024),  weights=injectable_users$sampleweights ),2)) %>% rename(Fieldworker_source=Freq)  %>% mutate(Fieldworker_source=Fieldworker_source*100) %>% filter(Var1==1) %>% mutate(Region=Var2) %>% select(Region, Fieldworker_source)

#########################################################################################################################
mcpr_clean <- fpet %>% filter(year>=2019) %>% rename(mcpr=contraceptive_use_modern, Year=year)  %>% select(Region, Year, mcpr)

users_prop <- methodmix %>% mutate( prop_ltm = ltm/mCPR,
                                    prop_stm= stm/mCPR,
                                    prop_Injection= inject/mCPR) %>%
  select(Region,  prop_ltm, prop_stm, prop_Injection)

data <- full_join(mcpr_clean, users_prop, by=c("Region"))  %>% full_join(pop2, by=c("Region", "Year"))

total_users <- data %>% mutate(LTM = mcpr * prop_ltm * Pop,
                               STM = mcpr * prop_stm * Pop,
                               Injection = mcpr * prop_Injection * Pop,
                               NonUser = (1- mcpr) * Pop,
                               Total=LTM + STM + Injection + NonUser)  %>%
  mutate(ISO=854) %>%
  select(ISO, Region, Year, Total, LTM, STM, Injection, NonUser) 
###############################################################################

prop.inject.2019 <- users_prop %>% 
  mutate(high = case_when(prop_Injection >.33 ~ 1,
                          prop_Injection <= .33 ~0 )) %>%
  select(Region, high)

###############################################################################
policy_clean <- full_join(public_source, GHC_source, by="Region") %>% mutate(Fieldworker_source=0) %>% 
  mutate(GHC_source = replace_na(GHC_source, 0), Fieldworker_source=replace_na(Fieldworker_source, 0)) %>% 
  mutate(PSR=case_when(Public_Source<50 ~ 1, Public_Source >=50 & Public_Source <75 ~ 2, Public_Source>75 ~ 3),
         HC_CBR_total = (GHC_source + Fieldworker_source)/Public_Source,
         HC_CBR=case_when(HC_CBR_total<.50 ~ 1, HC_CBR_total >=.50 & HC_CBR_total <.75 ~ 2, HC_CBR_total>.75 ~ 3),
         PSR_pr=case_when(PSR==1 ~ .5 , PSR==2 ~ .8, PSR==3 ~ 1),
         HCCBR_pr=case_when(HC_CBR==1 ~ .75, HC_CBR==2 ~ .9, HC_CBR==3 ~ 1),
         scale=PSR_pr*HCCBR_pr,
         HC_CBR_clean= round(HC_CBR_total*100,1))  %>%
  mutate(Region=case_when(Region==1 ~ "BoucledeMouhoun",
                          Region==2 ~ "Cascades",
                          Region==3 ~ "Centre",
                          Region==4 ~ "CentreEst",
                          Region==5 ~ "CentreNord",
                          Region==6 ~ "CentreOuest",
                          Region==7 ~ "CentreSud",
                          Region==8 ~ "Est",
                          Region==9 ~ "HautsBassin",
                          Region==10 ~ "Nord",
                          Region==11 ~ "PlateauCentral",
                          Region==12 ~ "Sahel",
                          Region==13 ~ "SudOuest")) %>%
  select( Region, scale) 


###############################################################################
# From PATH on 6/17
# KB other default will be 2022 and 2025

parameters <- full_join(distance, inconv, by="ISO")  %>% 
  mutate(nu_to_si=case_when(distance< -.15 ~ 0.05,
                            distance >= -.15 & distance < -.05 ~ 0.04,
                            distance >= -.05 & distance < .05 ~ 0.03,
                            distance >= .05 & distance < .15 ~ 0.02,
                            distance>= .15 ~ 0.01)) %>% 
  mutate(si_bonus_base=case_when(Disc_Inconv< 2 ~ 0.01,
                                 Disc_Inconv>= 2 &  Disc_Inconv< 4 ~ 0.02,
                                 Disc_Inconv>=4 ~ 0.03)) %>%
  mutate(si_bonus=case_when(nu_to_si==0.01 ~ si_bonus_base + 0.01 ,
                            nu_to_si==0.02 ~ si_bonus_base + 0.005 ,
                            nu_to_si>=0.03 ~ si_bonus_base)) %>% 
  mutate(year_sc=case_when(ISO==854 ~ 2019,
                           ISO==404 ~ 2025,
                           ISO==566 ~ 2023,
                           ISO==686 ~ 2019,
                           ISO==800 ~ 2019,
                           ISO!=854 & ISO!=404 & ISO!=566 & ISO!=686 & ISO!=800 ~ 2022 ),
         year_si=case_when(ISO==854 ~ 2022,
                           ISO==404 ~ 2027,
                           ISO==566 ~ 2024,
                           ISO==686 ~ 2020,
                           ISO==800 ~ 2022,
                           ISO!=854 & ISO!=404 & ISO!=566 & ISO!=686 & ISO!=800 ~ 2025 ))%>%  
  mutate(max_siofsc=.4,
         inj_to_si=.16,	
         stm_to_si=.08) %>% 
  select(ISO, inj_to_si, stm_to_si, nu_to_si, si_bonus, max_siofsc, year_sc, year_si)
###############################################################################

baseline <- full_join(total_users, prop.inject.2019, by="Region") %>%
  full_join(relevant, by="Region") %>% 
  full_join(policy_clean,  by="Region") %>%
  full_join(discontinuation_clean,  by="ISO") %>%
  full_join(parameters, by="ISO" ) %>%
  filter(!is.na(Year)) %>%
  mutate(CountryYear=paste(Region, Year, sep="")) %>%
  rename(iso=ISO, Country=Region) %>%
  arrange(Country, Year) %>%
  select(Country,	iso,	Year,	CountryYear,	Total,	LTM,	STM,	Injection,	NonUser,
         high,	ReasonNotUsingSI,		scale,	
         discon_inj,	discon_stm,	
         inj_to_si,	stm_to_si,	nu_to_si,	si_bonus,	max_siofsc,	year_sc	, year_si) 

###############################################################################
###############################################################################
###############################################################################

baseline$SC <- baseline$year_sc
baseline$SI <- baseline$year_si
baseline <- baseline %>% mutate(time_sc_si = SI-SC,
                                years_after_sc=Year-SC,
                                share_between_scsi = (years_after_sc/time_sc_si)*max_siofsc,
                                per_si =case_when(Year>=SI ~ max_siofsc,
                                                  Year<=SC ~ 0,
                                                  Year>SC & Year<SI ~ share_between_scsi),
                                share_bonus=per_si/max_siofsc) 


baseline <- baseline %>% mutate(high_scale=case_when(high==1 ~ 1, high==0 ~ .9))

# take the 2019 numbers, and put them as their own variable, then apply the bonsus
base2019 <- baseline %>% filter(Year==2019) %>% select(Country, Injection, STM, NonUser) %>% 
  rename(Injection_2019=Injection,
         STM_2019=STM,
         NonUser_2019=NonUser)


baseline <- full_join(baseline, base2019, by="Country")

baseline <- baseline %>% mutate(inj_switch_si_a=(((inj_to_si+(si_bonus*share_bonus)))*Injection_2019)/11,
                                stm_switch_si_a=(((stm_to_si+(si_bonus*share_bonus))*scale)*STM_2019)/11,
                                nu_switch_si_a=(((nu_to_si+(si_bonus*share_bonus))*scale)*NonUser_2019*ReasonNotUsingSI)/11) 

equations <- baseline

# Here is where the years since full scale matter- making annual numbers before it 0
equations <- equations %>% mutate(year_fullscale= case_when(Year-year_sc<0 ~ 0, Year-year_sc>=0 ~ Year-year_sc+1 )) %>%
  mutate(binary_full_scale=case_when(year_fullscale>0 ~ 1, year_fullscale==0 ~ 0)) %>% 
  mutate(inj_switch_si_a=inj_switch_si_a*binary_full_scale,
         stm_switch_si_a=stm_switch_si_a*binary_full_scale,
         nu_switch_si_a=nu_switch_si_a*binary_full_scale) %>%
  group_by(Country) %>%
  mutate(inj_switch_si = cumsum(inj_switch_si_a),
         stm_switch_si = cumsum(stm_switch_si_a),
         inj_stay= Injection-inj_switch_si,
         stm_stay=STM-stm_switch_si)




#SI users who would have been non-users because of discontinuation from IM
equations <- equations %>% mutate(si_non_disc_im = case_when(year_fullscale==0 ~ 0, year_fullscale!=0 ~ inj_switch_si*(discon_inj*.26)))

# SI users who would have been non-users because of discontinuation from STM
equations <- equations %>% mutate(si_non_disc_stm = case_when(year_fullscale==0 ~ 0, year_fullscale!=0 ~ stm_switch_si*(discon_stm*.26)))

#Nonusers Not SI Relevant
equations <- equations %>% mutate(nu_not_sirelevant=(NonUser-si_non_disc_im-si_non_disc_stm)*(1-ReasonNotUsingSI),
                                  nu_sirelevant=(NonUser-si_non_disc_im-si_non_disc_stm)*(ReasonNotUsingSI))

# Nonusers  SI Relevant Uptake
equations <- equations %>% mutate( nu_sirelevant_uptake= cumsum(nu_switch_si_a))
equations <- equations %>% mutate(nu_sirelevant_notuptake=nu_sirelevant-nu_sirelevant_uptake)

names(equations)
equations <- equations %>% mutate(si_users=inj_switch_si+stm_switch_si+si_non_disc_im+si_non_disc_stm+nu_sirelevant_uptake,
                                  im_users=inj_stay,
                                  stm_users=stm_stay,
                                  ltm_users=LTM,
                                  non_users=nu_not_sirelevant+nu_sirelevant_notuptake,
                                  per_users_si=si_users/(si_users+im_users+stm_users+ltm_users),
                                  total_inject=si_users+im_users)

sel <- equations %>% select(Country, Year, total_inject )



# Proportion of SI Users from Various sources
equations <- equations %>% mutate(prop_si_im= case_when(si_users==0 ~ 0, si_users!=0 ~ inj_switch_si/si_users),
                                  prop_si_stm= case_when(si_users==0 ~ 0, si_users!=0 ~ stm_switch_si/si_users),
                                  prop_si_disc= case_when(si_users==0 ~ 0, si_users!=0 ~ (si_non_disc_im+si_non_disc_stm)/si_users),
                                  prop_si_uptake= case_when(si_users==0 ~ 0, si_users!=0 ~ nu_sirelevant_uptake/si_users))

equations <- equations %>% mutate(baseline_users=LTM+STM+Injection,
                                  total_user_w_si=si_users+im_users+stm_users+ltm_users)

# Injectable Users
equations <- equations %>% mutate(injec_user_w_si=si_users+im_users)

# IM Users, SI Users, and SC Users
equations <- equations %>% mutate(IM_injec_user_w_si=round(im_users),
                                  SCP_injec_user_w_si=round(si_users*(1-per_si)),
                                  SI_injec_user_w_si= round(si_users*(per_si)),
                                  non_users = Total-total_user_w_si,
                                  mcpr_w_si=round((total_user_w_si/Total)*100,1),
                                  inject_share=injec_user_w_si/total_user_w_si,
                                  baseline_mcpr=round((baseline_users/Total)*100,1),
                                  additional_users=round(total_user_w_si-baseline_users))

# Results 2030
results <- equations %>%
  filter(Year==2030) %>% ungroup() %>%
  select(Country, iso, Year, baseline_mcpr, mcpr_w_si, additional_users, total_user_w_si, baseline_users, Total, SI_injec_user_w_si, SCP_injec_user_w_si, prop_si_uptake) %>%
  mutate(SC_users=SI_injec_user_w_si+ SCP_injec_user_w_si,
         prop_si_uptake_clean=round(prop_si_uptake*100),
         prop_sc_total_users=round(SC_users/total_user_w_si*100)) %>%
  select(Country,  mcpr_w_si, baseline_mcpr, SC_users) %>%
  rename("mCPR with SC Introduction"=mcpr_w_si, "mCPR without SC Introduction"=baseline_mcpr, "DMPA-SC Users"=SC_users)


additional_users <- equations %>% filter(Year==2030) %>% ungroup() %>%
  select(Country,  additional_users) %>%
  rename("Additional Users" = additional_users)

sc_users2030_fp2020 <-  equations %>% ungroup() %>% 
  mutate(SC_users=SI_injec_user_w_si+ SCP_injec_user_w_si) %>% 
  filter(Year==2030)  %>%
  select(Country,  prop_si_im,  prop_si_stm,  prop_si_disc, prop_si_uptake) %>%
  rename("Former IM" = prop_si_im,  "Former STM" = prop_si_stm,  "Reduced Discontinuation" = prop_si_disc, "Uptake from Non-Users" = prop_si_uptake)



results_total <- full_join(results, additional_users, by="Country") %>% full_join(sc_users2030_fp2020, by="Country")
write.csv(results_total, "C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Burkina Faso/Burkina Faso Region DMPA Results 110121.csv", row.names = F)
