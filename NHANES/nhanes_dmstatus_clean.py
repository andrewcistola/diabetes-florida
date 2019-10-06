#### Prep Code: import libraries, set wd, import data

import os
import numpy as np
import pandas as pd

os.chdir("C:/Users/drewc/GitHub/PreDM")

df = pd.read_csv("_data/nhanes_dmstatus_staged.csv", encoding = "ISO-8859-1")
df.info()

#### Drop all rows with NA values

dfna = df.dropna()
dfna.info()

#### Write to CSV

dfna.to_csv("_data/nhanes_dmstatus_ready.csv")

