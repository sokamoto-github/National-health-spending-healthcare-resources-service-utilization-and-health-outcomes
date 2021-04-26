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
	
	cap erase $table/table2/table2.xls
	cap erase $table/table2/table2.txt	
	
	* resources & utilization
	
	local ctl = "edu urban fe0_9 fe10_19 fe20_29 fe30_39 fe40_49 fe50_59 fe60_69 fe70_79 ma0_9 ma10_19 ma20_29 ma30_39 ma40_49 ma50_59 ma60_69 ma70_79 i.year"
		
	xtset id year
	
	foreach i in bed doc nurses care staff measles imr mr {
		
		xtreg ln`i' lnhealth logy `ctl', fe
		outreg2 using $table/table2/table2.xls, drop(`ctl') append auto(3) dec(2) nocon ci noaster addtext(Year Dummy, "Yes", Control, "Yes", Model, "FE") 
				
		}
