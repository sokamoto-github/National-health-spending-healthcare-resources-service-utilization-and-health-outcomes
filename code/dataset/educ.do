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
	global dir= "C:\Users\takan\Dropbox\Macro_health_resources"
}

global data "$dir/Data"

global result "$dir/Results"
global figure  "$dir/Figures"


*---------------------------------------------------------------------------------------------------------

	* education
		
	import excel using "$data\raw_data\education\education", firstrow clear
	drop if year < 1990 | year > 2016
	
	egen id = group(code)
	
	xtset id year
	
	gen eedu = .
	for num 1990 1995 2000 2005 2010: replace eedu = edu if year == X
	for num 1991 1996 2001 2006: replace eedu = l.edu * 0.8 + f4.edu * 0.2 if year == X
	for num 1992 1997 2002 2007: replace eedu = l2.edu * 0.6 + f3.edu * 0.4 if year == X
	for num 1993 1998 2003 2008: replace eedu = l3.edu * 0.4 + f2.edu * 0.6 if year == X
	for num 1994 1999 2004 2009: replace eedu = l4.edu * 0.2 + f.edu * 0.8 if year == X
	
	for num 2011: replace eedu = l6.edu * (-0.2) + l1.edu * 1.2 if year == X
	for num 2012: replace eedu = l7.edu * (-0.4) + l2.edu * 1.4 if year == X
	for num 2013: replace eedu = l8.edu * (-0.6) + l3.edu * 1.6 if year == X
	for num 2014: replace eedu = l9.edu * (-0.8) + l4.edu * 1.8 if year == X
	for num 2015: replace eedu = l10.edu * (-1) + l5.edu * 2 if year == X
	for num 2016: replace eedu = l11.edu * (-1.2) + l6.edu * 2.2 if year == X
	
	drop edu id fedu
	rename eedu edu	
	
	save "$data\raw_data\edu",replace
	
