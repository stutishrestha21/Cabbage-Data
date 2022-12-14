library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(tidyr)
library(ggplot2)
rm(list = ls())

setwd("~/Desktop/Data 331/GitHub/Final/cabbage_butterfly-main/Cabbage-Data/data")


butterfly<- read_excel('CompletePierisData_2022-03-09.xlsx', .name_repair = "universal")

#Question 1
sexAffect <- butterfly %>% #arranged to answer all sex related questions
  select(SexUpdated, LWingLength, RWingLength, LWingWidth, RWingWidth, LBlackPatchApex, RBlackPatchApex, LAnteriorSpotM3, LPosteriorSpotCu2, RAnteriorSpotM3, RPosteriorSpotCu2)%>%
  arrange(SexUpdated, desc(SexUpdated))%>%
  rename(Sex= SexUpdated)%>%
  rename(LApex= LBlackPatchApex)%>%
  rename(RApex= RBlackPatchApex)%>%
  rename(LSpot1 = LAnteriorSpotM3)%>%
  rename(LSpot2= LPosteriorSpotCu2)%>%
  rename(RSpot1= RAnteriorSpotM3)%>%
  rename(RSpot2= RPosteriorSpotCu2)
  

#to change all the char value to numeric
suppressWarnings(sexAffect$LWingLength <- as.numeric(sexAffect$LWingLength))
suppressWarnings(sexAffect$RWingLength<- as.numeric(sexAffect$RWingLength))
suppressWarnings(sexAffect$LWingWidth <- as.numeric(sexAffect$LWingWidth))
suppressWarnings(sexAffect$RWingWidth<- as.numeric(sexAffect$RWingWidth))
suppressWarnings(sexAffect$LApex <- as.numeric(sexAffect$LApex))
suppressWarnings(sexAffect$RApex<- as.numeric(sexAffect$RApex))
suppressWarnings(sexAffect$LSpot1 <- as.numeric(sexAffect$LSpot1))
suppressWarnings(sexAffect$LSpot2<- as.numeric(sexAffect$LSpot2))
suppressWarnings(sexAffect$RSpot1 <- as.numeric(sexAffect$RSpot1))
suppressWarnings(sexAffect$RSpot2<- as.numeric(sexAffect$RSpot2))



#Wing length Comparison of Male and Female
sexWingLength <- sexAffect %>% 
  select(Sex,LWingLength, RWingLength)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="F","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="F?","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="M","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="M?","MALE",Sex))%>%
  dplyr::group_by(Sex)%>%
  dplyr::filter(!is.na(Sex))%>% #remove na
  dplyr::filter(!is.na(LWingLength))%>% #remove na
  dplyr::filter(!is.na(RWingLength)) #remove na

  
#Wing Width Comparison of Male and Female
sexWingWidth <- sexAffect%>%
  select(Sex, LWingWidth, RWingWidth)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="F","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="F?","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="M","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="M?","MALE",Sex))%>%
  dplyr::group_by(Sex)%>%
  dplyr::filter(!is.na(Sex))%>% #remove na
  dplyr::filter(!is.na(LWingWidth))%>% #remove na
  dplyr::filter(!is.na(RWingWidth)) #remove na


#Apex Comparison of Male and Female
#multiply to take out the area
sexAffect$total_apex <- sexAffect$LApex * sexAffect$RApex

sexApex <- sexAffect%>%
  select(Sex, total_apex)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="F","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="F?","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="M","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="M?","MALE",Sex))%>%
  dplyr::group_by(Sex)%>%
  dplyr::filter(!is.na(Sex))%>% #remove na
  dplyr::filter(!is.na(total_apex)) #remove na

#Spot Area Comparison of Male and Female

total_Lspot <- sexAffect$LSpot1 + sexAffect$LSpot2
total_Rspot <- sexAffect$RSpot1 + sexAffect$RSpot2
#multiply to take out the area
sexAffect$total_spotArea <- total_Lspot * total_Rspot

