# Predicting Diabetes
# Author: Daniel Ifenna
# Date: 23rd Feburary, 2025.

This project makes use of various Machine Learning (ML) algorithms to predict outcomes such as **"Diabetic"** or **"Not Diabetic"** based on the following variables:  
`Age, Pregnancies, BMI, Glucose, BloodPressure, HbA1c, LDL, HDL, Triglycerides, WaistCircumference, HipCircumference, WHR, FamilyHistory, DietType, Hypertension, MedicationUse.`  

It is important to note that the target variable is the **Outcome** column, which has been converted to a factor, as stated earlier.  

In this project, the following ML algorithms are used:  
- K-Nearest Neighbors (KNN)  
- Decision Tree  
- One Rule (1R)  
- JRIP
## Performance of models
Prediction Model Performance
The following models achieved impressive accuracy levels:

1. K-Nearest Neighbors (KNN): 96.2% accuracy
2. Decision Tree: 100% accuracy
3. One Rule Model: 95% accuracy
4. JRip Model: 100% accuracy

The Decision Tree and JRip models demonstrated perfect prediction accuracy, while KNN and One Rule Model showed strong performance.
## Interpretation of the Decision Tree:
This decision tree shows how key features—Family History and Glucose Level—are used to predict whether an individual is Diabetic or Not Diabetic.

### Interpretation of the Nodes:
Root Node (FamilyHistory)

[](Screenshot%202025-04-20%20192819.png)

Split Condition: The first and most important factor in the tree is FamilyHistory:

If FamilyHistory ≤ 0 (no family history of diabetes), the person is likely Not Diabetic (Node 3).

If FamilyHistory > 0 (a positive family history), the tree groups individuals as diabetic (Node 5)

for those whose family history is <= 0 the tree then split based on glucose

Second-Level Split: Glucose Level


If Glucose ≤ 140, the individual is classified as Not Diabetic (Node 3).

If Glucose > 140, the individual is classified as Diabetic (Node 4).

![Download report](https://github.com/daniel-ifenna/Predicting-Diabetes/blob/f6ece09c9670c61bf8c9b58ada60d3c66a929072/Diabetic-report.docx)
