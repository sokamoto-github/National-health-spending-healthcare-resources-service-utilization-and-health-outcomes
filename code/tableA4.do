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
	
	*** The effects of health spending
	
	cap erase $table/tableA4/tableA4.xls
	cap erase $table/tableA4/tableA4.txt	
	
	* resources & utilization
	
	rename prenatalcare care
	rename skilledstaff staff
	
	local ctl = "edu urban fe0_9 fe10_19 fe20_29 fe30_39 fe40_49 fe50_59 fe60_69 fe70_79 ma0_9 ma10_19 ma20_29 ma30_39 ma40_49 ma50_59 ma60_69 ma70_79"
		
	foreach i in bed doc nurses care staff measles imr mr{
	
	reghdfe ln`i' lnhealth logy `ctl', absorb(id year)
		predict yhat`i'
		egen c`i' = count(yhat`i'), by(id)
		egen m`i' = max(c`i'), by(id)
		gen w`i' = c`i'/m`i' if c`i' > 0
	reghdfe ln`i' lnhealth logy `ctl' [w=w`i'], absorb(id year)
		outreg2 using $table/tableA4/tableA4.xls, append drop(`ctl') auto(2) dec(2) nocon ci noaster addtext(Year Dummy, "Yes", Control, "Yes", Model, "FE") 
		}
			
	foreach i in bed doc nurses care staff measles imr mr{
		
		preserve
				
		summarize total, detail
		keep if inrange(total, r(p5), r(p95))
		
		summarize `i', detail
		keep if inrange(`i', r(p5), r(p95))
	
	reghdfe ln`i' lnhealth logy `ctl', absorb(id year)
		outreg2 using $table/tableA4/tableA4.xls, append drop(`ctl') auto(2) dec(2) nocon ci noaster addtext(Year Dummy, "Yes", Control, "Yes", Model, "FE") 
		
		restore
		}
		
	foreach i in bed doc nurses care staff measles imr mr{
	
	reghdfe ln`i' lnhealth logy `ctl' [w=pop], absorb(id year)
		outreg2 using $table/tableA4/tableA4.xls, append drop(`ctl') auto(2) dec(2) nocon ci noaster addtext(Year Dummy, "Yes", Control, "Yes", Model, "FE") 
		}
		