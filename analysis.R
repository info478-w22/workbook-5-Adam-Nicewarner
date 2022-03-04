# Workbook 6: analyze NHANES data

# Set up
library(foreign)
library(survey)
library(Hmisc)

demog <- sasxport.get('DEMO_I.XPT')
alc <- sasxport.get('ALQ_I.XPT')
merged <- merge(x = demog, y = alc, by = "seqn")

# The sample weight for demographics is wtint2yr or wtmec2yr, showing how we should weigh these numbers to try and get a representative sample of the population. 
sum(demog$wtint2yr)
sum(demog$wtmec2yr)
# These numbers are different, but sum up to be the same, they should be about the population of america, around 300 million. 