# Subnational FPET Nigeria

# fpemlocal
# https://gatesopenresearch.org/articles/5-24#ref-17
# https://github.com/AlkemaLab/fpemlocal
# Jags: https://sourceforge.net/projects/mcmc-jags/

#library(devtools)
#install_github("AlkemaLab/fpemlocal")

# had to manually delete ellipsis and pillar and redownload (https://stackoverflow.com/questions/60451908/tidyverse-not-loaded-it-says-namespace-vctrs-0-2-0-is-already-loaded-but)
# had to install package ggnewscale
library(fpemlocal)
library(ggnewscale)
library(dplyr)


# Create single subnational files
allstate <- read.csv("C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/Nigeria_091021_Survey_KB.csv") %>% rename(division_numeric_code=unit_numeric_code) %>%
  mutate(division_numeric_code=as.numeric(division_numeric_code)) %>%
  mutate(region_code=case_when(region_code=="Abia" ~ "Abia",
                               region_code=="Abuja" ~ "Abuja",
                               region_code=="Adamawa" ~ "Adamawa",
                               region_code=="Akwa Ibom" ~ "AkwaIbom",
                               region_code=="Anambra" ~ "Anambra",
                               region_code=="Bauchi" ~ "Bauchi",
                               region_code=="Bayelsa" ~ "Bayelsa",
                               region_code=="Benue" ~ "Benue",
                               region_code=="Borno" ~ "Borno",
                               region_code=="Cross River" ~ "CrossRiver",
                               region_code=="Delta" ~ "Delta",
                               region_code=="Ebonyi" ~ "Ebonyi",
                               region_code=="Edo" ~ "Edo",
                               region_code=="Ekiti" ~ "Ekiti",
                               region_code=="Enugu" ~ "Enugu",
                               region_code=="Gombe" ~ "Gombe",
                               region_code=="Imo" ~ "Imo",
                               region_code=="Jigawa" ~ "Jigawa",
                               region_code=="Kaduna" ~ "Kaduna",
                               region_code=="Kano" ~ "Kano",
                               region_code=="Katsina" ~ "Katsina",
                               region_code=="Kebbi" ~ "Kebbi",
                               region_code=="Kogi" ~ "Kogi",
                               region_code=="Kwara" ~ "Kwara",
                               region_code=="Lagos" ~ "Lagos",
                               region_code=="Nasarawa" ~ "Nasarawa",
                               region_code=="Niger" ~ "Niger",
                               region_code=="Ogun" ~ "Ogun",
                               region_code=="Ondo" ~ "Ondo",
                               region_code=="Osun" ~ "Osun",
                               region_code=="Oyo" ~ "Oyo",
                               region_code=="Plateau" ~ "Plateau",
                               region_code=="Rivers" ~ "Rivers",
                               region_code=="Sokoto" ~ "Sokoto",
                               region_code=="Taraba" ~ "Taraba",
                               region_code=="Yobe" ~ "Yobe",
                               region_code=="Zamfara" ~ "Zamfara"))

# Create files for each state
Abia <- allstate %>% filter(region_code=="Abia")
Abuja <- allstate %>% filter(region_code=="Abuja")
Adamawa <- allstate %>% filter(region_code=="Adamawa")
AkwaIbom <- allstate %>% filter(region_code=="AkwaIbom")
Anambra <- allstate %>% filter(region_code=="Anambra")
Bauchi <- allstate %>% filter(region_code=="Bauchi")
Bayelsa <- allstate %>% filter(region_code=="Bayelsa")
Benue <- allstate %>% filter(region_code=="Benue")
Borno <- allstate %>% filter(region_code=="Borno")
CrossRiver <- allstate %>% filter(region_code=="CrossRiver")
Delta <- allstate %>% filter(region_code=="Delta")
Ebonyi <- allstate %>% filter(region_code=="Ebonyi")
Edo <- allstate %>% filter(region_code=="Edo")
Ekiti <- allstate %>% filter(region_code=="Ekiti")
Enugu <- allstate %>% filter(region_code=="Enugu")
Gombe <- allstate %>% filter(region_code=="Gombe")
Imo <- allstate %>% filter(region_code=="Imo")
Jigawa <- allstate %>% filter(region_code=="Jigawa")
Kaduna <- allstate %>% filter(region_code=="Kaduna")
Kano <- allstate %>% filter(region_code=="Kano")
Katsina <- allstate %>% filter(region_code=="Katsina")
Kebbi <- allstate %>% filter(region_code=="Kebbi")
Kogi <- allstate %>% filter(region_code=="Kogi")
Kwara <- allstate %>% filter(region_code=="Kwara")
Lagos <- allstate %>% filter(region_code=="Lagos")
Nasarawa <- allstate %>% filter(region_code=="Nasarawa")
Niger <- allstate %>% filter(region_code=="Niger")
Ogun <- allstate %>% filter(region_code=="Ogun")
Ondo <- allstate %>% filter(region_code=="Ondo")
Osun <- allstate %>% filter(region_code=="Osun")
Oyo <- allstate %>% filter(region_code=="Oyo")
Plateau <- allstate %>% filter(region_code=="Plateau")
Rivers <- allstate %>% filter(region_code=="Rivers")
Sokoto <- allstate %>% filter(region_code=="Sokoto")
Taraba <- allstate %>% filter(region_code=="Taraba")
Yobe <- allstate %>% filter(region_code=="Yobe")
Zamfara <- allstate %>% filter(region_code=="Zamfara")

