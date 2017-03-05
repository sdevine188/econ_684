* setwd
set more off
clear
cd "C:\Users\Stephen\Desktop\stata\econ_684\term_paper"
ls

* load wic_merged_data.csv
import delimited C:\Users\Stephen\Desktop\stata\econ_684\term_paper\wic_merged_data.csv

* explore
summarize
describe

* set as time series
tsset month


****************************************


* inspect stationarity

tsline wic_women
* non-stationary

tsline wic_infants
* non-stationary

tsline wic_children
* non-stationary

tsline emp_growth
* may be stationary

tsline unemp_rate
* non-stationary

tsline medicaid_recipients
* non-stationary

tsline snap_persons
* non-stationary


*********************************


* create log variables

* wic_women
generate l_wic_women = log(wic_women)
tsline l_wic_women
* non-stationary

* wic_infants
generate l_wic_infants = log(wic_infants)
tsline l_wic_infants
* non-stationary

* wic_infants
generate l_wic_children = log(wic_children)
tsline l_wic_children
* non-stationary

* medicaid recipients
generate l_medicaid_recipients = ///
	log(medicaid_recipients)
tsline l_medicaid_recipients

* snap_persons
generate l_snap_persons = log(snap_persons)
tsline snap_persons


***************************************


* create differenced variables

* l_wic_women
generate d_l_wic_women = l_wic_women - L1.l_wic_women
tsline d_l_wic_women
* looks stationary

* l_wic_infants
generate d_l_wic_infants = l_wic_infants - ///
	L1.l_wic_infants
tsline d_l_wic_infants
* looks stationary

* l_wic_infants
generate d_l_wic_children = l_wic_children - ///
	L1.l_wic_children
tsline d_l_wic_children
* looks stationary

* unemp_rate
generate d_unemp_rate = unemp_rate - L1.unemp_rate
tsline d_unemp_rate
* looks stationary

* l_snap_persons
generate d_l_snap_persons = l_snap_persons - ///
	L1.l_snap_persons
tsline d_l_snap_persons
* looks stationary

* l_medicaid_recipients
generate d_l_medicaid_recipients = ///
	l_medicaid_recipients - ///
	L1.l_medicaid_recipients
tsline d_l_medicaid_recipients
* looks stationary


***************************************


* augmented dickey fuller tests for unit root

* d_l_wic_women
dfuller d_l_wic_women, lags(12) reg
dfuller d_l_wic_women, lags(11) reg
* fail to reject unit root

* difference d_l_wic_women
generate d_d_l_wic_women = d_l_wic_women - ///
	L1.d_l_wic_women
dfuller d_d_l_wic_women, lags(12) reg
dfuller d_d_l_wic_women, lags(11) reg
dfuller d_d_l_wic_women, lags(10) reg
* reject unit root, is stationary

* d_l_wic_infants
dfuller d_l_wic_infants, lags(12) reg
dfuller d_l_wic_infants, lags(11) reg
dfuller d_l_wic_infants, lags(10) reg
dfuller d_l_wic_infants, lags(9) reg
dfuller d_l_wic_infants, lags(8) reg
dfuller d_l_wic_infants, lags(7) reg
dfuller d_l_wic_infants, lags(6) reg
dfuller d_l_wic_infants, lags(5) reg
dfuller d_l_wic_infants, lags(4) reg
dfuller d_l_wic_infants, lags(3) reg
dfuller d_l_wic_infants, lags(2) reg
dfuller d_l_wic_infants, lags(1) reg
dfuller d_l_wic_infants, reg
* reject unit root, is stationary

* d_l_wic_children
dfuller d_l_wic_children, lags(12) reg
dfuller d_l_wic_children, lags(11) reg
dfuller d_l_wic_children, lags(10) reg 
* fail to reject unit root

* difference d_l_wic_children
generate d_d_l_wic_children = d_l_wic_children - ///
	L1.d_l_wic_children
