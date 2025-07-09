# data load
data <- read.csv("data.csv")

# Load required libraries
library(tidyverse)
library(caret)
library(e1071)
library(rpart)
library(randomForest)


# View the structure
str(data)

# Check for missing values
colSums(is.na(data))

data <- na.omit(data)
colSums(is.na(data))

# Convert target variable to factor (Converting them to factor tells R: “These are categorical features.)
data$Loan_ID <- as.factor(data$Loan_ID)
data$Gender <- as.factor(data$Gender)
data$Married <- as.factor(data$Married)
data$Education <- as.factor(data$Education)
data$Self_Employed <- as.factor(data$Self_Employed)
data$Property_Area <- as.factor(data$Property_Area)

data$Loan_Status <- as.factor(data$Loan_Status)

# Split into training and testing
# Ensures consistent, repeatable results
set.seed(123)
trainIndex <- createDataPartition(data$Loan_Status, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]  # Create training set
testData  <- data[-trainIndex, ]
# Remove Loan_ID column from both train and test dataset
# because Loan_ID column is not a predictor,so,It has no relationship
trainData <- trainData[ , !(names(trainData) %in% c("Loan_ID"))]
testData <- testData[ , !(names(testData) %in% c("Loan_ID"))]


sapply(trainData, function(x) if(is.factor(x)) length(levels(x)) else NA)


#Train ML Model
# random forest
rf_model <- randomForest(Loan_Status ~ ., data = trainData)
pred_rf <- predict(rf_model, testData)
confusionMatrix(pred_rf, testData$Loan_Status)

#check class balance
table(trainData$Loan_Status)

# Get the exact column names used in the model
predictors <- names(trainData)
predictors <- predictors[!predictors %in% "Loan_Status"]  # exclude target

# Create a new applicant with exactly those columns
new_applicant <- data.frame(
  Gender = factor("Male", levels = levels(trainData$Gender)),
  Married = factor("Yes", levels = levels(trainData$Married)),
  Dependents = as.integer(1),
  Education = factor("Graduate", levels = levels(trainData$Education)),
  Self_Employed = factor("No", levels = levels(trainData$Self_Employed)),
  ApplicantIncome = as.integer(5000),
  CoapplicantIncome = as.numeric(2000),
  LoanAmount = as.integer(150),
  Loan_Amount_Term = as.integer(360),
  Credit_History = as.integer(1),
  Property_Area = factor("Urban", levels = levels(trainData$Property_Area))
)

#check data type are correct or not
sapply(trainData[, predictors], class)
sapply(new_applicant, class)


# Reorder columns to match training data
new_applicant <- new_applicant[, predictors]

# Now prediction will work
predict(rf_model, new_applicant)






