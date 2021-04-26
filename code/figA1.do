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

********************************************************************************
			
	* income, spending and resources and utilization
	
	* resouses and health spending
		
	graph twoway  (scatter lndoc logy if year == 2010 , msymbol(circle) mcolor(red*0.2) mlcolor(red) msize(0.75)  ylabel(-6 (2) 2.4, nogrid) xlabel(,nogrid) legend(off) title("A-1: Income and Number of Doctors", position(11) size(vlarge)) xtitle("Log GDP per capita", size(4.5)) ytitle("Log number of hospital Doctors" "(per1,000)", size(4.5)) scheme(plotplain))
	graph save "$figure\figA1\figA1_A",replace
	
	graph twoway (scatter lndoc total if year == 2010 , msymbol(circle) mcolor(red*0.2) mlcolor(red) msize(0.75) ylabel(, nogrid) xlabel(,nogrid) legend(off) title("A-2: Health Spending and Number of Doctors", position(11) size(vlarge)) xtitle("Share of health spending in GDP (%)", size(4.5)) ytitle("Log number of hospital Doctors" "(per1,000)", size(4.5)) scheme(plotplain))
	graph save "$figure\figA1\figA1_B",replace
	
	graph twoway (scatter lndoc hoop if year == 2010 , msymbol(circle) mcolor(red*0.2) mlcolor(red) msize(0.75) ylabel(, nogrid) xlabel(,nogrid) legend(off) title("A-3: Out-of-Pocket and Number of Doctors", position(11) size(vlarge)) xtitle("Share of private spending in GDP (%)", size(4.5)) ytitle("Log number of hospital Doctors" "(per1,000)", size(4.5)) scheme(plotplain))
	graph save "$figure\figA1\figA1_C",replace
	
	
	* utilization and health spending
		
	graph twoway (scatter lnmeasles logy if year == 2010 & lnmeasles > 3.8 , msymbol(circle) mcolor(red*0.2) mlcolor(red) msize(0.75) ylabel(3.8 (0.2) 4.7, nogrid) xlabel(,nogrid) legend(off) title("B-1: Income and Immunization, Measles", position(11) size(vlarge))  xtitle("Log GDP per capita", size(4.5)) ytitle("Log Immunization" "of measles (%)", size(4.5)) scheme(plotplain))
	graph save "$figure\figA1\figA1_D",replace
	
	graph twoway  (scatter lnmeasles total if year == 2010 & lnmeasles > 3.8 , msymbol(circle) mcolor(red*0.2) mlcolor(red) msize(0.75) ylabel(3.8 (0.2) 4.7, nogrid) xlabel(,nogrid) legend(off) title("B-2: Health Spending and Immunization, Measles", position(11) size(vlarge))  xtitle("Share of health spending in GDP (%)", size(4.5)) ytitle("Log Immunization" "of measles (%)", size(4.5)) scheme(plotplain))
	graph save "$figure\figA1\figA1_E",replace
	
	graph twoway (scatter lnmeasles hoop if year == 2010 & lnmeasles > 3.8  , msymbol(circle) mcolor(red*0.2) mlcolor(red) msize(0.75) ylabel(3.8 (0.2) 4.7, nogrid) xlabel(,nogrid) legend(off) title("B-3: Out-of-Pocket and Immunization, Measles", position(11) size(vlarge)) xtitle("Share of private spending in GDP (%)", size(4.5)) ytitle("Log Immunization" "of measles (%)", size(4.5)) scheme(plotplain))
	graph save "$figure\figA1\figA1_F",replace
	
				
		graph combine "$figure\figA1\figA1_A" "$figure\figA1\figA1_B" "$figure\figA1\figA1_C" "$figure\figA1\figA1_D" "$figure\figA1\figA1_E" "$figure\figA1\figA1_F", col(3) row(2) imargin(4 4 4 4 4 4) xsize(20) ysize(8.5) graphregion(margin(vtiny) fcolor(white) lcolor(white)) iscale(0.5) 
		
		graph save "$figure\figA1\figA1",replace
		graph export "$figure\figA1\figA1.png",replace as(png) width(5000)
		
		