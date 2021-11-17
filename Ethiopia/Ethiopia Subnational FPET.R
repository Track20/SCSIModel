# Subnational FPET Ethiopia

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
allstate <- read.csv("C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/Ethiopia Subnational Surveys_survey.csv")  %>% rename(division_numeric_code=unit_numeric_code) %>%
  mutate(division_numeric_code=as.numeric(division_numeric_code)) %>%
  mutate(region_code=case_when(region_code=="Addis Adaba" ~ "AddisAdaba",
                               region_code=="Afar"        ~ "Afar",
                               region_code=="Amhara"      ~ "Amhara",
                               region_code=="Benishangul" ~ "Benishangul",
                               region_code=="Dire Dawa"   ~ "DireDawa",
                               region_code=="Gambela"     ~ "Gambela",
                               region_code=="Harari"      ~ "Harari",
                               region_code=="Oromia"      ~ "Oromia",
                               region_code=="SNNPR"       ~ "SNNPR",
                               region_code=="Somali"      ~ "Somali",
                               region_code=="Tigray"~ "Tigray"))


names(allstate)

# Create files for each state
AddisAdaba <- allstate %>% filter(region_code=="AddisAdaba")
Afar <- allstate %>% filter(region_code=="Afar")
Amhara <- allstate %>% filter(region_code=="Amhara")
Benishangul <- allstate %>% filter(region_code=="Benishangul")
DireDawa <- allstate %>% filter(region_code=="DireDawa")
Gambela <- allstate %>% filter(region_code=="Gambela")
Harari <- allstate %>% filter(region_code=="Harari")
Oromia <- allstate %>% filter(region_code=="Oromia")
SNNPR <- allstate %>% filter(region_code=="SNNPR")
Somali <- allstate %>% filter(region_code=="Somali")
Tigray <- allstate %>% filter(region_code=="Tigray")

setwd("C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey")
write.csv(AddisAdaba, "EthiopiaSurvey_AddisAdaba.csv", row.names=F, na="")
write.csv(Afar, "EthiopiaSurvey_Afar.csv", row.names=F, na="")
write.csv(Amhara, "EthiopiaSurvey_Amhara.csv", row.names=F, na="")
write.csv(Benishangul, "EthiopiaSurvey_Benishangul.csv", row.names=F, na="")
write.csv(DireDawa, "EthiopiaSurvey_DireDawa.csv", row.names=F, na="")
write.csv(Gambela, "EthiopiaSurvey_Gambela.csv", row.names=F, na="")
write.csv(Harari, "EthiopiaSurvey_Harari.csv", row.names=F, na="")
write.csv(Oromia, "EthiopiaSurvey_Oromia.csv", row.names=F, na="")
write.csv(SNNPR, "EthiopiaSurvey_SNNPR.csv", row.names=F, na="")
write.csv(Somali, "EthiopiaSurvey_Somali.csv", row.names=F, na="")
write.csv(Tigray, "EthiopiaSurvey_Tigray.csv", row.names=F, na="")


file_AddisAdaba <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey/EthiopiaSurvey_AddisAdaba.csv"
file_Afar <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey/EthiopiaSurvey_Afar.csv"
file_Amhara <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey/EthiopiaSurvey_Amhara.csv"
file_Benishangul <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey/EthiopiaSurvey_Benishangul.csv"
file_DireDawa <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey/EthiopiaSurvey_DireDawa.csv"
file_Gambela <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey/EthiopiaSurvey_Gambela.csv"
file_Harari <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey/EthiopiaSurvey_Harari.csv"
file_Oromia <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey/EthiopiaSurvey_Oromia.csv"
file_SNNPR <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey/EthiopiaSurvey_SNNPR.csv"
file_Somali <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey/EthiopiaSurvey_Somali.csv"
file_Tigray <-"C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/State Survey/EthiopiaSurvey_Tigray.csv"




pop <- read.csv("C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/Ethiopia Population Subnational_population.csv")  %>% rename(division_numeric_code=unit_numeric_code) %>%
  mutate(division_numeric_code=as.numeric(division_numeric_code)) %>%
  mutate(region_code=case_when(region_code=="Addis Adaba" ~ "AddisAdaba",
                               region_code=="Afar"        ~ "Afar",
                               region_code=="Amhara"      ~ "Amhara",
                               region_code=="Benishangul" ~ "Benishangul",
                               region_code=="Dire Dawa"   ~ "DireDawa",
                               region_code=="Gambela"     ~ "Gambela",
                               region_code=="Harari"      ~ "Harari",
                               region_code=="Oromia"      ~ "Oromia",
                               region_code=="SNNPR"       ~ "SNNPR",
                               region_code=="Somali"      ~ "Somali",
                               region_code=="Tigray"~ "Tigray"))