sexSpotArea <- sexAffect%>%
  select(Sex, total_spotArea)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="F","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="F?","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="M","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="M?","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="MALE?","MALE",Sex))%>%
  dplyr::group_by(Sex)%>%
  dplyr::filter(!is.na(Sex))%>% #remove na
  dplyr::filter(!is.na(total_spotArea)) #remove na


#Question 2
#How Latitude, Longitude affect the length/width
#DecimalLatitudeUpdated, DecimalLongitudeUpdated, dwc.country

locationAffect <- butterfly %>% #arranged to answer all location related questions
  select(DecimalLatitudeUpdated, DecimalLongitudeUpdated, dwc.country, LWingLength, RWingLength, LWingWidth, RWingWidth, LBlackPatchApex, RBlackPatchApex, LAnteriorSpotM3, LPosteriorSpotCu2, RAnteriorSpotM3, RPosteriorSpotCu2)%>%
  rename(Latitude= DecimalLatitudeUpdated)%>%
  rename(Longitude= DecimalLongitudeUpdated)%>%
  rename(Country= dwc.country)%>%
  rename(LApex= LBlackPatchApex)%>%
  rename(RApex= RBlackPatchApex)%>%
  rename(LSpot1 = LAnteriorSpotM3)%>%
  rename(LSpot2= LPosteriorSpotCu2)%>%
  rename(RSpot1= RAnteriorSpotM3)%>%
  rename(RSpot2= RPosteriorSpotCu2)


#to change all the char value to numeric
suppressWarnings(locationAffect$Latitude <- as.numeric(locationAffect$Latitude))
suppressWarnings(locationAffect$Longitude <- as.numeric(locationAffect$Longitude))
suppressWarnings(locationAffect$RWingLength<- as.numeric(locationAffect$RWingLength))
suppressWarnings(locationAffect$LWingLength<- as.numeric(locationAffect$LWingLength))
suppressWarnings(locationAffect$LWingWidth <- as.numeric(locationAffect$LWingWidth))
suppressWarnings(locationAffect$RWingWidth<- as.numeric(locationAffect$RWingWidth))
suppressWarnings(locationAffect$LApex <- as.numeric(locationAffect$LApex))
suppressWarnings(locationAffect$RApex<- as.numeric(locationAffect$RApex))
suppressWarnings(locationAffect$LSpot1 <- as.numeric(locationAffect$LSpot1))
suppressWarnings(locationAffect$LSpot2<- as.numeric(locationAffect$LSpot2))
suppressWarnings(locationAffect$RSpot1 <- as.numeric(locationAffect$RSpot1))
suppressWarnings(locationAffect$RSpot2<- as.numeric(locationAffect$RSpot2))


#Wing length Comparison of Latitude, longitude and country
latitudeWingLength <- locationAffect %>% 
  select(Latitude,LWingLength, RWingLength)%>%
  dplyr::group_by(Latitude)%>%
  dplyr::filter(!is.na(Latitude))%>% #remove na
  dplyr::filter(!is.na(LWingLength))%>% #remove na
  dplyr::filter(!is.na(RWingLength)) #remove na

longitudeWingLength <- locationAffect %>% 
  select(Longitude,LWingLength, RWingLength)%>%
  dplyr::group_by(Longitude)%>%
  dplyr::filter(!is.na(Longitude))%>%
  dplyr::filter(!is.na(LWingLength))%>% #remove na
  dplyr::filter(!is.na(RWingLength)) 


countryWingLength <- locationAffect %>% 
  select(Country,LWingLength, RWingLength)%>%
  dplyr::group_by(Country)%>%
  dplyr::filter(!is.na(Country))%>%
  dplyr::filter(!is.na(LWingLength))%>% #remove na
  dplyr::filter(!is.na(RWingLength)) 


