library(tidyverse)
library(lubridate)

# set wd
setwd("C:/Users/Stephen/Desktop/stata/econ_684/term_paper")
list.files()


#############################################


# load and clean medicaid_data 
# https://health.data.ny.gov/Health/Medicaid-Program-Enrollment-by-Month-Beginning-200/m4hz-kzn3
# note medicaid data only goes up until july 2016
list.files("./medicaid_data")
medicaid <- read_csv("./medicaid_data/Medicaid_Program_Enrollment_by_Month___Beginning_2009.csv")
glimpse(medicaid)


# rename "Eligibility Year" and "Eligibility Month" variables
# for some reason, "Eligibility Year" variable name is coded oddly, so rename based on index
str(medicaid)
names(medicaid)[1] <- "year"
medicaid <- medicaid %>% mutate(month = .$'Eligibility Month', recipients = .$'Number of Recipients')

# filter to just 2012-2016
medicaid %>% distinct(year)
medicaid %>% distinct(month)
medicaid <- medicaid %>% filter(year > 2011)

# create combined year_month variable to group_by and summarize
medicaid <- medicaid %>% mutate(year_month = ymd(str_c(year, month, 01, sep = "_")))
unique(medicaid$year_month)
length(unique(medicaid$year_month))
medicaid_data <- medicaid %>% group_by(year_month) %>% summarize(medicaid_recipients = sum(recipients, na.rm = TRUE))

# create month variable and select variables for merge
medicaid_data %>% data.frame(.)
medicaid_data <- medicaid_data %>% mutate(month = seq(1, nrow(medicaid_data), 1)) %>% select(month, medicaid_recipients)
glimpse(medicaid_data)

# write medicaid_data to file
write_csv(medicaid_data, "./medicaid_data/medicaid_data.csv")


#############################################


# load and clean seasonally adjusted employment_data from bls for new york
# https://beta.bls.gov/dataViewer/view/timeseries/SMS36000000000000001
list.files("./employment_data")
emp <- read_csv("./employment_data/ny_employment_2012_2016_sa_thousands.csv")
glimpse(emp)

# create month variable
emp <- emp %>% mutate(month = seq(1, nrow(emp), 1))

# rename 1-mont % change variable
emp$emp_growth <- emp$'1-Month % Change'

# create emp_data for merge
emp_data <- emp %>% select(month, emp_growth)
glimpse(emp_data)

# trim months to july 2016, month 55
emp %>% select(Year, Period) %>% data.frame(.)
emp_data <- emp_data %>% filter(month < 56)
emp_data$month

# save data
write_csv(emp_data, "./employment_data/emp_data.csv")


################################################



# load and clean seasonally-adjusted unemployment_data from bls for new york
# https://beta.bls.gov/dataViewer/view/timeseries/LASST360000000000003
list.files("./unemployment_data")
unemp <- read_csv("./unemployment_data/ny_unemployment_2012_2016_sa.csv")
glimpse(unemp)

# create month variable
unemp <- unemp %>% mutate(month = seq(1, nrow(emp), 1))

# rename Value as unemployment rate
unemp <- unemp %>% rename(unemp_rate = Value)

# create unemp_data for merge
unemp_data <- unemp %>% select(month, unemp_rate)
glimpse(unemp_data)

# trim months to july 2016, month 55
unemp %>% select(Year, Period) %>% data.frame(.)
unemp_data <- unemp_data %>% filter(month < 56)
unemp_data$month

# save data
write_csv(unemp_data, "./unemployment_data/unemp_data.csv")


#####################################################



# load and clean snap datas for new york
# https://data.ny.gov/browse?Dataset-Information_Agency=Temporary+and+Disability+Assistance%2C+Office+of&category=Human+Services&utf8=%E2%9C%93
list.files("./snap_data")
snap <- read_csv("./snap_data/Supplemental_Nutrition_Assistance_Program__SNAP__Caseloads_and_Expenditures__Beginning_2002.csv")
glimpse(snap)

# rename year variable, which has weird name encoding
str(snap)
names(snap)
snap$Year
names(snap)[1] <- "year"

# rename "Total SNAP Persons"
snap <- snap %>% mutate(snap_persons = .$'Total SNAP Persons')

# create year_month variable for group_by summary
# snap <- snap %>% mutate(year_month = str_c(year, .$'Month Code', sep = "_"))
snap <- snap %>% mutate(year_month = ymd(str_c(year, .$'Month Code', 01, sep = "_")))