pop_AddisAdaba <- pop %>% filter(region_code=="AddisAdaba")
pop_Afar <- pop %>% filter(region_code=="Afar")
pop_Amhara <- pop %>% filter(region_code=="Amhara")
pop_Benishangul <- pop %>% filter(region_code=="Benishangul")
pop_DireDawa <- pop %>% filter(region_code=="DireDawa")
pop_Gambela <- pop %>% filter(region_code=="Gambela")
pop_Harari <- pop %>% filter(region_code=="Harari")
pop_Oromia <- pop %>% filter(region_code=="Oromia")
pop_SNNPR <- pop %>% filter(region_code=="SNNPR")
pop_Somali <- pop %>% filter(region_code=="Somali")
pop_Tigray <- pop %>% filter(region_code=="Tigray")


fit_AddisAdaba <-fit_fp_c(  surveydata_filepath = file_AddisAdaba,  division_numeric_code= 231,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Afar <-fit_fp_c(  surveydata_filepath = file_Afar,  division_numeric_code= 231,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Amhara <-fit_fp_c(  surveydata_filepath = file_Amhara,  division_numeric_code= 231,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Benishangul <-fit_fp_c(  surveydata_filepath = file_Benishangul,  division_numeric_code= 231,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_DireDawa <-fit_fp_c(  surveydata_filepath = file_DireDawa,  division_numeric_code= 231,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Gambela <-fit_fp_c(  surveydata_filepath = file_Gambela,  division_numeric_code= 231,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Harari <-fit_fp_c(  surveydata_filepath = file_Harari,  division_numeric_code= 231,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Oromia <-fit_fp_c(  surveydata_filepath = file_Oromia,  division_numeric_code= 231,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_SNNPR <-fit_fp_c(  surveydata_filepath = file_SNNPR,  division_numeric_code= 231,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Somali <-fit_fp_c(  surveydata_filepath = file_Somali,  division_numeric_code= 231,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)
fit_Tigray <-fit_fp_c(  surveydata_filepath = file_Tigray,  division_numeric_code= 231,  is_in_union = "ALL", first_year = 1970, last_year = 2030,  subnational = TRUE)


results_AddisAdaba <-calc_fp_c(fit_AddisAdaba,  population_data = pop_AddisAdaba)
results_Afar <-calc_fp_c(fit_Afar,  population_data = pop_Afar)
results_Amhara <-calc_fp_c(fit_Amhara,  population_data = pop_Amhara)
results_Benishangul <-calc_fp_c(fit_Benishangul,  population_data = pop_Benishangul)
results_DireDawa <-calc_fp_c(fit_DireDawa,  population_data = pop_DireDawa)
results_Gambela <-calc_fp_c(fit_Gambela,  population_data = pop_Gambela)
results_Harari <-calc_fp_c(fit_Harari,  population_data = pop_Harari)
results_Oromia <-calc_fp_c(fit_Oromia,  population_data = pop_Oromia)
results_SNNPR <-calc_fp_c(fit_SNNPR,  population_data = pop_SNNPR)
results_Somali <-calc_fp_c(fit_Somali,  population_data = pop_Somali)
results_Tigray <-calc_fp_c(fit_Tigray,  population_data = pop_Tigray)


AddisAdaba_all_mcpr <-results_AddisAdaba$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="AddisAdaba")
Afar_all_mcpr <-results_Afar$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Afar")
Amhara_all_mcpr <-results_Amhara$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Amhara")
Benishangul_all_mcpr <-results_Benishangul$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Benishangul")
DireDawa_all_mcpr <-results_DireDawa$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="DireDawa")
Gambela_all_mcpr <-results_Gambela$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Gambela")
Harari_all_mcpr <-results_Harari$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Harari")
Oromia_all_mcpr <-results_Oromia$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Oromia")
SNNPR_all_mcpr <-results_SNNPR$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="SNNPR")
Somali_all_mcpr <-results_Somali$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Somali")
Tigray_all_mcpr <-results_Tigray$ALL$contraceptive_use_modern %>% rename(contraceptive_use_modern=value) %>% filter(percentile=="50%") %>% mutate(Region="Tigray")

full_data <- bind_rows(AddisAdaba_all_mcpr,
                       Afar_all_mcpr,
                       Amhara_all_mcpr,
                       Benishangul_all_mcpr,
                       DireDawa_all_mcpr,
                       Gambela_all_mcpr,
                       Harari_all_mcpr,
                       Oromia_all_mcpr,
                       SNNPR_all_mcpr,
                       Somali_all_mcpr,
                       Tigray_all_mcpr
) %>% mutate(Population="ALL")

write.csv(full_data, "C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/EthiopiaRegionFPETRunsAW.csv", row.names=F, na="")