#Wing Width Comparison by locations
latitudeWingWidth <- locationAffect%>%
  select(Latitude,LWingWidth, RWingWidth)%>%
  dplyr::group_by(Latitude)%>%
  dplyr::filter(!is.na(Latitude))%>% #remove na
  dplyr::filter(!is.na(LWingWidth))%>% #remove na
  dplyr::filter(!is.na(RWingWidth)) #remove na

longitudeWingWidth <- locationAffect%>%
  select(Longitude,LWingWidth, RWingWidth)%>%
  dplyr::group_by(Longitude)%>%
  dplyr::filter(!is.na(Longitude))%>%
  dplyr::filter(!is.na(LWingWidth))%>% #remove na
  dplyr::filter(!is.na(RWingWidth))

countryWingWidth <- locationAffect %>% 
  select(Country,LWingWidth, RWingWidth)%>%
  dplyr::group_by(Country)%>%
  dplyr::filter(!is.na(Country))%>%
  dplyr::filter(!is.na(LWingWidth))%>% #remove na
  dplyr::filter(!is.na(RWingWidth))

#Apex area comparison by locations
locationAffect$total_apex <- locationAffect$LApex * locationAffect$RApex

latitudeApex <- locationAffect%>%
  select(Latitude,total_apex)%>%
  dplyr::group_by(Latitude)%>%
  dplyr::filter(!is.na(Latitude))%>% #remove na
  dplyr::filter(!is.na(total_apex)) #remove na

longitudeApex <- locationAffect%>%
  select(Longitude,total_apex)%>%
  dplyr::group_by(Longitude)%>%
  dplyr::filter(!is.na(Longitude))%>%
  dplyr::filter(!is.na(total_apex))

countryApex <- locationAffect %>% 
  select(Country,total_apex)%>%
  dplyr::group_by(Country)%>%
  dplyr::filter(!is.na(Country))%>%
  dplyr::filter(!is.na(total_apex))

#Anterior spot area by loaction
total_Lspot <- locationAffect$LSpot1 + locationAffect$LSpot2
total_Rspot <- locationAffect$RSpot1 + locationAffect$RSpot2
#multiply to take out the area
locationAffect$total_spotArea <- total_Lspot * total_Rspot

latitudeSpotArea <- locationAffect%>%
  select(Latitude,total_spotArea)%>%
  dplyr::group_by(Latitude)%>%
  dplyr::filter(!is.na(Latitude))%>% #remove na
  dplyr::filter(!is.na(total_spotArea)) #remove na

longitudeSpotArea <- locationAffect%>%
  select(Longitude,total_spotArea)%>%
  dplyr::group_by(Longitude)%>%
  dplyr::filter(!is.na(Longitude))%>%
  dplyr::filter(!is.na(total_spotArea))

countrySpotArea <- locationAffect %>% 
  select(Country,total_spotArea)%>%
  dplyr::group_by(Country)%>%
  dplyr::filter(!is.na(Country))%>%
  dplyr::filter(!is.na(total_spotArea))

#Question 3

#relationship between apex area and spot area
Spot_Apex <- sexAffect%>%
  select(Sex, total_spotArea, total_apex)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="F","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="F?","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="M","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="M?","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="MALE?","MALE",Sex))%>%
  dplyr::group_by(Sex)%>%
  dplyr::filter(!is.na(Sex))%>% #remove na
  dplyr::filter(!is.na(total_spotArea))%>% #remove na
  dplyr::filter(!is.na(total_apex))

ggplot(Spot_Apex, aes(x=total_spotArea, y=total_apex))+
  geom_line(aes(color=Sex))

#relationship between apex area and wing length by latitude
Apex_WingLength <- locationAffect%>%
  select(Latitude, LWingLength, RWingLength, total_apex)%>%
  dplyr::group_by(Latitude)%>%
  dplyr::filter(!is.na(Latitude))%>% #remove na
  dplyr::filter(!is.na(LWingLength))%>% #remove na
  dplyr::filter(!is.na(RWingLength))%>% #remove na
  dplyr::filter(!is.na(total_apex))
  
