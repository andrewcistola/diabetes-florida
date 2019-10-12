#### NHANES Population Counts
### Post SUDAAN Data Manipulation
## Code Script by DrewC!

### Section 1: Improt Libraries, Import Dataset, Prepare for Classification

## Import Standard Libraries
import os # Inlcuded in every script DC!
import numpy as np # Inclduded in every code script DC!
import pandas as pd # Incldued in every code script for DC!

## Import Dataset
os.chdir("C:/Users/drewc/GitHub/PreDM") # Set wd to project repository
df_nh = pd.read_csv("_data/nhanes_dmstatus_sudaan_raw.csv", encoding = "ISO-8859-1") # Import dataset with outcome and ecological variable for each geographical id, all datasets in _data folder in repository

## Tidy Data Types and Missing Values
df_nh = df_rf.apply(pd.to_numeric, errors = "coerce") # Convert all columns to numeric
df_nh = df_rf.dropna() # Drop all rows with NA values

## Verify
df_nh.info()
df_nh.head()

### Section 2: Group by Population Percent











