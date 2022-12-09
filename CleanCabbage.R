library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(tidyr)
rm(list = ls())

setwd("~/Desktop/Data 331/GitHub/Final/cabbage_butterfly-main/Cabbage-Data/data")


butterfly<- read_excel('CompletePierisData_2022-03-09.xlsx', .name_repair = "universal")

sexAffect <- butterfly %>% #arranged to answer all sex related questions
  select(SexUpdated, LWingLength, RWingLength, LWingWidth, RWingWidth, LBlackPatchApex, RBlackPatchApex, LAnteriorSpotM3, LPosteriorSpotCu2, RAnteriorSpotM3, RPosteriorSpotCu2)%>%
  arrange(SexUpdated, desc(SexUpdated))%>%
  rename(Sex= SexUpdated)%>%
  rename(LApex= LBlackPatchApex)%>%
  rename(RApex= RBlackPatchApex)%>%
  rename(LSpot1 = LAnteriorSpotM3)%>%
  rename(LSpot2= LPosteriorSpotCu2)%>%
  rename(RSpot1= RAnteriorSpotM3)%>%
  rename(RSpot2= RPosteriorSpotCu2)%>%
  dplyr::mutate(Sex = ifelse(is.na(Sex),0, Sex))%>%
  dplyr::mutate(LWingLength = ifelse(is.na(LWingLength),0, LWingLength))%>%
  dplyr::mutate(RWingWidth = ifelse(is.na(RWingWidth),0, RWingWidth))%>%
  dplyr::mutate(LApex = ifelse(is.na(LApex),0, LApex))%>%
  dplyr::mutate(RApex = ifelse(is.na(RApex),0, RApex))%>%
  dplyr::mutate(LSpot1 = ifelse(is.na(LSpot1),0, LSpot1))%>%
  dplyr::mutate(LSpot2 = ifelse(is.na(LSpot2),0, LSpot2))%>%
  dplyr::mutate(RSpot1 = ifelse(is.na(RSpot1),0, RSpot1))%>%
  dplyr::mutate(RSpot2 = ifelse(is.na(RSpot2),0, RSpot2))
  

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
femaleWingLength <- sexAffect %>% 
  select(Sex,LWingLength, RWingLength)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="F","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="F?","FEMALE",Sex))%>%
  dplyr::filter(Sex == "FEMALE")%>%
  dplyr::group_by(Sex)

maleWingLength <- sexAffect%>%
  select(Sex,LWingLength,RWingLength)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="M","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="M?","MALE",Sex))%>%
  dplyr::filter(Sex == "MALE")%>%
  dplyr::group_by(Sex)

#Wing Width Comparison of Male and Female
femaleWingWidth <- sexAffect%>%
  select(Sex, LWingWidth, RWingWidth)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="F","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="F?","FEMALE",Sex))%>%
  dplyr::filter(Sex == "FEMALE")%>%
  dplyr::group_by(Sex)

maleWingWidth <- sexAffect%>%
  select(Sex, LWingWidth, RWingWidth)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="M","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="M?","MALE",Sex))%>%
  dplyr::filter(Sex == "MALE")%>%
  dplyr::group_by(Sex)

#plot the male wing length, wing width incomparison to female wing length, width

#Apex Comparison of Male and Female
#multiply to take out the area
sexAffect$total_apex <- sexAffect$LApex * sexAffect$RApex

femaleApex <- sexAffect%>%
  select(Sex, total_apex)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="F","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="F?","FEMALE",Sex))%>%
  dplyr::filter(Sex == "FEMALE")%>%
  dplyr::group_by(Sex)

maleApex <- sexAffect%>%
  select(Sex, total_apex)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="M","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="M?","MALE",Sex))%>%
  dplyr::filter(Sex == "MALE")%>%
  dplyr::group_by(Sex)

#Spot Area Comparison of Male and Female

total_Lspot <- sexAffect$LSpot1 + sexAffect$LSpot2
total_Rspot <- sexAffect$RSpot1 + sexAffect$RSpot2
#multiply to take out the area
sexAffect$total_spotArea <- total_Lspot * total_Rspot

femaleSpotArea <- sexAffect%>%
  select(Sex, total_spotArea)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="F","FEMALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="F?","FEMALE",Sex))%>%
  dplyr::filter(Sex == "FEMALE")%>%
  dplyr::group_by(Sex)

maleSpotArea <- sexAffect%>%
  select(Sex, total_spotArea)%>%
  dplyr::mutate(Sex= toupper(Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex=="M","MALE",Sex))%>%
  dplyr::mutate(Sex = ifelse(Sex =="M?","MALE",Sex))%>%
  dplyr::filter(Sex == "MALE")%>%
  dplyr::group_by(Sex)

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

longitudeApex <- locationAffect%>%
  select(Longitude,total_spotArea)%>%
  dplyr::group_by(Longitude)%>%
  dplyr::filter(!is.na(Longitude))%>%
  dplyr::filter(!is.na(total_spotArea))

countryApex <- locationAffect %>% 
  select(Country,total_spotArea)%>%
  dplyr::group_by(Country)%>%
  dplyr::filter(!is.na(Country))%>%
  dplyr::filter(!is.na(total_spotArea))