Apex_WingLength$totalWingLenth <-Apex_WingLength$LWingLength+ Apex_WingLength$RWingLength

ggplot(Apex_WingLength, aes(x=totalWingLenth, y=total_apex))+
  geom_line(aes(color=Latitude))

#relationship between apex area and wing length by longitude
Spot_WingLength <- locationAffect%>%
  select(Longitude, LWingLength, RWingLength, total_spotArea)%>%
  dplyr::group_by(Longitude)%>%
  dplyr::filter(!is.na(Longitude))%>% #remove na
  dplyr::filter(!is.na(LWingLength))%>% #remove na
  dplyr::filter(!is.na(RWingLength))%>% #remove na
  dplyr::filter(!is.na(total_spotArea))

Spot_WingLength$totalWingLenth <-Spot_WingLength$LWingLength+ Spot_WingLength$RWingLength

ggplot(Spot_WingLength, aes(x=totalWingLenth, y=total_spotArea))+
  geom_line(aes(color=Longitude))

#Question 4
#How collection month or year affect thw wing length/ width, apex area, and anterior area
#dwc:month, YearUpdated

yearAffect <- butterfly %>% #arranged to answer all location related questions
  select(dwc.month,YearUpdated, LWingLength, RWingLength, LWingWidth, RWingWidth, LBlackPatchApex, RBlackPatchApex, LAnteriorSpotM3, LPosteriorSpotCu2, RAnteriorSpotM3, RPosteriorSpotCu2)%>%
  rename(Month= dwc.month)%>%
  rename(Year= YearUpdated)%>%
  rename(LApex= LBlackPatchApex)%>%
  rename(RApex= RBlackPatchApex)%>%
  rename(LSpot1 = LAnteriorSpotM3)%>%
  rename(LSpot2= LPosteriorSpotCu2)%>%
  rename(RSpot1= RAnteriorSpotM3)%>%
  rename(RSpot2= RPosteriorSpotCu2)


#to change all the char value to numeric
suppressWarnings(yearAffect$RWingLength<- as.numeric(yearAffect$RWingLength))
suppressWarnings(yearAffect$LWingLength<- as.numeric(yearAffect$LWingLength))
suppressWarnings(yearAffect$LWingWidth <- as.numeric(yearAffect$LWingWidth))
suppressWarnings(yearAffect$RWingWidth<- as.numeric(yearAffect$RWingWidth))
suppressWarnings(yearAffect$LApex <- as.numeric(yearAffect$LApex))
suppressWarnings(yearAffect$RApex<- as.numeric(yearAffect$RApex))
suppressWarnings(yearAffect$LSpot1 <- as.numeric(yearAffect$LSpot1))
suppressWarnings(yearAffect$LSpot2<- as.numeric(yearAffect$LSpot2))
suppressWarnings(yearAffect$RSpot1 <- as.numeric(yearAffect$RSpot1))
suppressWarnings(yearAffect$RSpot2<- as.numeric(yearAffect$RSpot2))

#Wing length Comparison of month and year
yearWingLength <- yearAffect %>% 
  select(Year,LWingLength, RWingLength)%>%
  dplyr::group_by(Year)%>%
  dplyr::filter(!is.na(Year))%>% #remove na
  dplyr::filter(!is.na(LWingLength))%>% #remove na
  dplyr::filter(!is.na(RWingLength)) #remove na

monthWingLength <- yearAffect %>% 
  select(Month, LWingLength, RWingLength)%>%
  dplyr::group_by(Month)%>%
  dplyr::filter(!is.na(Month))%>% #remove na
  dplyr::filter(!is.na(LWingLength))%>% #remove na
  dplyr::filter(!is.na(RWingLength)) #remove na 

#Wing Width Comparison of month and year
yearWingWidth <- yearAffect%>%
  select(Year,LWingWidth, RWingWidth)%>%
  dplyr::group_by(Year)%>%
  dplyr::filter(!is.na(Year))%>% #remove na
  dplyr::filter(!is.na(LWingWidth))%>% #remove na
  dplyr::filter(!is.na(RWingWidth)) #remove na

