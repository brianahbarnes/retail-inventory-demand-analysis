#import data and check the basics
data <- read.csv("retail_store_inventory_data.csv")
head(data)
dim(data)
names(data)
head(data, 10)
summary(data)



#see which rows have negatives
min(data$Demand.Forecast)
sum(data$Demand.Forecast < 0)
head(data[data$Demand.Forecast < 0, ])



#making clean data by removing the negative demand forecast
clean_data <- data[data$Demand.Forecast >= 0, ]
dim(clean_data)
sum(clean_data$Demand.Forecast < 0)




#look at what categories sell the most
tapply(clean_data$Units.Sold, clean_data$Category, max)#max single sale
tapply(clean_data$Units.Sold, clean_data$Category, sum)#total sale overall
tapply(clean_data$Units.Sold, clean_data$Category, mean)#average sale
#all categories are pretty close but furniture wins




#check demand forecast
tapply(clean_data$Units.Sold - clean_data$Demand.Forecast,
       clean_data$Category,
       mean)
#all were negative so they overestimated sales for all of them




#sales high then demand forecast high
mean(clean_data$Units.Sold)
mean(clean_data$Demand.Forecast)
cor(clean_data$Units.Sold, clean_data$Demand.Forecast)
#high correlation


#graphed the relationship between forecast and actual sales
plot(clean_data$Demand.Forecast,
     clean_data$Units.Sold,
     xlab = "Demand Forecast",
     ylab = "Actual Units Sold",
     main = "Demand Forecast vs Actual Sales")



clean_data$Forecast.Error <- clean_data$Units.Sold - clean_data$Demand.Forecast
summary(clean_data$Forecast.Error)
sd(clean_data$Forecast.Error)
cor(clean_data$Units.Sold, clean_data$Forecast.Error)

tapply(clean_data$Forecast.Error,
       clean_data$Category,
       mean)
#Category sales: fairly similar
#Forecast vs. sales: extremely strong relationship
#Forecast bias: about −5 units
#Forecast error vs. sales: almost no relationship
#Forecast error by category: nearly identical


cor(clean_data$Inventory.Level, clean_data$Units.Sold) #high inventory high sales
cor(clean_data$Units.Ordered, clean_data$Units.Sold) #no correlation between # ordered vs # sold


#inventory vs sales
plot(clean_data$Inventory.Level,
     clean_data$Units.Sold,
     xlab = "Inventory Level",
     ylab = "Units Sold",
     main = "Inventory Level vs. Units Sold")


tapply(clean_data$Inventory.Level,
       clean_data$Category,
       mean)

tapply(clean_data$Units.Sold,
       clean_data$Category,
       mean)

mean(clean_data$Units.Sold == clean_data$Inventory.Level) * 100

mean(clean_data$Demand.Forecast > clean_data$Inventory.Level) * 100

mean(clean_data$Units.Sold == clean_data$Inventory.Level &
       clean_data$Demand.Forecast > clean_data$Inventory.Level) * 100


plot(clean_data$Units.Ordered,
     clean_data$Units.Sold,
     xlab = "Units Ordered",
     ylab = "Units Sold",
     main = "Units Ordered vs. Actual Sales")


# Check if orders align with forecasted demand instead of actual sales
cor(clean_data$Units.Ordered, clean_data$Demand.Forecast)

# Check if orders align with current inventory (e.g., reordering when stock is low)
cor(clean_data$Units.Ordered, clean_data$Inventory.Level)

# Check summary distributions of orders across categories
tapply(clean_data$Units.Ordered, clean_data$Category, mean)

# 1. Distribution of Forecast Error to verify symmetry
hist(clean_data$Forecast.Error, 
     main = "Distribution of Forecast Errors", 
     xlab = "Error (Units Sold - Demand Forecast)", 
     col = "black", 
     border = "white")

# 2. Check if Price or Discount influences actual sales
cor(clean_data$Price, clean_data$Units.Sold)
cor(clean_data$Discount, clean_data$Units.Sold)

model1 <- lm(Units.Sold ~ Demand.Forecast, data = clean_data)
model2 <- lm(Units.Sold ~ Demand.Forecast + Inventory.Level, data = clean_data)


summary(model1)
summary(model2)
anova(model1, model2)