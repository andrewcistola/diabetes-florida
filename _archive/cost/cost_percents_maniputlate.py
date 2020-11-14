#### Diabetes Status and Costs
### Group Percent Manipulation
## Code Script by DrewC!

### Section 1: Improt Libraries, Import Dataset, Prepare for Classification

## Import Standard Libraries
import os # Inlcuded in every script DC!
import numpy as np # Inclduded in every code script DC!
import pandas as pd # Incldued in every code script for DC!

## Import Dataset
os.chdir("C:/Users/drewc/GitHub/PreDM") # Set wd to project repository
df_nh = pd.read_csv("_data/cost_percents_stage.csv", encoding = "ISO-8859-1") # Import dataset, all datasets in _data folder in repository

## Verify
df_nh.info()
df_nh.head()

### Section 2: Identify Population Totals for Risk and Status

## Create Population Totals Subset
df_pop = df_nh
df_pop = df_pop[df_pop["BMI"].str.contains("Total BMI")] # Select only total BMI
df_pop = df_pop[df_pop["Age"].str.contains("Total Age")]
df_pop = df_pop[df_pop["Race"].str.contains("Total Race")]
df_pop = df_pop[df_pop["Gender"].str.contains("Total Gender")]
df_pop = df_pop[~df_pop["Risk"].str.contains("Total Risk")]

df_pop = df_pop.drop(columns = ["Age", "Race", "Gender", "BMI"])

## Verify
df_pop.head(30)

## Write Summary to Text File
text_file = open("cost/cost_population_percents_results.txt", "w") # Open text file and name with subproject, content, and result suffix
text_file.write(str("Percent of Population with Diabetes Status by Risk"))
text_file.write(str(df_pop.head(30))) # write string version of summary result
text_file.close() # Close file

## Export to CSV
df_pop.to_csv("cost/cost_population_percents_results.csv")

### Section 3: Percent of Undaignosed Prediabetes in At Risk Group by Demographics 

## Isolate Undiagnosed Prediabetes
df_unPD = df_nh[df_nh["Status"].str.contains("Undiagnosed Prediabetes")] # Subset by status
df_risk = df_unPD[df_unPD["Risk"].str.contains("At risk")] # Subset by risk
df_risk = df_risk[df_risk["BMI"].str.contains("Total BMI")]
df_risk = df_risk.drop(columns = ["Risk", "BMI"])

## Isolate Undiagnosed Prediabetes Totals for Age
df_age = df_risk
df_age = df_age[df_age["Race"].str.contains("Total Race")]
df_age = df_age[df_age["Gender"].str.contains("Total Gender")]
df_age = df_age.drop(columns = ["Race", "Gender"])

## Verify
df_age.head(30)

## Write Summary to Text File
text_file = open("cost/cost_unPD_percents_results.txt", "w") # Open text file and name with subproject, content, and result suffix
text_file.write(str("Percent of Undaignosed Prediabetes in At Risk Group by Demographics"))
text_file.write(str(df_age.head(30))) # write string version of summary result
text_file.close() # Close file

## Isolate Totals for Race
df_race = df_risk
df_race = df_race[df_race["Age"].str.contains("Total Age")]
df_race = df_race[df_race["Gender"].str.contains("Total Gender")]
df_race = df_race.drop(columns = ["Age", "Gender"])

## Verify
df_race.head(30)

## Write Summary to Text File
text_file = open("cost/cost_unPD_percents_results.txt", "a") # Open text file and name with subproject, content, and result suffix
text_file.write(str(df_race.head(30))) # write string version of summary result
text_file.close() # Close file

## Isolate Totals for Gender
df_gndr = df_risk
df_gndr = df_gndr[df_gndr["Age"].str.contains("Total Age")]
df_gndr = df_gndr[df_gndr["Race"].str.contains("Total Race")]
df_gndr = df_gndr.drop(columns = ["Age", "Race"])

## Verify
df_gndr.head(30)

## Write Summary to Text File
text_file = open("cost/cost_unPD_percents_results.txt", "a") # Open text file and name with subproject, content, and result suffix
text_file.write(str(df_gndr.head(30))) # write string version of summary result
text_file.close() # Close file

### Section 4: Identify Top Groups by Percent with Undiagnosed Prediabetes and Not at Risk

## Isolate Undiagnosed Prediabetes and Risk
df_unPD = df_nh[df_nh["Status"].str.contains("Undiagnosed Prediabetes")] # Subset by status
df_nrisk = df_unPD[df_unPD["Risk"].str.contains("Not at risk")] # Subset by not at risk
df_nrisk = df_nrisk.drop(columns = ["Risk"])

## Remove Population Totals
df_tot = df_nrisk
df_tot = df_tot[~df_tot["Age"].str.contains("Total Age")]
df_tot = df_tot[~df_tot["Race"].str.contains("Total Race")]
df_tot = df_tot[~df_tot["Gender"].str.contains("Total Gender")]
df_tot = df_tot[~df_tot["BMI"].str.contains("Total BMI")]

## Sort by Group Percentages
df_sort = df_tot
df_sort = df_sort[df_PD["N"] > 20] # Subset by groups with more than 20 surveyed
df_sort = df_sort.sort_values(by = ["Percent"], ascending = False) # Sort by column value

## Verify
df_sort.head(20) # Show top 20 observations

## Write Summary to Text File
text_file = open("Teen/teen_unPD_percents_results.txt", "w") # Open text file and name with subproject, content, and result suffix
text_file.write(str("Top Groups by Percent with Undiagnosed Prediabetes and Not at Risk"))
text_file.write(str(df_sort.head(20))) # write string version of summary result
text_file.close() # Close file

## Export to CSV
df_sort.to_csv("teen/teen_unPD_percents_results.csv")
















