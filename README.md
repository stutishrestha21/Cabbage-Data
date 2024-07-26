# Insects Biology Department Data Analysis
Dataset is ongoing collection of insects around the world

First we made a butterfly table where we extracted all the data from the excel document that was provided to us as CompletePierisData.

1. How does sex affect:
The first process for us was to export all the libraries that we needed to perform necessary actions. We created a sexAffect table where we extracted sex, wing length and width of both left and right wing, left and write apex, left and right spot in order to see how sex affected wing length, apex area and anterior spot area. Then, to make sense for our data, we made sure that everything was renamed. Since we needed to plot and conduct calculations on it, we also converted the data type from character to numeric. Since we knew the data type had to be numeric in order to execute the necessary arithmetic, we silenced the warnings that it was issuing when we changed the data type.

A. Wing length/width? 
To compare the length of the male and female wing, we built a new table called sexWingLength. There, we choose the sex and the lengths of the left and right wings. We made sure that sex was all uppercased. To rename all the letters that stand for women, we use the dplyr package. For the men, we followed the same procedure. Then, we categorized our data by sex. We removed all of the N/A values because we didn't want anything that had no use.
 
Additionally, we picked the sex, left, and right wing widths when creating the sexWingWidth data.  We made sure that sex was all uppercased. In addition to renaming the columns for male and female and removing any N/A values, we did the same for this table.

B. Apex area?  
We multiplied the left and right apexes to determine the apex area. From the sexAffect table, we chose Sex, total apex. We made sure the sex were capitalized. All of the sex was renamed as female and male, and we categorized it accordingly. All of the N/A values were also filtered.

C. Anterior spot area?  
We added left spot 1 and left spot 2. For right, we used the same procedure. The values were then multiplied. Then, using the sexAffect table's selection of sex and total spot area, we constructed the sexSpotArea table. The identical procedure of capitalizing sex and changing its name to male and female was followed. All of the N/A values were also filtered.


2. How does location (latitude, longitude, or territory) affect:
The approach was the same for the location as it was for the sex, but we chose DecimalLatitudeUpdated, DecimalLongitudeUpdated, and dwc.country instead of sex. We changed the names to latitude, longitude, and nation because they are lengthy and difficult to remember. The left and right apex and spot areas were also renamed. Since we changed the data type from character to numeric to carry out our operations, it was throwing us superfluous warnings so we suppressed it.

A. Wing length/width?  
Latitude, left wing length, and right wing length were chosen and entered into the table latitudeWingLength. We filtered all the N/A values and sorted by latitude.
The same was done for longitude; a longitudeWingLength table was constructed and longitude was selected instead of latitude, and similarly for country; a countryWingLength table was generated as we choose country, instead of latitude.

The table latitudeWingWidth was picked, and the latitude, left wing length, and right wing width were entered. We sorted by latitude and filtered all of the N/A values.
The same procedure was followed for longitude; a longitudeWingWidth table was built and longitude was chosen in place of latitude. Similarly, for countries, a countryWingWidth table was created as country was chosen in place of latitude.


B. Apex area?
We multiplied the left and right apexes to determine the apex area. From the locationAffect table, we chose Latitude, total apex to make the latitudeApex table. We grouped by latitude. All of the N/A values were also filtered.
The same procedure was followed for longitude; a longitudeApex table was built and longitude was chosen in place of latitude. Similarly, for countries, a countryApex table was created as country was chosen in place of latitude.

C. Anterior spot area?
We made total_spotArea by adding left spot 1 and left spot 2. For right, we used the same procedure. The values were then multiplied. Then, using the locationAffect table's selection of Latitude and total spot area, we constructed the latitudeSpotArea table. We grouped by latitude. All of the N/A values were also filtered.
The same process was used to choose longitude instead of latitude; a longitudeSpotArea table was created. Similar to latitude, we selected countries instead of latitude, a countrySpotArea table was generated.

3. What is the relationship between apex area and spot area, apex area and wing length, or spot area and wing length?
We believed that graphs would be the most effective way to answer Question #3. To illustrate the relationship between the apex area and the spot area, we created a graph using the male and female tables. We created Spot Apex, which pulled data from the sexAffect table to choose the sex, total spot area, and total apex. The sex was subsequently capitalized and given the new names of female and male. Then we grouped it by sex. All of the N/A values were also filtered. We attempted to create bar charts and scatter plots, but the quantities were too long. Instead, we succeeded in creating a line graph. The table was then selected using gg plot, and the spotArea and total apex axes were both selected. Then we developed color in accordance with the sex—male and female.

We created an Apex WingLength table and chose the latitude, left and right wing lengths, and total apex to illustrate the link between apex area and wing length by latitude. We deleted all N/A values and sorted the data by latitude. We wanted the total wing length so we added the left and right wing lengths to create the totalWingLenth column in the table. Using the Apex WingLength table, totalWingLenth x and total apex y axes, we created a line graph using ggplot. In order to highlight the variations, we colored it based on latitude.

The Spot WingLength table was made to display the correlation between wing length and longitude for apex area. From the location affect table, we choose the longitude, left wing length, right wing length, and total spot area. By longitude, we categorized. All of the N/A values were also filtered. The left and right wing lengths were then added in a totalWingLenth column in the table. The line graph was then made with ggplot and colored in accordance with the longitude.


4. How does collection month or year affect:
The approach was the same as it was for the location and the sex, but we chose dwc:month, and YearUpdated. We changed the names to Month, and Year because they are lengthy and difficult to remember. The left and right apex and spot areas were also renamed. Since we changed the data type from character to numeric to carry out our operations, it was throwing us superfluous warnings so we suppressed it.

A. Wing length/width?   
Year, LWingLength, RWingLength were chosen and entered into the table yearWingLength. We filtered all the N/A values and sorted by Year.
The same was done for month; a monthWingLength table was constructed using month, left wing and right wing length.

The table yearWingWidth was picked, and the Year, left wing length, and right wing width were entered. We sorted by Year and filtered all of the N/A values.
The same procedure was followed for months; a monthWingWidth table was created after we selected month, left wing width and right wing width.

B. Apex area?  
We multiplied the left and right apexes to determine the apex area. From the yearAffect table, we chose Year, total apex to make the yearApex table. We grouped by Year. All of the N/A values were also filtered.
The same procedure was followed for a month; a monthApex table was built as we choose month and total apex. Following the same procedure like the yearApex table.

C. Anterior spot area?   
We made total_spotArea by adding left spot 1 and left spot 2. For right, we used the same procedure. The values were then multiplied. Then, using the yearAffect table's selection of Year and total spot area, we constructed the yearSpotArea table. We grouped by Year. All of the N/A values were also filtered.
The same process was used to choose month instead of year; a monthSpotArea table was created. Similar to year, we followed everything.

5. Complete an average for each wing, compare male vs female, and by decade. 

In order to create an averageData table for question number 5, we took the following information from the butterfly table: YearUpdated, SexUpdated, LWingLength, RWingLength, LWidth, and RWidth. The year, sex, and sex were then renamed and capitalized. All of the gender columns were renamed to male and female, and all N/A values were eliminated. We filtered our year column so that only the data up to 2000 would be displayed. We suppressed all the warnings as we changed the data types of the data from character to numeric.  We then made a graph from the gg plot.

T-Test
For our t test we used the average table as we took out the average of length and width. 
