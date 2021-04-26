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
	
	cap erase $table/tableA1/tableA1.xls
	cap erase $table/tableA1/tableA1.txt	
	
	* resources & utilization
		
	replace hoop = hoop / 100
	replace hnoop = hnoop / 100
	
	xtset id year
	
	local ctl = "edu urban fe0_9 fe10_19 fe20_29 fe30_39 fe40_49 fe50_59 fe60_69 fe70_79 ma0_9 ma10_19 ma20_29 ma30_39 ma40_49 ma50_59 ma60_69 ma70_79 i.year"
		
	foreach i in dpt pol bcg {
		
		xtreg ln`i' lnhealth logy `ctl', fe
		outreg2 using $table/tableA1/tableA1.xls, drop(`ctl') append dec(2) nocon ci noaster addtext(Year Dummy, "Yes", Control, "Yes", Model, "FE") 
		}
		
	foreach i in dpt pol bcg {
		
		xtreg ln`i' lnhealth hoop hnoop logy `ctl', fe
		outreg2 using $table/tableA1/tableA1.xls, drop(`ctl') append dec(2) nocon ci noaster addtext(Year Dummy, "Yes", Control, "Yes", Model, "FE") 
		}