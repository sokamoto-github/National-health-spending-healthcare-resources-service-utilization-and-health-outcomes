*==============================================================================* 
* Project: Health spending on Utilization and Services     			           *   
* Date:   2020 Jan                                                             *
* Author: Takanao Tanaka                                                       *    
*==============================================================================* 

* set directories 
clear all
set maxvar  30000
set matsize 11000 
set more off
cap log close

local TNK 1
local GHH 0
local GHO 0
local GHP 0

if `TNK'==1{
	global dir= "C:\Users\takan\Dropbox\macro_suicide\Macro_health_resources\Analysis"
}

global data "$dir/data"
global table "$dir/tables"
global figure  "$dir/figures"

use "$data/working_data/working_data", replace

*---------------------------------------------------------------------------------------------------
	
	*** sub-sample analysis
	
	* income and government effectiveness
		
	egen uhc_med = mean(uhc)
	gen highuhc= 1
	replace highuhc = 2 if uhc >= uhc_med	
		
	local ctl = "edu urban fe0_9 fe10_19 fe20_29 fe30_39 fe40_49 fe50_59 fe60_69 fe70_79 ma0_9 ma10_19 ma20_29 ma30_39 ma40_49 ma50_59 ma60_69 ma70_79"
		
	foreach n of numlist 1 2{
	foreach i in lnbed lndoc lnnurses lncare lnstaff lnmeasles lnimr lnmr{
	
		reghdfe `i' lnhealth logy `ctl' if highuhc ==`n', absorb(id year)
				
			if "`i'" == "lnbed" local k = "1"
			if "`i'" == "lndoc" local k = "2"
			if "`i'" == "lnnurses" local k = "3"
			if "`i'" == "lncare" local k = "4"
			if "`i'" == "lnstaff" local k = "5"
			if "`i'" == "lnmeasles" local k = "6"
			if "`i'" == "lnimr" local k = "7"
			if "`i'" == "lnmr" local k = "8"
						
			parmest, saving($figure/figA2/`n'_`i'.dta, replace) idstr(`i') idnum(`n'`k')
		}
		}
		
		

*---------------------------------------------------------------------------------------------------
	
	cd $figure/figA2
	openall 
	
	keep if parm == "lnhealth"
	replace idnum = 31 if idnum ==17
	replace idnum = 32 if idnum ==18
	replace idnum = 41 if idnum ==27
	replace idnum = 42 if idnum ==28
	sort idnum
	
	gen row = _n
	gen x = 23 - row
	replace x = x -2 if row >= 7
	replace x = x -2 if row >= 13
	replace x = x -2 if row >= 15

		label define xlabels    ///
				23   "{it:A-1. High-coverage}" ///
				22   "1. Log Hospital Beds"  ///	
				21   "2. Log Doctors" ///	
				20   "3. Log Nurses" ///
				19   "4. Log Antenatal Care"  ///	
				18   "5. Log Use of Skilled Birth Attendant" ///	
				17  "6. Log Immunization Measles" ///		
				16   "" ///	
				15  "{it:A-2. Low-coverage}"  ///	
				14   "7. Log Hospital Beds" ///	
				13  "8. Log Doctors" ///	
				12  "9. Log Nurses" ///	
				11  "10. Log Antenatal Care" ///	
				10  "11. Log Use of Skilled Birth Attendant" ///	
				9  "12. Log Immunization Measles" ///	
				8  " " ///
				7  "{it:B-1. High-coverage, Mortality}" ///	
				6  "13. Infant Mortality Rate" ///	
				5  "14. Mortality Rate" ///	
				4  "" ///	
				3  "{it:B-2. Low-coverage, Mortality}" ///
				2  "15. Infant Mortality Rate" ///		
				1  "16. Mortality Rate" ///		
				0  " " ///			
				25  " " ///	
				,replace
				
						
		label values x xlabels
		
		gen line = x


	*** Figure employment
	twoway rspike  min95 max95 x if x >= 17, c(l) lc(blue*0.5) m(i) lstyle(solid) horizontal ///
		|| rspike min95 max95 x if x >= 9 & x <= 14, c(l) lc(red*0.5) m(i) lstyle(solid) horizontal ///
		|| rspike min95 max95 x if x >= 5 & x <= 6, c(l) lc(blue*0.5) m(i) lstyle(solid) horizontal ///
		|| rspike min95 max95 x if x <= 2, c(l) lc(red*0.5) m(i) lstyle(solid) horizontal ///
		|| scatter x estimate if x >= 17, mc(blue) m(d) msize(0.75)  ///
		|| scatter x estimate if x >= 9 & x <= 14, mc(red) m(d) msize(0.75)  ///
		|| scatter x estimate if x >= 5 & x <= 6, mc(blue) m(d) msize(0.75)  ///
		|| scatter x estimate if x <= 2, mc(red) m(d) msize(0.75)  ///
		ylab(0/2 5/6 9/14 17/22 25, add labsize(2.1) labcolor(black) valuelabel angle(0) nogrid tlength(0)) ytitle("") ///
		ylab(23, add custom labsize(2.5) labcolor(blue) valuelabel angle(0) nogrid tlength(0)) ///
		ylab(15, add custom labsize(2.5) labcolor(red) valuelabel angle(0) nogrid tlength(0)) ///
		ylab(7, add custom labsize(2.5) labcolor(blue) valuelabel angle(0) nogrid tlength(0)) ///
		ylab(3, add custom labsize(2.5) labcolor(red) valuelabel angle(0) nogrid tlength(0)) ///
		xlab(-.4 (.2) .6, labsize(2.1) nogrid) xline(0, lp(shortdash) lw(thin) lc(gray)) legend(off) scheme(plotplain) ysize(10) xsize(10) ytitle("Subgroup and outcome variables", size(2.4)) xtitle("Estimated estimateficients of Share of" "Total Health Spending in GDP", size(2.4))
		
		graph save "$figure/figA2/figA2" ,replace
		graph export "$figure/figA2/figA2.png", replace as(png) width(5000)