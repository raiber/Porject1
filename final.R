
# email: alkurdra@hu-berlin.de

#set the dircetory 
setwd("C:/Users/Raiber/Desktop/HU Lectures/Business Analytics & Data Science/Assignment_BADS_WS1718")
wdir <- getwd()

#-----------------------------------------------------------------------------------------------------------------------------

#upload libraries
# library(dplyr)
if(!require("lubridate")) install.packages("lubridate"); library("lubridate") # for date type conversation
if(!require("ggplot2")) install.packages("ggplot2"); library("ggplot2")
if(!require("eeptools")) install.packages("eeptools"); library("eeptools") # for calculating age, you have to download package "Coda" to load the library
if(!require("rpart.plot")) install.packages("rpart.plot"); library("rpart.plot")
if(!require("caret")) install.packages("caret"); library("caret") # for partitioning the data
#----------------------------------------------------------------------------------------------------------------

#read and clean the data 

source("clean data.R")
training_data <- prepar_data("BADS_WS1718_known.csv")
prediction_data <- prepar_data("BADS_WS1718_class.csv")

#------------------------------------------------------------------------------------------------------------------
# understanding which features has significant effect on my model 


# s_pValue <- vector(mode="character") #, length = length(training_data)
# ns_pValue <- vector(mode="character")
# num_training_data <-training_data[, c("order_item_id", "item_id", "brand_id", "item_price", "user_id", "age", "membership_duration", "delivery_time")]
# for (i in names(num_training_data)){
#   r0 <- training_data[training_data$return == 0, i]
#   r1 <- training_data[training_data$return == 1, i]
#   test_result <- t.test(r0, r1)
#   if (test_result$p.value < 0.05) {
#     s_pValue[i] <- i
#   } else {
#     ns_pValue[i] <- i
#   }
# }
### even it is not a perfect opration, but from above when can see that only user_id is not significant for my model 

#----------------------------------------------------------------------------------------------------------------------

#fit a linear-model, doesn't work because the problem is classification 

#lr <- lm(return ~ order_item_id + item_id + item_size + item_color + brand_id + item_price + user_id + user_title + age + delivery_time + membership_duration , data = training_data)

#pred.lr <- predict(lr, newdata = test_data)
#MAE <- mean(abs(training_data$return - pred.lr))
#MAE

#-------------------------------------------------------------------------------------------------------------

# partitioning the data 
idx.train <- createDataPartition(y = training_data$return, p = 0.75, list = FALSE) # Draw a random, stratified sample including p percent of the data
tr <- training_data[idx.train, ] # training set
ts <-  training_data[-idx.train, ] # test set 

#---------------------------------------------------------------------------------------------------------------

# fitting a logistic regression model 
#based of the training set
lr <- glm(return ~ item_size + item_color + brand_id  + item_price + user_title + user_state  +  age + membership_duration + delivery_time, data = tr, family = binomial(link = "logit"))

# predicting based on the test set 
pred.lr <- predict(lr, newdata = ts, type = "response")

# calculating the class with a threshold of 0.5
glm_pred <- ifelse(pred.lr > 0.5, 1, 0)

#calculating accuracy 
table(glm_pred, ts$return)
accuracy = mean(glm_pred == ts$return)
accuracy

#predicting for the goal database 
class_predict_probability <- predict(lr, newdata = prediction_data, type = "response")
class_predict <- ifelse(class_predict_probability > 0.5, 1, 0)

#adding the predicted return column to the goal database 
prediction_data$return <- class_predict

#writing the file
predicted_file <- prediction_data[, c("order_item_id", "return")]
write.table(predicted_file, file = "593158_Alkurdi.csv", col.names = TRUE, row.names = FALSE, sep = ";")

#----------------------------------------------------------------------------------------------------------------
#knn
# tr1 <- tr[, c("item_size", "item_color", "brand_id", "item_price", "user_title", "user_state", "age", "membership_duration", "delivery_time")]
# ts1 <- ts[, c("item_size", "item_color", "brand_id", "item_price", "user_title", "user_state", "age", "membership_duration", "delivery_time")]
#  
# tr1 <- model.matrix(tr$return ~ item_size + item_color + brand_id  + item_price + user_title + user_state  +  age + membership_duration + delivery_time - 1, data=tr1 )
# ts1 <- model.matrix( ~ item_size + item_color + brand_id  + item_price + user_title + user_state  +  age + membership_duration + delivery_time - 1, data=ts1 )
# setting <- 15:30
# ll <- vector(mode = "list", length = length(setting))
# accuracy <- vector(mode = "numeric", length = length((setting)))
# for(i in 1:length(setting)){
#   q <- knn(train =  tr1, test = ts1, cl = tr$return, k = i + 14)
#   ll[[i]] <- table(q, ts$return)
#   accuracy[i] = mean(q == ts$return)
# }
