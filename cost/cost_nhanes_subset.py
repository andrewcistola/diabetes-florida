#### Prep Code: import libraries, set wd, import data

import os
import pandas as pd
import numpy as np

os.chdir("C:/Users/drewc/Documents")

df = pd.read_csv("data/topic_sub_type.csv", encoding = "ISO-8859-1")
df.info()

