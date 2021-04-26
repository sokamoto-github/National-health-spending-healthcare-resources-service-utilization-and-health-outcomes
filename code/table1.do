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

*-------------------------------------------------------------------------------

	* summary statistics *
	
	gen oopinprivate = hoop / (private/total)
	
	local spending = "total public private oopinprivate"
	local mortality = "imr mr"
	local resources = "beds nurses doctors"
	local utilization = "prenatalcare skilledstaff measles dpt bcg pol"
	local socio = "gdppc urban edu ma0_19 ma20_69 ma70 fe0_19 fe20_69 fe70"
	
	format `spending' `mortality' `resources' `utilization' `socio' %9.3g
	
	sum `spending', format
	sum `resources', format
	sum `utilization', format
	sum `mortality', format
	sum `socio', format
	
	tabstat `spending', by(year) format
	tabstat `resources', by(year) format
	tabstat `utilization', by(year) format
	tabstat `mortality', by(year) format
	tabstat `socio', by(year) format