# filter to 2012 - 2016
snap <- snap %>% filter(year > 2011)
unique(snap$year_month)

# observations are counties for given year and month, so need to sum snap_persons for all counties in each year_month
snap_data <- snap %>% group_by(year_month) %>% summarize(snap_persons = sum(snap_persons, na.rm = TRUE)) %>%
        arrange(year_month)
snap_data$year_month

# create month variable and filter to july 2016, month = 55
snap_data <- snap_data %>% mutate(month = seq(1, nrow(snap_data), 1)) %>% filter(month < 56) 
glimpse(snap_data)

# select month and snap_persons
snap_data <- snap_data %>% select(month, snap_persons)

# save data
write_csv(snap_data, "./snap_data/snap_data.csv")


###########################################################


# load and clean wic women data for new york
# https://www.fns.usda.gov/pd/wic-program
list.files("./wic_data")
wic_women_data <- read_csv("./wic_data/wic_women_data.csv")
glimpse(wic_women_data)

# create month variable
wic_women_data <- wic_women_data %>% mutate(month = seq(1, nrow(wic_women_data), 1))

# select month and wic_women
wic_women_data <- wic_women_data %>% select(month, wic_women)
glimpse(wic_women_data)

# save data
write_csv(wic_women_data, "./wic_data/wic_women_data.csv")


###########################################################


# load and clean wic infants data for new york
# https://www.fns.usda.gov/pd/wic-program
list.files("./wic_data")
wic_infants_data <- read_csv("./wic_data/wic_infants_data.csv")
glimpse(wic_infants_data)

# create month variable
wic_infants_data <- wic_infants_data %>% mutate(month = seq(1, nrow(wic_infants_data), 1))

# select month and wic_infants
wic_infants_data <- wic_infants_data %>% select(month, wic_infants)
glimpse(wic_infants_data)

# save data
write_csv(wic_infants_data, "./wic_data/wic_infants_data.csv")


###########################################################


# load and clean wic children data for new york
# https://www.fns.usda.gov/pd/wic-program
list.files("./wic_data")
wic_children_data <- read_csv("./wic_data/wic_children_data.csv")
glimpse(wic_children_data)

# create month variable
wic_children_data <- wic_children_data %>% mutate(month = seq(1, nrow(wic_children_data), 1))

# select month and wic_children
wic_children_data <- wic_children_data %>% select(month, wic_children)
glimpse(wic_children_data)

# save data
write_csv(wic_children_data, "./wic_data/wic_children_data.csv")


##############################################################


# combine data into wic_final

list.files()

# load emp_data
list.files("./employment_data")
emp_data <- read_csv("./employment_data/emp_data.csv")
glimpse(emp_data)

# load unemp_data
list.files("./unemployment_data")
unemp_data <- read_csv("./unemployment_data/unemp_data.csv")
glimpse(unemp_data)

# load medicaid_data
list.files("./medicaid_data")
medicaid_data <- read_csv("./medicaid_data/medicaid_data.csv")
glimpse(medicaid_data)

# load snap_data
list.files("./snap_data")
snap_data <- read_csv("./snap_data/snap_data.csv")
glimpse(snap_data)

# load wic_women_data
list.files("./wic_data")
wic_women_data <- read_csv("./wic_data/wic_women_data.csv")
glimpse(wic_women_data)

# load wic_infants_data
list.files("./wic_data")
wic_infants_data <- read_csv("./wic_data/wic_infants_data.csv")
glimpse(wic_infants_data)

# load wic_children_data
list.files("./wic_data")
wic_children_data <- read_csv("./wic_data/wic_children_data.csv")
glimpse(wic_children_data)

# merge all data into wic_final
wic_merged <- left_join(emp_data, unemp_data, by = "month")
wic_merged <- left_join(wic_merged, medicaid_data, by = "month")
wic_merged <- left_join(wic_merged, snap_data, by = "month")
wic_merged <- left_join(wic_merged, wic_women_data, by = "month")
wic_merged <- left_join(wic_merged, wic_infants_data, by = "month")
wic_merged <- left_join(wic_merged, wic_children_data, by = "month")

glimpse(wic_merged)

# look for NA's
sapply(wic_merged, function(x) { sum(is.na(x)) })

# save data
write_csv(wic_merged, "wic_merged_data.csv")



