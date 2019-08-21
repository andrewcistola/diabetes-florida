Pre-Diabetes in Management Care Project

Cost Component

This project is a component of the PreDiabetes prevention and cost study conducted in HSRMP with UF Health. 

Record 

8/21

Using Python:

Nhanes_merged_raw.xlsx file read into Python
Created new column UndgDM based on 
DIQ10 not being 1 (no diabetes diagnosis)
DIQ010 not being 1 (no prediabetes diagnosis)
LBGXGH over 6.4
1 = undiagnosed dm, 2 = no
Created new column based on 
DIQ10 not being 1 (no diabetes diagnosis)
DIQ010 not being 1 (no prediabetes diagnosis)
UndgDM not being 1 (not undiagnosed DM)
LBGXGH between 5.7 and 6.4
1 = undiagnosed pd, 2 = no
		“Prediabetes” or “Healthy or Unknown”
Wrote to csv with added columns nhanes_merged_undg_staged.csv
Subset by RIDAGEYR 40-70
BMXBMI over 25
Removed all extra columns
Grouped by WTMECYR (MEC weights)
Exported table and created plots




	
