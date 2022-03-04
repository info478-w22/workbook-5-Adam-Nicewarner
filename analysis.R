# Workbook 6: analyze NHANES data

# Set up
library(foreign)
library(survey)
library(Hmisc)
library(openintro)
library(tidyverse)
library(ggplot2)

demog <- sasxport.get('DEMO_I.XPT')
alc <- sasxport.get('ALQ_I.XPT')
merged <- merge(x = demog, y = alc, by = "seqn", all=TRUE)

# The sample weight for demographics is wtint2yr or wtmec2yr, showing how we should weigh these numbers to try and get a representative sample of the population. 
sum(demog$wtint2yr)
sum(demog$wtmec2yr)
# These numbers are different, but sum up to be the same, they should be about the population of america, around 300 million. 
# They represent slightly different things in the survey, but you would want to use the MEC one for this analysis, as it references things asked about in the MEC survey.

merged$alq151(merged$alq151 ==2) <- 0
merged$alq151(merged$alq151 ==7) <- NA
merged$alq151(merged$alq151 ==9) <- NA

design <- svydesign(id=~sdmvpsu, nest=TRUE, strata=~sdmvstra, weights=~wtint2yr,data=merged)

  
nhanes_mean <- svymean(~alq151, design, na.rm=TRUE)

gender_perc <- svyby(~alq151, ~riagendr ,design, svymean, na.rm=TRUE)