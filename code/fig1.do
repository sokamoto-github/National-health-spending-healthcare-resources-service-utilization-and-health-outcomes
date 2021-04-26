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
	
	* trend of health spendin in GDP *
	gen hspc = total * gdp / pop
	gen lnhspc = ln(hspc)
	
	graph twoway (scatter lnhspc logy if year == 2010 , msymbol(circle) mcolor(red*0.2) mlcolor(red) msize(0.75) ylabel(, nogrid) xlabel(,nogrid) legend(off) title("A: Income and Healh Spending per capita", position(11) size(4)) xtitle(Log GDP per capita) ytitle(Log (Health spending per capita)) scheme(plotplain))
	graph save "$figure\fig1\fig1_A",replace
	
	graph twoway  (scatter total logy if year == 2010 , msymbol(circle) mcolor(red*0.2) mlcolor(red) msize(0.75) ylabel(, nogrid) xlabel(,nogrid) legend(off) title("B: Income and Healh Spending Share", position(11) size(4))  xtitle(Log GDP per capita) ytitle(Health spending share in GDP) scheme(plotplain))
	graph save "$figure\fig1\fig1_B",replace
		
	graph twoway (scatter privateinhealth logy if year == 2010  , msymbol(circle) mcolor(red*0.2) mlcolor(red) msize(0.75) ylabel(0 (20) 90, nogrid) xlabel(,nogrid) legend(off) title("C: Income and Share of Private Spending", position(11) size(4)) xtitle(Log GDP per capita) ytitle(Share of private in health spending) scheme(plotplain))
	graph save "$figure\fig1\fig1_C",replace
		
	graph twoway (scatter oopinhealth logy if year == 2010  , msymbol(circle) mcolor(red*0.2) mlcolor(red) msize(0.75) ylabel(0 (20) 90, nogrid) xlabel(,nogrid) legend(off) title("D: Income and Share of Out-of-pocket", position(11) size(4)) xtitle(Log GDP per capita) ytitle(Share of out-of-pocket in health spending) scheme(plotplain))
	graph save "$figure\fig1\fig1_D",replace
		
		graph combine "$figure\fig1\fig1_A" "$figure\fig1\fig1_B" "$figure\fig1\fig1_C" "$figure\fig1\fig1_D" , graphregion(margin(vtiny)) iscale(0.6)
		graph save "$figure\fig1\fig1",replace
		graph export "$figure\fig1\fig1.png", replace as(png) width(5000)
		