setwd("C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey")
write.csv(Abia, "NigeriaSurvey_Abia.csv", row.names=F, na="")
write.csv(Abuja, "NigeriaSurvey_Abuja.csv", row.names=F, na="")
write.csv(Adamawa, "NigeriaSurvey_Adamawa.csv", row.names=F, na="")
write.csv(AkwaIbom, "NigeriaSurvey_AkwaIbom.csv", row.names=F, na="")
write.csv(Anambra, "NigeriaSurvey_Anambra.csv", row.names=F, na="")
write.csv(Bauchi, "NigeriaSurvey_Bauchi.csv", row.names=F, na="")
write.csv(Bayelsa, "NigeriaSurvey_Bayelsa.csv", row.names=F, na="")
write.csv(Benue, "NigeriaSurvey_Benue.csv", row.names=F, na="")
write.csv(Borno, "NigeriaSurvey_Borno.csv", row.names=F, na="")
write.csv(CrossRiver, "NigeriaSurvey_CrossRiver.csv", row.names=F, na="")
write.csv(Delta, "NigeriaSurvey_Delta.csv", row.names=F, na="")
write.csv(Ebonyi, "NigeriaSurvey_Ebonyi.csv", row.names=F, na="")
write.csv(Edo, "NigeriaSurvey_Edo.csv", row.names=F, na="")
write.csv(Ekiti, "NigeriaSurvey_Ekiti.csv", row.names=F, na="")
write.csv(Enugu, "NigeriaSurvey_Enugu.csv", row.names=F, na="")
write.csv(Gombe, "NigeriaSurvey_Gombe.csv", row.names=F, na="")
write.csv(Imo, "NigeriaSurvey_Imo.csv", row.names=F, na="")
write.csv(Jigawa, "NigeriaSurvey_Jigawa.csv", row.names=F, na="")
write.csv(Kaduna, "NigeriaSurvey_Kaduna.csv", row.names=F, na="")
write.csv(Kano, "NigeriaSurvey_Kano.csv", row.names=F, na="")
write.csv(Katsina, "NigeriaSurvey_Katsina.csv", row.names=F, na="")
write.csv(Kebbi, "NigeriaSurvey_Kebbi.csv", row.names=F, na="")
write.csv(Kogi, "NigeriaSurvey_Kogi.csv", row.names=F, na="")
write.csv(Kwara, "NigeriaSurvey_Kwara.csv", row.names=F, na="")
write.csv(Lagos, "NigeriaSurvey_Lagos.csv", row.names=F, na="")
write.csv(Nasarawa, "NigeriaSurvey_Nasarawa.csv", row.names=F, na="")
write.csv(Niger, "NigeriaSurvey_Niger.csv", row.names=F, na="")
write.csv(Ogun, "NigeriaSurvey_Ogun.csv", row.names=F, na="")
write.csv(Ondo, "NigeriaSurvey_Ondo.csv", row.names=F, na="")
write.csv(Osun, "NigeriaSurvey_Osun.csv", row.names=F, na="")
write.csv(Oyo, "NigeriaSurvey_Oyo.csv", row.names=F, na="")
write.csv(Plateau, "NigeriaSurvey_Plateau.csv", row.names=F, na="")
write.csv(Rivers, "NigeriaSurvey_Rivers.csv", row.names=F, na="")
write.csv(Sokoto, "NigeriaSurvey_Sokoto.csv", row.names=F, na="")
write.csv(Taraba, "NigeriaSurvey_Taraba.csv", row.names=F, na="")
write.csv(Yobe, "NigeriaSurvey_Yobe.csv", row.names=F, na="")
write.csv(Zamfara, "NigeriaSurvey_Zamfara.csv", row.names=F, na="")