dfuller d_d_l_wic_children, lags(12) reg
dfuller d_d_l_wic_children, lags(11) reg
dfuller d_d_l_wic_children, lags(10) reg 
* reject unit unit, is stationary

* df emp_growth
dfuller emp_growth, lags(12) reg
dfuller emp_growth, lags(11) reg
dfuller emp_growth, lags(10) reg
dfuller emp_growth, lags(9) reg
dfuller emp_growth, lags(8) reg
dfuller emp_growth, lags(7) reg
dfuller emp_growth, lags(6) reg
dfuller emp_growth, lags(5) reg
dfuller emp_growth, lags(4) reg
dfuller emp_growth, lags(3) reg
dfuller emp_growth, lags(2) reg
dfuller emp_growth, lags(1) reg
dfuller emp_growth, reg
* reject unit root, is stationary

* df unemp_rate
dfuller d_unemp_rate, lags(12) reg
dfuller d_unemp_rate, lags(11) reg
dfuller d_unemp_rate, lags(10) reg
dfuller d_unemp_rate, lags(9) reg
dfuller d_unemp_rate, lags(8) reg
dfuller d_unemp_rate, lags(7) reg
dfuller d_unemp_rate, lags(6) reg
dfuller d_unemp_rate, lags(5) reg
dfuller d_unemp_rate, lags(4) reg
dfuller d_unemp_rate, lags(3) reg
dfuller d_unemp_rate, lags(2) reg
dfuller d_unemp_rate, lags(1) reg
dfuller d_unemp_rate, reg
* reject unit root, is stationary

* df d_l_medicaid_recipients
dfuller d_l_medicaid_recipients, lags(12) reg
dfuller d_l_medicaid_recipients, lags(11) reg
dfuller d_l_medicaid_recipients, lags(10) reg
dfuller d_l_medicaid_recipients, lags(9) reg
dfuller d_l_medicaid_recipients, lags(8) reg
dfuller d_l_medicaid_recipients, lags(7) reg
dfuller d_l_medicaid_recipients, lags(6) reg
dfuller d_l_medicaid_recipients, lags(5) reg
dfuller d_l_medicaid_recipients, lags(4) reg
dfuller d_l_medicaid_recipients, lags(3) reg
dfuller d_l_medicaid_recipients, lags(2) reg
dfuller d_l_medicaid_recipients, lags(1) reg
dfuller d_l_medicaid_recipients, reg
* reject unit root, is stationary 

* df d_l_snap_persons
dfuller d_l_snap_persons, lags(12) reg
dfuller d_l_snap_persons, lags(11) reg
dfuller d_l_snap_persons, lags(10) reg
dfuller d_l_snap_persons, lags(9) reg
dfuller d_l_snap_persons, lags(8) reg
dfuller d_l_snap_persons, lags(7) reg
dfuller d_l_snap_persons, lags(6) reg
dfuller d_l_snap_persons, lags(5) reg
dfuller d_l_snap_persons, lags(4) reg
dfuller d_l_snap_persons, lags(3) reg
dfuller d_l_snap_persons, lags(2) reg
dfuller d_l_snap_persons, lags(1) reg
dfuller d_l_snap_persons, reg
* reject unit root, is stationary


*********************************************


* create seasonally-differenced variables,
* conduct dfuller test, and check acf and pacf

* problem is that seasonally-differenced variables
* look like white noise, so no arima model 
* to forecast

* d_l_wic_women
generate s_d_l_wic_women = d_l_wic_women ///
	- L12.d_l_wic_women
tsline s_d_l_wic_women

dfuller s_d_l_wic_women, lags(12) regress
dfuller s_d_l_wic_women, lags(11) regress
dfuller s_d_l_wic_women, lags(10) regress
dfuller s_d_l_wic_women, lags(9) regress
dfuller s_d_l_wic_women, lags(8) regress
dfuller s_d_l_wic_women, lags(7) regress
dfuller s_d_l_wic_women, lags(6) regress
dfuller s_d_l_wic_women, lags(5) regress
dfuller s_d_l_wic_women, lags(4) regress
dfuller s_d_l_wic_women, lags(3) regress
dfuller s_d_l_wic_women, lags(2) regress
dfuller s_d_l_wic_women, lags(1) regress
dfuller s_d_l_wic_women, regress
* reject unit root, is stationary

