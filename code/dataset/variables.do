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

*---------------------------------------------------------------------------------------------------------

	use "$data/merge/merge",clear 
	
	keep if keep == 1
	drop if year < 1990 | year > 2014
	
	egen id = group(code)
	tsset id year	
		
	gen noop = private/total*100 - oopt
	
	gen lnbed = ln(bed)
	gen lndoc = ln(doctors)
	gen lnnurses = ln(nurses)
	
	gen lncare = ln(prenatalcare)
	gen lnstaff = ln(skilledstaff)
	gen lnmeasles = ln(measles)
	
	gen lndpt = ln(dpt)
	gen lnbcg = ln(bcg)
	gen lnpol = ln(pol)

	gen logy=ln(gdppc)
	gen lnhealth = ln(total)
	gen hpublic = public
	gen hprivate = private
	gen hoop = oopt
	gen hnoop = noop
	
	gen lnmr = ln(mr)
	gen lnimr = ln(imr)
	
	foreach i in fe ma { 
		gen `i'0_19 = `i'0_9 + `i'10_19
		gen `i'20_69 = `i'20_29 + `i'30_39 + `i'40_49 + `i'50_59 + `i'60_69
		gen `i'70 = `i'70_79 + `i'80
		}	
		
	save "$data/working_data/working_data",replace
	

	
	
	