file_Abia <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Abia.csv"
file_Abuja <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Abuja.csv"
file_Adamawa <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Adamawa.csv"
file_AkwaIbom <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_AkwaIbom.csv"
file_Anambra <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Anambra.csv"
file_Bauchi <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Bauchi.csv"
file_Bayelsa <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Bayelsa.csv"
file_Benue <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Benue.csv"
file_Borno <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Borno.csv"
file_CrossRiver <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_CrossRiver.csv"
file_Delta <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Delta.csv"
file_Ebonyi <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Ebonyi.csv"
file_Edo <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Edo.csv"
file_Ekiti <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Ekiti.csv"
file_Enugu <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Enugu.csv"
file_Gombe <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Gombe.csv"
file_Imo <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Imo.csv"
file_Jigawa <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Jigawa.csv"
file_Kaduna <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Kaduna.csv"
file_Kano <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Kano.csv"
file_Katsina <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Katsina.csv"
file_Kebbi <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Kebbi.csv"
file_Kogi <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Kogi.csv"
file_Kwara <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Kwara.csv"
file_Lagos <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Lagos.csv"
file_Nasarawa <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Nasarawa.csv"
file_Niger <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Niger.csv"
file_Ogun <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Ogun.csv"
file_Ondo <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Ondo.csv"
file_Osun <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Osun.csv"
file_Oyo <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Oyo.csv"
file_Plateau <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Plateau.csv"
file_Rivers <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Rivers.csv"
file_Sokoto <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Sokoto.csv"
file_Taraba <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Taraba.csv"
file_Yobe <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Yobe.csv"
file_Zamfara <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/State Survey/NigeriaSurvey_Zamfara.csv"




pop <- read.csv("C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/Nigeria_State_Population.csv")  %>% rename(division_numeric_code=unit_numeric_code) %>%
  mutate(division_numeric_code=as.numeric(division_numeric_code)) %>%
  mutate(region_code=case_when(region_code=="Abia" ~ "Abia",
                               region_code=="Abuja" ~ "Abuja",
                               region_code=="Adamawa" ~ "Adamawa",
                               region_code=="Akwa Ibom" ~ "AkwaIbom",
                               region_code=="Anambra" ~ "Anambra",
                               region_code=="Bauchi" ~ "Bauchi",
                               region_code=="Bayelsa" ~ "Bayelsa",
                               region_code=="Benue" ~ "Benue",
                               region_code=="Borno" ~ "Borno",
                               region_code=="Cross River" ~ "CrossRiver",
                               region_code=="Delta" ~ "Delta",
                               region_code=="Ebonyi" ~ "Ebonyi",
                               region_code=="Edo" ~ "Edo",
                               region_code=="Ekiti" ~ "Ekiti",
                               region_code=="Enugu" ~ "Enugu",
                               region_code=="Gombe" ~ "Gombe",
                               region_code=="Imo" ~ "Imo",
                               region_code=="Jigawa" ~ "Jigawa",
                               region_code=="Kaduna" ~ "Kaduna",
                               region_code=="Kano" ~ "Kano",
                               region_code=="Katsina" ~ "Katsina",
                               region_code=="Kebbi" ~ "Kebbi",
                               region_code=="Kogi" ~ "Kogi",
                               region_code=="Kwara" ~ "Kwara",
                               region_code=="Lagos" ~ "Lagos",
                               region_code=="Nasarawa" ~ "Nasarawa",
                               region_code=="Niger" ~ "Niger",
                               region_code=="Ogun" ~ "Ogun",
                               region_code=="Ondo" ~ "Ondo",
                               region_code=="Osun" ~ "Osun",
                               region_code=="Oyo" ~ "Oyo",
                               region_code=="Plateau" ~ "Plateau",
                               region_code=="Rivers" ~ "Rivers",
                               region_code=="Sokoto" ~ "Sokoto",
                               region_code=="Taraba" ~ "Taraba",
                               region_code=="Yobe" ~ "Yobe",
                               region_code=="Zamfara" ~ "Zamfara"))