pac s_d_l_wic_women
ac s_d_l_wic_women

* d_l_wic_infants
generate s_d_l_wic_infants = d_l_wic_infants - ///
	L12.d_l_wic_infants
tsline s_d_l_wic_infants

dfuller s_d_l_wic_infants, lags(12) regress
dfuller s_d_l_wic_infants, lags(11) regress
* reject unit root, is stationary

pac s_d_l_wic_infants
ac s_d_l_wic_infants

* d_l_wic_children
generate s_d_l_wic_children = d_l_wic_children - ///
	L12.d_l_wic_children
tsline s_d_l_wic_children

dfuller s_d_l_wic_children, lags(12) regress
dfuller s_d_l_wic_children, lags(11) regress
dfuller s_d_l_wic_children, lags(10) regress
dfuller s_d_l_wic_children, lags(9) regress
dfuller s_d_l_wic_children, lags(8) regress
dfuller s_d_l_wic_children, lags(7) regress
dfuller s_d_l_wic_children, lags(6) regress
dfuller s_d_l_wic_children, lags(5) regress
dfuller s_d_l_wic_children, lags(4) regress
dfuller s_d_l_wic_children, lags(3) regress
dfuller s_d_l_wic_children, lags(2) regress
dfuller s_d_l_wic_children, lags(1) regress
dfuller s_d_l_wic_children, regress
* reject unit root, is stationary

pac s_d_l_wic_children
ac s_d_l_wic_children

	
******************************************


* arima model

* d_d_l_wic_women
* still has seasonality in it
pac d_d_l_wic_women
ac d_d_l_wic_women
corrgram d_d_l_wic_women

* candidate arima models

* need model with just lags for VAR compatibility
arima d_d_l_wic_women if month < 44, ar(1)
estimates store ar_1

arima d_d_l_wic_women if month < 44, ar(1/2)
estimates store ar_1__2

arima d_d_l_wic_women if month < 44, ar(1/2, 8)
estimates store ar_1__2_8

arima d_d_l_wic_women if month < 44, ar(1/2, 8, 11)
estimates store ar_1__2_8_11

arima d_d_l_wic_women if month < 44, ar(1) ma(1)
estimates store ar_1_ma_1

arima d_d_l_wic_women if month < 44, ar(1/2) ma(1)
estimates store ar_1__2_ma_1

arima d_d_l_wic_women if month < 44, ar(1/2, 8) ma(1)
estimates store ar_1__2_8_ma_1

arima d_d_l_wic_women if month < 44, ar(1/2, 8, 11) ma(1)
estimates store ar_1__2_8_11_ma_1

arima d_d_l_wic_women if month < 44, ar(1) ma(1, 12)
estimates store ar_1_ma_1_12

arima d_d_l_wic_women if month < 44, ar(1/2) ma(1, 12)
estimates store ar_1__2_ma_1_12

arima d_d_l_wic_women if month < 44, ar(1/2, 8) ma(1, 12)
estimates store ar_1__2_8_ma_1_12

arima d_d_l_wic_women if month < 44, ar(1/2, 8, 11) ma(1, 12)
estimates store ar_1__2_8_11_ma_1_12

estimates table ar_1 ar_1__2 ar_1__2_8 ar_1__2_8_11 ///
	ar_1_ma_1 ar_1__2_ma_1 ///
	ar_1__2_8_ma_1 ar_1__2_8_11_ma_1 ///
	ar_1_ma_1_12 ar_1__2_ma_1_12 ///
	ar_1__2_8_ma_1_12, stats(N aic bic) star
	
* ar_1__2_8_ma_1 model is best
* ar(1, 2, 8, 11) model is best VAR compatible