monthWingWidth <- yearAffect%>%
  select(Month,LWingWidth, RWingWidth)%>%
  dplyr::group_by(Month)%>%
  dplyr::filter(!is.na(Month))%>% #remove na
  dplyr::filter(!is.na(LWingWidth))%>% #remove na
  dplyr::filter(!is.na(RWingWidth)) #remove na

#Apex area comparison by year and month
yearAffect$total_apex <- yearAffect$LApex * yearAffect$RApex

yearApex <- yearAffect%>%
  select(Year,total_apex)%>%
  dplyr::group_by(Year)%>%
  dplyr::filter(!is.na(Year))%>% #remove na
  dplyr::filter(!is.na(total_apex)) #remove na

monthApex <- yearAffect%>%
  select(Month,total_apex)%>%
  dplyr::group_by(Month)%>%
  dplyr::filter(!is.na(Month))%>% #remove na
  dplyr::filter(!is.na(total_apex)) #remove na

#Anterior spot area by Year and month
total_Lspot <- yearAffect$LSpot1 + yearAffect$LSpot2
total_Rspot <- yearAffect$RSpot1 + yearAffect$RSpot2
#multiply to take out the area
yearAffect$total_spotArea <- total_Lspot * total_Rspot

yearSpotArea <- yearAffect%>%
  select(Year,total_spotArea)%>%
  dplyr::group_by(Year)%>%
  dplyr::filter(!is.na(Year))%>% #remove na
  dplyr::filter(!is.na(total_spotArea)) #remove na

monthSpotArea <- yearAffect%>%
  select(Month,total_spotArea)%>%
  dplyr::group_by(Month)%>%
  dplyr::filter(!is.na(Month))%>% #remove na
  dplyr::filter(!is.na(total_spotArea)) #remove na


#Question 5
#An average for each wing, compare male vs female, and by decade.
averageData <- butterfly %>%
  select(YearUpdated, SexUpdated,LWingLength, RWingLength, LWingWidth, RWingWidth)%>%
  rename(Year = YearUpdated)%>%
  rename(Sex = SexUpdated)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="F","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="F?","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="M","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="M?","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="MALE?","MALE",Sex))%>%
  dplyr::filter(!is.na(Year))%>% #remove na
  dplyr::filter(!is.na(Sex))%>% #remove na
  dplyr::filter(!is.na(LWingLength))%>% #remove na
  dplyr::filter(!is.na(RWingLength))%>%
  dplyr::filter(!is.na(LWingWidth))%>%
  dplyr::filter(!is.na(RWingWidth))%>%#remove na
  dplyr::filter(!is.na(RWingWidth))%>%
  dplyr::filter(Year>=2000)


suppressWarnings(averageData$RWingLength<- as.numeric(averageData$RWingLength))
suppressWarnings(averageData$LWingLength<- as.numeric(averageData$LWingLength))
suppressWarnings(averageData$LWingWidth <- as.numeric(averageData$LWingWidth))
suppressWarnings(averageData$RWingWidth<- as.numeric(averageData$RWingWidth))
suppressWarnings(averageData$Year<- as.numeric(averageData$Year))


#ttest of average wing length and wing width
averageData$AverageWingLengthSum <- averageData$RWingLength + averageData$LWingLength
averageData$AverageWingLength <- averageData$AverageWingLengthSum/2

averageData$AverageWingWidthSum <- averageData$RWingWidth + averageData$LWingWidth
averageData$AverageWingWidth <- averageData$AverageWingWidthSum/2

t.test(averageData$AverageWingLength, averageData$AverageWingWidth, var.equal = TRUE)

#Graph average for each wing, compare male vs female, and by decade.
ggplot(averageData, aes(x=Year, y=AverageWingLength))+
  geom_line(aes(color=Sex))













