# Ethiopia Subnational Population for FPET

library(tidyr)
library(dplyr)
library(jsonlite) 
library(haven)
library(data.table)
library(questionr)

nat_pop <- read.csv("C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/Ethiopia Population National_population.csv")

women <- read_dta("C:/Users/KristinBietsch/files/DHS Data/Ethiopia/ETIR81FL.DTA", col_select = any_of(c( "v005", "v024","v502")))

women_data <- women %>%
  mutate(married=case_when(v502==1 ~ 1,
                           v502!=1 ~ 0)) %>%
  mutate(sampleweights=v005/100000) %>%
  mutate(Region=case_when(v024==1 ~ "Tigray",
                          v024==2 ~ "Afar",
                          v024==3 ~ "Amhara",
                          v024==4 ~ "Oromia",
                          v024==5 ~ "Somali",
                          v024==6 ~ "Benishangul",
                          v024==7 ~ "SNNPR",
                          v024==8 ~ "Gambela",
                          v024==9 ~ "Harari",
                          v024==10 ~ "Addis Adaba",
                          v024==11 ~ "Dire Dawa"))

married <- women_data %>% filter(married==1)
unmarried <- women_data %>% filter(married==0)


mar <-    as.data.frame(prop.table(wtd.table(x= as.factor(married$Region),   weights=married$sampleweights ))) %>% rename(Y=Freq) 
unmar <-    as.data.frame(prop.table(wtd.table(x= as.factor(unmarried$Region),   weights=unmarried$sampleweights ))) %>% rename(N=Freq) 

dis <- full_join(mar, unmar, by="Var1") %>% gather(is_in_union, Dist, Y:N)

sub_pop <- full_join(nat_pop, dis, by="is_in_union") %>% mutate(pop_dist=population_count * Dist) %>%
  select(-population_count, -region_code, -Dist) %>%
  rename(population_count = pop_dist,
         region_code=Var1) %>%
  select(unit_numeric_code, is_in_union, age_range, mid_year, population_count, region_code)

write.csv(sub_pop, "C:/Users/KristinBietsch/files/Track20/Win Requests/Self Injections/Subnational/Ethiopia/Ethiopia Population Subnational_population.csv", row.names = F, na="")
