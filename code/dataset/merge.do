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
		
	use "$data\raw_data\wdi",replace
	
	merge 1:1 year code using "$data\raw_data\edu"
	drop _merge
	
	merge 1:1 year code using "$data\raw_data\health"
	drop _merge
	
	merge 1:1 year code using "$data\raw_data\immunization"
	drop _merge
	
	merge 1:1 year code using "$data\raw_data\mortality"
	drop _merge
		
	merge 1:1 year code using "$data\raw_data\edu"
	drop _merge
	
	merge 1:1 year code using "$data\raw_data\pop"
	drop _merge
	
	merge 1:1 year code using "$data\raw_data\incomegrp"
	drop _merge
	
	merge m:1 code using "$data\raw_data\uhc"
	drop _merge
	
	merge m:1 code using "$data\raw_data\region"
	drop _merge
	
	merge m:1 code using "$data\raw_data\keep"
	drop _merge
		
	save "$data/merge/merge",replace
	
	


	
	