pop_Abia <- pop %>% filter(region_code=="Abia")
pop_Abuja <- pop %>% filter(region_code=="Abuja")
pop_Adamawa <- pop %>% filter(region_code=="Adamawa")
pop_AkwaIbom <- pop %>% filter(region_code=="AkwaIbom")
pop_Anambra <- pop %>% filter(region_code=="Anambra")
pop_Bauchi <- pop %>% filter(region_code=="Bauchi")
pop_Bayelsa <- pop %>% filter(region_code=="Bayelsa")
pop_Benue <- pop %>% filter(region_code=="Benue")
pop_Borno <- pop %>% filter(region_code=="Borno")
pop_CrossRiver <- pop %>% filter(region_code=="CrossRiver")
pop_Delta <- pop %>% filter(region_code=="Delta")
pop_Ebonyi <- pop %>% filter(region_code=="Ebonyi")
pop_Edo <- pop %>% filter(region_code=="Edo")
pop_Ekiti <- pop %>% filter(region_code=="Ekiti")
pop_Enugu <- pop %>% filter(region_code=="Enugu")
pop_Gombe <- pop %>% filter(region_code=="Gombe")
pop_Imo <- pop %>% filter(region_code=="Imo")
pop_Jigawa <- pop %>% filter(region_code=="Jigawa")
pop_Kaduna <- pop %>% filter(region_code=="Kaduna")
pop_Kano <- pop %>% filter(region_code=="Kano")
pop_Katsina <- pop %>% filter(region_code=="Katsina")
pop_Kebbi <- pop %>% filter(region_code=="Kebbi")
pop_Kogi <- pop %>% filter(region_code=="Kogi")
pop_Kwara <- pop %>% filter(region_code=="Kwara")
pop_Lagos <- pop %>% filter(region_code=="Lagos")
pop_Nasarawa <- pop %>% filter(region_code=="Nasarawa")
pop_Niger <- pop %>% filter(region_code=="Niger")
pop_Ogun <- pop %>% filter(region_code=="Ogun")
pop_Ondo <- pop %>% filter(region_code=="Ondo")
pop_Osun <- pop %>% filter(region_code=="Osun")
pop_Oyo <- pop %>% filter(region_code=="Oyo")
pop_Plateau <- pop %>% filter(region_code=="Plateau")
pop_Rivers <- pop %>% filter(region_code=="Rivers")
pop_Sokoto <- pop %>% filter(region_code=="Sokoto")
pop_Taraba <- pop %>% filter(region_code=="Taraba")
pop_Yobe <- pop %>% filter(region_code=="Yobe")
pop_Zamfara <- pop %>% filter(region_code=="Zamfara")

