
prepar_data <- function(x){
  
  #reading the data
  data <- read.csv(x , sep = ",", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
  
  #-----------------------------------------------------------------------------------------------------
  #outliers function
  
  remove_outlier <- function(x){
    
    qnt <- quantile(x, probs=c(.25, .75), na.rm = T)
    caps <- quantile(x, probs=c(.05, .95), na.rm = T)
    H <- 1.5 * IQR(x, na.rm = T)
    x[x < (qnt[1] - H)] <- caps[1]
    x[x > (qnt[2] + H)] <- caps[2]
     
    return(x)
  }
  
  #-----------------------------------------------------------------------------------------------------
  #changing charecter to date 
  
  data$order_date <- ymd(data$order_date)
  data$delivery_date <- ymd(data$delivery_date)
  data$user_dob <- ymd(data$user_dob)
  data$user_reg_date <- ymd(data$user_reg_date)
  
  #-----------------------------------------------------------------------------------------------------
  ##dealing with item_size 
  
  data$item_size[data$item_size == "10+"] <- "10"
  data$item_size[data$item_size == "11+"] <- "11"
  data$item_size[data$item_size == "12+"] <- "12"
  data$item_size[data$item_size == "2+"] <- "2"
  data$item_size[data$item_size == "3+"] <- "3"
  data$item_size[data$item_size == "36+"] <- "36"
  data$item_size[data$item_size == "37+"] <- "37"
  data$item_size[data$item_size == "38+"] <- "38"
  data$item_size[data$item_size == "39+"] <- "39"
  data$item_size[data$item_size == "4+"] <- "4"
  data$item_size[data$item_size == "40+"] <- "40"
  data$item_size[data$item_size == "41+"] <- "41"
  data$item_size[data$item_size == "42+"] <- "42"
  data$item_size[data$item_size == "43+"] <- "43"
  data$item_size[data$item_size == "44+"] <- "44"
  data$item_size[data$item_size == "45+"] <- "45"
  data$item_size[data$item_size == "46+"] <- "46"
  data$item_size[data$item_size == "5+"] <- "5"
  data$item_size[data$item_size == "6+"] <- "6"
  data$item_size[data$item_size == "7+"] <- "7"
  data$item_size[data$item_size == "8+"] <- "8"
  data$item_size[data$item_size == "9+"] <- "9"
  
  data$item_size[data$item_size == "l"] <- "L"
  data$item_size[data$item_size == "m"] <- "M"
  data$item_size[data$item_size == "s"] <- "S"
  data$item_size[data$item_size == "xl"] <- "XL"
  data$item_size[data$item_size == "xs"] <- "XS"
  data$item_size[data$item_size == "xxl"] <- "XXL"
  data$item_size[data$item_size == "xxxl"] <- "XXXL"
  
  data$item_size[data$item_size == "2932"] <- "31"
  data$item_size[data$item_size == "3334"] <- "34"
  data$item_size[data$item_size == "3834"] <- "38"
  data$item_size[data$item_size == "4032"] <- "40"
  data$item_size[data$item_size == "3634"] <- "36"
  data$item_size[data$item_size == "3434"] <- "34"
  data$item_size[data$item_size == "3432"] <- "34"
  data$item_size[data$item_size == "3832"] <- "38"
  data$item_size[data$item_size == "3632"] <- "36"
  data$item_size[data$item_size == "3332"] <- "32"
  
  # extra care for matching the test data with the training data 
  data$item_size[data$item_size == "3132"] <- "32"
  data$item_size[data$item_size == "4034"] <- "40"
  data$item_size[data$item_size == "49"] <- "48"
  data$item_color[data$item_color == "cortina mocca"] <- "mocca"
  #data$item_color[data$item_color == "avocado"] <- "green"
  
  #unique(names(table(data$item_size)))
  #sort(table(data$item_size))
  
  #------------------------------------------------------------------------------------------------------------
  #changing categorial data to factors
  
  data$item_size <- as.factor(data$item_size)
  data$item_color <- as.factor(data$item_color)
  data$user_title <- as.factor(data$user_title)
  data$user_state <- as.factor(data$user_state)
  #if(x == "BADS_WS1718_known.csv") data$return <- as.factor(data$return)
  
  #------------------------------------------------------------------------------------------------------------
  #dealing with missing values in item_color 
  #sort(table(data$item_color))
  data$item_color[is.na(data$item_color)] <- "black"
  #any(is.na(data$item_color))
  
  
  #-----------------------------------------------------------------------------------------------------------
  # item_price
  
  #dealing with missing values an dreplace them with mean
  data$item_price[data$item_price == 0] <- NA
  data$item_price[is.na(data$item_price) == TRUE] <- mean(data$item_price, na.rm = TRUE)
  #summary(data$item_price)
  #boxplot(data$item_price)
  #removing outliers
  data$item_price <- remove_outlier(data$item_price)
  #boxplot(data$item_price)
  
  #------------------------------------------------------------------------------------------------------------
  #user_dob (missing Values and outliers)
  
  #delete the NA values for the data frame based on the date of the birth
  #data <- data[complete.cases(data[, "user_dob"]), ]
  
  data$user_dob[is.na(data$user_dob) == TRUE] <- mean(data$user_dob, na.rm = TRUE)
  
  # checking if there is an order_date bigger than birth_date
  #a <- tbl_data %>% select(user_id ,user_dob, order_date) %>% filter(order_date <= user_dob)
  #add the age column to the data fram 
  data$age <- age_calc(data$user_dob, enddate =  data$order_date, units = "years")
  
  # deal with outliers in the age column 
  #boxplot(data$age)
  data$age <- remove_outlier(data$age)
  #boxplot(data$age)
  
  #------------------------------------------------------------------------------------------------------------
  
  # calculating membership duration 
  
  # checking if there is an user_reg_date bigger than order_date
  # there are a lot of people that they have ordered an item in the same day of registerration 
  #a <- tbl_data %>% select(user_id ,user_reg_date, order_date) %>% filter(order_date < user_reg_date)
  data$membership_duration <- as.numeric(difftime(time1 = data$order_date, time2 = data$user_reg_date, units = "weeks"))
  
  #-------------------------------------------------------------------------------------------------------------
  
  #deal with delivery date
  
  #eliminating the outliers in the delivery_date, it is stuck in 1990-12-31 for 959 observation 
  data[(is.na(data$delivery_date) == FALSE) & (data$delivery_date < ymd("2012-04-01")), "delivery_date"] <- NA 
  
  #calculating delivery_time
  data$delivery_time <- as.numeric(data$delivery_date - data$order_date)
  
  #using linear regression to predict the missing values in delivery time
  #cutting my data into trainging and test, test contain the missing values
  df <- data[(is.na(data$delivery_time) == FALSE), c("delivery_time", "item_size", "item_price", "user_state")]
  tf <- data[(is.na(data$delivery_time) == TRUE), c("item_size", "item_price", "user_state")]
  #changing the level 105 to 104 because 105 does not exsist in the training date 
  a <- as.character(levels(tf$item_size))[tf$item_size]
  a[a == "105"] <- "104"
  a <- as.factor(a)
  tf$item_size <- a
  #creating the model and assigning the predicted values to the missing positions 
  lr <- lm(delivery_time ~ item_size + item_price + user_state, data = df)
  pred.lr <- predict(lr, newdata = tf)
  #summary(pred.lr)
  data[(is.na(data$delivery_time) == TRUE), "delivery_time"] <- pred.lr

  #data$delivery_time <- remove_outlier(data$delivery_time)
  #boxplot(data$delivery_time)
  
  return(data)
  
}
