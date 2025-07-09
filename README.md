# Loan Approval Prediction

This project implements an automated loan approval prediction system using machine learning techniques in R.
It is designed to assist financial institutions in evaluating loan applications by learning patterns from historical data. 
Manual approval processes are often slow, inconsistent, and subjective — this model provides a data-driven and repeatable alternative.

## Features
__Data Preprocessing__ : Handles missing values and encodes categorical variables

__Train/test split__ : Ensures reliable evaluation using an 80/20 split

**Machine learning model** : Trained using the Random Forest algorithm for classification.

**New application prediction** : Predicts approval status for new, unseen applicants.

**Evaluation** : Includes confusion matrix and accuracy metrics.

## Technologies Used
**R**: Core programming language

**RStudio**: Development environment

**Libraries**:
  - `tidyverse`: Data manipulation and visualization
  - `caret`: Model training and evaluation
  - `randomForest`: Random Forest classifier
  - `e1071`: SVM and other ML utilities

## Methodology

**Load and clean the dataset**  
   - Remove missing values  
   - Convert relevant columns to factors

**Split the data**  
   - 80% for training, 20% for testing  
   - Exclude irrelevant columns like `Loan_ID`

 **Train model**  
   - Use `randomForest()` on the training data  
   - Predict on the test set

**Evaluate model**  
   - Generate a confusion matrix  
   - Check accuracy

**Predict for new applicants**  
   - Create input with the same structure and factor levels  
   - Use the trained model to predict the outcome