fit_Abia <-fit_fp_c(  surveydata_filepath = file_Abia,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Abuja <-fit_fp_c(  surveydata_filepath = file_Abuja,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Adamawa <-fit_fp_c(  surveydata_filepath = file_Adamawa,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_AkwaIbom <-fit_fp_c(  surveydata_filepath = file_AkwaIbom,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Anambra <-fit_fp_c(  surveydata_filepath = file_Anambra,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Bauchi <-fit_fp_c(  surveydata_filepath = file_Bauchi,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Bayelsa <-fit_fp_c(  surveydata_filepath = file_Bayelsa,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Benue <-fit_fp_c(  surveydata_filepath = file_Benue,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Borno <-fit_fp_c(  surveydata_filepath = file_Borno,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_CrossRiver <-fit_fp_c(  surveydata_filepath = file_CrossRiver,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Delta <-fit_fp_c(  surveydata_filepath = file_Delta,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Ebonyi <-fit_fp_c(  surveydata_filepath = file_Ebonyi,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Edo <-fit_fp_c(  surveydata_filepath = file_Edo,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Ekiti <-fit_fp_c(  surveydata_filepath = file_Ekiti,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Enugu <-fit_fp_c(  surveydata_filepath = file_Enugu,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Gombe <-fit_fp_c(  surveydata_filepath = file_Gombe,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Imo <-fit_fp_c(  surveydata_filepath = file_Imo,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Jigawa <-fit_fp_c(  surveydata_filepath = file_Jigawa,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Kaduna <-fit_fp_c(  surveydata_filepath = file_Kaduna,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Kano <-fit_fp_c(  surveydata_filepath = file_Kano,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Katsina <-fit_fp_c(  surveydata_filepath = file_Katsina,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Kebbi <-fit_fp_c(  surveydata_filepath = file_Kebbi,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Kogi <-fit_fp_c(  surveydata_filepath = file_Kogi,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Kwara <-fit_fp_c(  surveydata_filepath = file_Kwara,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Lagos <-fit_fp_c(  surveydata_filepath = file_Lagos,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Nasarawa <-fit_fp_c(  surveydata_filepath = file_Nasarawa,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Niger <-fit_fp_c(  surveydata_filepath = file_Niger,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Ogun <-fit_fp_c(  surveydata_filepath = file_Ogun,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Ondo <-fit_fp_c(  surveydata_filepath = file_Ondo,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Osun <-fit_fp_c(  surveydata_filepath = file_Osun,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Oyo <-fit_fp_c(  surveydata_filepath = file_Oyo,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Plateau <-fit_fp_c(  surveydata_filepath = file_Plateau,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Rivers <-fit_fp_c(  surveydata_filepath = file_Rivers,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Sokoto <-fit_fp_c(  surveydata_filepath = file_Sokoto,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Taraba <-fit_fp_c(  surveydata_filepath = file_Taraba,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Yobe <-fit_fp_c(  surveydata_filepath = file_Yobe,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Zamfara <-fit_fp_c(  surveydata_filepath = file_Zamfara,  division_numeric_code= 566,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)


results_Abia <-calc_fp_c(fit_Abia,  population_data = pop_Abia)
results_Abuja <-calc_fp_c(fit_Abuja,  population_data = pop_Abuja)
results_Adamawa <-calc_fp_c(fit_Adamawa,  population_data = pop_Adamawa)
results_AkwaIbom <-calc_fp_c(fit_AkwaIbom,  population_data = pop_AkwaIbom)
results_Anambra <-calc_fp_c(fit_Anambra,  population_data = pop_Anambra)
results_Bauchi <-calc_fp_c(fit_Bauchi,  population_data = pop_Bauchi)
results_Bayelsa <-calc_fp_c(fit_Bayelsa,  population_data = pop_Bayelsa)
results_Benue <-calc_fp_c(fit_Benue,  population_data = pop_Benue)
results_Borno <-calc_fp_c(fit_Borno,  population_data = pop_Borno)
results_CrossRiver <-calc_fp_c(fit_CrossRiver,  population_data = pop_CrossRiver)
results_Delta <-calc_fp_c(fit_Delta,  population_data = pop_Delta)
results_Ebonyi <-calc_fp_c(fit_Ebonyi,  population_data = pop_Ebonyi)
results_Edo <-calc_fp_c(fit_Edo,  population_data = pop_Edo)
results_Ekiti <-calc_fp_c(fit_Ekiti,  population_data = pop_Ekiti)
results_Enugu <-calc_fp_c(fit_Enugu,  population_data = pop_Enugu)
results_Gombe <-calc_fp_c(fit_Gombe,  population_data = pop_Gombe)
results_Imo <-calc_fp_c(fit_Imo,  population_data = pop_Imo)
results_Jigawa <-calc_fp_c(fit_Jigawa,  population_data = pop_Jigawa)
results_Kaduna <-calc_fp_c(fit_Kaduna,  population_data = pop_Kaduna)
results_Kano <-calc_fp_c(fit_Kano,  population_data = pop_Kano)
results_Katsina <-calc_fp_c(fit_Katsina,  population_data = pop_Katsina)
results_Kebbi <-calc_fp_c(fit_Kebbi,  population_data = pop_Kebbi)
results_Kogi <-calc_fp_c(fit_Kogi,  population_data = pop_Kogi)
results_Kwara <-calc_fp_c(fit_Kwara,  population_data = pop_Kwara)
results_Lagos <-calc_fp_c(fit_Lagos,  population_data = pop_Lagos)
results_Nasarawa <-calc_fp_c(fit_Nasarawa,  population_data = pop_Nasarawa)
results_Niger <-calc_fp_c(fit_Niger,  population_data = pop_Niger)
results_Ogun <-calc_fp_c(fit_Ogun,  population_data = pop_Ogun)
results_Ondo <-calc_fp_c(fit_Ondo,  population_data = pop_Ondo)
results_Osun <-calc_fp_c(fit_Osun,  population_data = pop_Osun)
results_Oyo <-calc_fp_c(fit_Oyo,  population_data = pop_Oyo)
results_Plateau <-calc_fp_c(fit_Plateau,  population_data = pop_Plateau)
results_Rivers <-calc_fp_c(fit_Rivers,  population_data = pop_Rivers)
results_Sokoto <-calc_fp_c(fit_Sokoto,  population_data = pop_Sokoto)
results_Taraba <-calc_fp_c(fit_Taraba,  population_data = pop_Taraba)
results_Yobe <-calc_fp_c(fit_Yobe,  population_data = pop_Yobe)
results_Zamfara <-calc_fp_c(fit_Zamfara,  population_data = pop_Zamfara)


Abia_all_mcpr <-results_Abia$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Abia")
Abuja_all_mcpr <-results_Abuja$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Abuja")
Adamawa_all_mcpr <-results_Adamawa$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Adamawa")
AkwaIbom_all_mcpr <-results_AkwaIbom$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="AkwaIbom")
Anambra_all_mcpr <-results_Anambra$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Anambra")
Bauchi_all_mcpr <-results_Bauchi$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Bauchi")
Bayelsa_all_mcpr <-results_Bayelsa$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Bayelsa")
Benue_all_mcpr <-results_Benue$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Benue")
Borno_all_mcpr <-results_Borno$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Borno")
CrossRiver_all_mcpr <-results_CrossRiver$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="CrossRiver")
Delta_all_mcpr <-results_Delta$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Delta")
Ebonyi_all_mcpr <-results_Ebonyi$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Ebonyi")
Edo_all_mcpr <-results_Edo$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Edo")
Ekiti_all_mcpr <-results_Ekiti$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Ekiti")
Enugu_all_mcpr <-results_Enugu$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Enugu")
Gombe_all_mcpr <-results_Gombe$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Gombe")
Imo_all_mcpr <-results_Imo$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Imo")
Jigawa_all_mcpr <-results_Jigawa$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Jigawa")
Kaduna_all_mcpr <-results_Kaduna$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Kaduna")
Kano_all_mcpr <-results_Kano$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Kano")
Katsina_all_mcpr <-results_Katsina$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Katsina")
Kebbi_all_mcpr <-results_Kebbi$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Kebbi")
Kogi_all_mcpr <-results_Kogi$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Kogi")
Kwara_all_mcpr <-results_Kwara$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Kwara")
Lagos_all_mcpr <-results_Lagos$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Lagos")
Nasarawa_all_mcpr <-results_Nasarawa$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Nasarawa")
Niger_all_mcpr <-results_Niger$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Niger")
Ogun_all_mcpr <-results_Ogun$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Ogun")
Ondo_all_mcpr <-results_Ondo$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Ondo")
Osun_all_mcpr <-results_Osun$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Osun")
Oyo_all_mcpr <-results_Oyo$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Oyo")
Plateau_all_mcpr <-results_Plateau$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Plateau")
Rivers_all_mcpr <-results_Rivers$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Rivers")
Sokoto_all_mcpr <-results_Sokoto$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Sokoto")
Taraba_all_mcpr <-results_Taraba$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Taraba")
Yobe_all_mcpr <-results_Yobe$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Yobe")
Zamfara_all_mcpr <-results_Zamfara$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Zamfara")

full_data <- bind_rows(Abia_all_mcpr,
                       Abuja_all_mcpr,
                       Adamawa_all_mcpr,
                       AkwaIbom_all_mcpr,
                       Anambra_all_mcpr,
                       Bauchi_all_mcpr,
                       Bayelsa_all_mcpr,
                       Benue_all_mcpr,
                       Borno_all_mcpr,
                       CrossRiver_all_mcpr,
                       Delta_all_mcpr,
                       Ebonyi_all_mcpr,
                       Edo_all_mcpr,
                       Ekiti_all_mcpr,
                       Enugu_all_mcpr,
                       Gombe_all_mcpr,
                       Imo_all_mcpr,
                       Jigawa_all_mcpr,
                       Kaduna_all_mcpr,
                       Kano_all_mcpr,
                       Katsina_all_mcpr,
                       Kebbi_all_mcpr,
                       Kogi_all_mcpr,
                       Kwara_all_mcpr,
                       Lagos_all_mcpr,
                       Nasarawa_all_mcpr,
                       Niger_all_mcpr,
                       Ogun_all_mcpr,
                       Ondo_all_mcpr,
                       Osun_all_mcpr,
                       Oyo_all_mcpr,
                       Plateau_all_mcpr,
                       Rivers_all_mcpr,
                       Sokoto_all_mcpr,
                       Taraba_all_mcpr,
                       Yobe_all_mcpr,
                       Zamfara_all_mcpr) %>% mutate(Population="ALL")

write.csv(full_data, "C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Nigeria/Prep Data/StateFPETRunsAW.csv", row.names=F, na="")
