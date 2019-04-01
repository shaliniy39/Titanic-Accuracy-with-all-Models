#import dataset
dataset = read.csv("training titanic.csv")
dataset = dataset[c(2,3,5:8)]
dataset2 = read.csv("test_titanic.csv")
dataset2 = dataset2[c(2,4:7)]
x=nrow(dataset)

#missing data

dataset$Age = ifelse(is.na(dataset$Age), median(dataset$Age,na.rm = TRUE),
                     dataset$Age) 
dataset2$Age = ifelse(is.na(dataset2$Age), median(dataset2$Age,na.rm = TRUE),
                     dataset2$Age) 

#categorical data
dataset$Sex = factor(dataset$Sex,
                     levels = c('female','male'),
                     labels = c(1, 2))
dataset2$Sex = factor(dataset2$Sex,
                     levels = c('female','male'),
                     labels = c(1, 2))
#multiple linear regression

regressor = lm(formula = Survived ~ .,dataset)

#predict test results
y_pred = predict(regressor, newdata = dataset2)

dig_pred = ifelse(y_pred >= 0.5, 1, 0)

#install.packages('ggplot2')
library(ggplot2)
df <- data.frame(dataset)
ggplot(data = dataset,aes(x = Sex))+ 
  geom_bar(stat = "count",aes(fill = "Sex"))
# ggplot()+
#   geom_bar(data = dataset,aes(x = Survived,y = Age),
#            stat = "identity" ,width = 0.5,color = "red") +
#   geom_bar(data = dataset,aes(x = Survived,y = Pclass),
#            stat = "identity" ,width = 0.5,color = "red")
# 


              