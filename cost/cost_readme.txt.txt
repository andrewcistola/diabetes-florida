Pre-Diabetes in Management Care Project

Cost Component

This project is a component of the PreDiabetes prevention and cost study conducted in HSRMP with UF Health. 

Record 

8/21
nhanes_merged_raw.xlsx file staged in excel for analysis in python
	isolated the following variables
		SEQN Respondent sequence number, renamed ID
		WTINT2YR Full sample 2 year interview weight, renamed Interview Weight
		WTMEC2YR Full sample 2 year MEC exam weight, renamed ExamWeight
		DIQ010 Doctor told you have diabetes
		DIQ160 Ever told you have prediabetes
		LBXGH Glycohemoglobin (%), renamed HbA1c
	New categorical Variables Told Diagnosis
		All obs with DIQ10 value 1, were given Told Diagnosis: Diabetes
		All obs with DIQ10 value 2, were given ToldDiagnsis: Healthy
		All obs with DIQ10 value 3, were given ToldDiagnosis: Borderline
		All obs with DIQ160 value 1, were given ToldDiagnosis: Prediabetes
		All obs with DIQ160 value 2, were given ToldDiagnosis: Healthy
		All obs with D1Q160 and DIQ10 value missing were given ToldDiagnosis: NA
	New categorical Variables LabDiagnosis
		All obs with HbA1c value <5.7, were given LabDiagnosis: Healthy
		All obs with HbA1c value 5.7-6.4, were given LabDiagnsis: PreDiabetes
		All obs with HbA1c value >6.4, were given LabDiagnosis: Diabetes
		All obs with HbA1c value missing were given LabDiagnosis: NA	
	All Missing Vlaues in HbA1c converted to NA
	ID converted to number (integer)
	HbA1c converted to number (1 deicmal)
	InterviewWeight converted to number (5 decimals)
	ExamWeight converted to number (5 decimals)
saved as nhanes_cost_stage in PreDM/cost

		



	
