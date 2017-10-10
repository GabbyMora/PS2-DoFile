Gabby Mora //Data Management, Fall 2017// //Problem Set 2: Manipulating Data// //Part 1//

clear

insheet using "https://docs.google.com/uc?id=0B7NINNiH_unDVEFuOV9HMHB0QlU&export=download", clear

tab descriptor

tab descriptor, nol //this did not work, the set kept showing up with labels//

tab locationtype

tab locationtype, nol //this did not work, the set kept showing up with labels//

summarize locationtype

describe locationtype //this helped me see that location type was a string variable//

destring locationtype, generate (locationtype_n) // Stata said locationtype: contains nonnumeric characters; no generate//

//I looked up how to fix this issue online and learned to encode, so I did that below//

encode locationtype, generate(locationtype_n)

tab locationtype_n, nol //this finally showed the variables as numerical//

recode locationtype_n (4 = 5) //this action combined all the residential locations//

recode locationtype_n (5 6 = 1) //this action combined all the commercial locations//

generate New_Location_type = 1 if locationtype_n==1 //this created a new variable named New_location_type for any location that was not commercial//

replace New_Location_type = 2 if locationtype_n==2 //this create a new variable named New_location_type for any location that was not house and store//

//at this point, I tried to collapse for mean. Stata kept yelling at me so I realized the variables are all strings// //I went in and destrung them//

encode agencyname, generate(agencyname_n)

encode agency, generate(agency_n)

collapse (mean) agencyname_n agency_n //this mean was not really helpful except for knowing there is only one agency//

//I reopended the data set because I did not know how to go back to the original otherwise//

encode descriptor, generate (descriptor_n)

encode locationtype, generate (locationtype_n) //I had to destring locationtype again and I did the same for descriptor so I could collapse them)

collapse (mean) descriptor_n locationtype_n

collapse (median) descriptor_n locationtype_n

//now on to bys gen. I do not really understand how to read this variable for my data set//

bys locationtype_n: egen locationtypemean = mean

bys descriptor_n: egen descriptormedian = median //the command bys gen ran but when I browsed the data, there was no new variable with the variables I created//

cap drop crossstreet1

cap drop crossstreet2

cap drop intersectionstreet1

cap drop intersectionstreet2

//Part 2//

									//////////////Merging Data Sets////////////////

// I selected a data set that looks at the availability of after school programs in NYC; it has a shared variable with my previous date: borough//

insheet using "https://drive.google.com/open?id=0B7NINNiH_unDTC1WeGRsQllrRW8&export=download", clear

//I was not able to merge at all. I kept getting the following issues// //merge 1:1 BoroughCommunity using NYC_After_School_Programs.csv// //variable BoroughCommunity not found// //r(111);//

//merge 1:1 BoroughCommunity using C:\Users\GabbyMora\Desktop\NYC_After_School_Programs.csv// //variable BoroughCommunity not found// //r(111);//