************************************


* arima d_l_wic_women
pac d_l_wic_women
ac d_l_wic_women
corrgram d_l_wic_women

arima d_l_wic_women if month < 44, ar(4)
estimates store ar_4

arima d_l_wic_women if month < 44, ar(4, 8)
estimates store ar_4_8

arima d_l_wic_women if month < 44, ar(4, 12)
estimates store ar_4_12

arima d_l_wic_women if month < 44, ar(4, 8, 12)
estimates store ar_4_8_12

estimates table ar_4 ar_4_8 ar_4_12 ar_4_8_12, ///
	stats(N aic bic) star

drop f_*
drop sd_d_l_wic_women
		
* run arima model on d_l_wic_women
arima d_l_wic_women if month < 44, ar(4, 8) 
estimates store wic_women_model

forecast create wic_women_forecast, replace
forecast estimates wic_women_model
forecast solve, begin(44) ///
	simulate(betas, statistic(stddev, prefix(sd_)) reps(100))

* fill-in pre-forecast variables needed
* to calculate forecast variables
generate f_wic_women = wic_women if month < 44

* for loop generated f_d_l_wic_women ///
* based on var forecasts of d_d_l_wic_women
forvalues i = 44/55 {
	local x `i'-1
	 replace f_wic_women = (f_wic_women[`x']*f_d_l_wic_women[`i']) + f_wic_women[`x'] if month == `i'
}

* create upper and lower bounds
generate f_sd_wic_women = 0 if month < 44
forvalues i = 44/55 {
	local x `i'-1
	replace f_sd_wic_women = (f_wic_women[`x']*sd_d_l_wic_women[`i']) + f_wic_women[`x'] if month == `i'
}

generate f_ub_wic_women = f_wic_women + ///
	invnormal(0.975)*f_sd_wic_women
generate f_lb_wic_women = f_wic_women - ///
	invnormal(0.975)*f_sd_wic_women

* plot forecast
tsline wic_women || tsline f_wic_women ///
	if month > 43

tsline wic_women || tsline f_wic_women ///
	if month > 43, lp(dash) lc(red) || ///
	tsline f_ub_wic_women if month > 43, ///
	lp(dash) lc(red) || tsline f_lb_wic_women ///
	if month > 43, lp(dash) lc(red)
	
* calculate RMSE for forecast
generate f_error_wic_women = wic_women - ///
	f_wic_women
generate f_sq_error_wic_women = f_error_wic_women^2
mean(f_sq_error_wic_women)
disp sqrt(361920.3)

* calculate mape for forecast
generate f_abs_pct_error = abs(f_error_wic_women / ///
	wic_women)
mean(f_abs_pct_error)
disp sqrt(.0021032)


****************************************

forecast create wic_women_forecast, replace
forecast estimates wic_women_model
forecast solve, begin(44)

* fill-in pre-forecast variables needed
* to calculate forecast variables
generate f_d_l_wic_women = d_l_wic_women if month < 44
generate f_wic_women = wic_women if month < 44

* for loop generated f_d_l_wic_women ///
* based on var forecasts of d_d_l_wic_women
forvalues i = 44/55 {
	local x `i'-1
	 replace f_d_l_wic_women = f_d_l_wic_women[`x'] + f_d_d_l_wic_women[`i'] if month == `i'
}

forvalues i = 44/55 {
	local x `i'-1
	 replace f_wic_women = (f_wic_women[`x']*f_d_l_wic_women[`i']) + f_wic_women[`x'] if month == `i'
}


* plot forecast
tsline wic_women || tsline f_wic_women ///
	if month > 43, lp(dash) lc(red)
	
* calculate RMSE for forecast
generate f_error_wic_women = wic_women - ///
	f_wic_women
generate f_sq_error_wic_women = f_error_wic_women^2
mean(f_sq_error_wic_women)
disp sqrt(3065061)


**********************************************


* run var model
var d_d_l_wic_women emp_growth d_unemp_rate ///
	d_l_medicaid_recipients d_l_snap_persons ///
	if month < 44, lags(1, 2, 8, 11)
	
* run var with 1 lag
var d_d_l_wic_women emp_growth d_unemp_rate ///
	d_l_medicaid_recipients d_l_snap_persons ///
	if month < 44, lags(1)
	
* run var on seasonally-differenced 
var s_d_l_wic_women emp_growth d_unemp_rate ///
	d_l_medicaid_recipients d_l_snap_persons ///
	if month < 44, lags(1 2 3 4)
	
* check var
varsoc s_d_l_wic_women emp_growth d_unemp_rate ///
	d_l_medicaid_recipients d_l_snap_persons ///
	if month < 44

fcast compute var_, step(12) dynamic(44)

* drop values to rerun forecast
* drop var_*

* fill-in pre-forecast variables needed
* to calculate forecast variables
generate var_d_l_wic_women = d_l_wic_women if month < 44
generate var_wic_women = wic_women if month < 44

**********************************

* seasonal
forvalues i = 44/55 {
	local x `i'-12
	 replace var_d_l_wic_women = var_d_l_wic_women[`x'] + var_s_d_l_wic_women[`i'] if month == `i'
}

forvalues i = 44/55 {
	local x `i'-1
	 replace var_wic_women = (var_wic_women[`x']*var_d_l_wic_women[`i']) + var_wic_women[`x'] if month == `i'
}
****************************************

* for loop generated var_d_l_wic_women ///
* based on var forecasts of d_d_l_wic_women
forvalues i = 44/55 {
	local x `i'-1
	 replace var_d_l_wic_women = var_d_l_wic_women[`x'] + var_d_d_l_wic_women[`i'] if month == `i'
}

forvalues i = 44/55 {
	local x `i'-1
	 replace var_wic_women = (var_wic_women[`x']*var_d_l_wic_women[`i']) + var_wic_women[`x'] if month == `i'
}

* plot forecast
tsline wic_women || tsline var_wic_women ///
	if month > 43, lp(dash) lc(red)
	
* calculate RMSE for forecast
generate var_error_wic_women = var_wic_women - ///
	wic_women
generate var_sq_error_wic_women = var_error_wic_women^2
mean(var_sq_error_wic_women)
disp sqrt(2586000)


***********************************************


drop var_*

* var model on d_l_wic_women
varsoc d_l_wic_women emp_growth d_unemp_rate ///
	d_l_medicaid_recipients d_l_snap_persons ///
	if month < 44

var d_l_wic_women emp_growth d_unemp_rate ///
	d_l_medicaid_recipients d_l_snap_persons ///
	if month < 44, lags(4, 8)

fcast compute var_, step(12) dynamic(44)

* fill-in pre-forecast variables needed
* to calculate forecast variables
generate var_wic_women = wic_women if month < 44

forvalues i = 44/55 {
	local x `i'-1
	 replace var_wic_women = (var_wic_women[`x']*var_d_l_wic_women[`i']) + var_wic_women[`x'] if month == `i'
}

* plot forecast
tsline wic_women || tsline var_wic_women ///
	if month > 43, lp(dash) lc(red)
	
tsline wic_women || tsline var_wic_women ///
	if month > 43, lp(dash) lc(red) || ///
	tsline var_
	
* calculate RMSE for forecast
generate var_error_wic_women = wic_women - ///
	var_wic_women
generate var_sq_error_wic_women = var_error_wic_women^2
mean(var_sq_error_wic_women)
disp sqrt(132917.4)

* calculate mape for forecast
generate var_abs_pct_error = abs(var_error_wic_women / ///
	wic_women)
mean(var_abs_pct_error)
disp sqrt(.0011597)


*****************************************


* plot arima and var forecasts
tsline wic_women, lc(black) || tsline var_wic_women ///
	if month > 43, lp(dash) lc(red) || ///
	tsline f_wic_women ///
	if month > 43, lp(dash) lc(blue)
	
	
***************************************

* 

