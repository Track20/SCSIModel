
clear all
set more off
set maxvar 10000

 cd "C:\Users\KristinBietsch\files\DHS Data\Nigeria"
use caseid v001 v002 v003 v005 v007 v008 v011 v017 v018 v019 v021 v023 v101 v102 v106 v190 sstate vcal_* ///
  using "NGIR7AFL.DTA", clear
  
* set up which calendar columns to look at - column numbers can vary across phases of DHS
local col1 1 // method use and pregnancies - always column 1
local col2 2 // reasons for discontinuation - usually column 2

* Step 7.1
* set length of calendar in a local macro
local vcal_len = strlen(vcal_`col1'[1])
* set episode number - initialized to 0
gen eps = 0
* set previous calendar column 1 variable to anything that won't be in the calendar
gen prev_vcal1 = "_"
* create separate variables for each month of the calendar
forvalues j = `vcal_len'(-1)1 {
  local i = `vcal_len' - `j' + 1
  * contraceptive method, non-use, or birth, pregnancy, or termination
  gen vcal1_`i' = substr(vcal_`col1',`j',1)
  * reason for discontinuation
  gen vcal2_`i' = substr(vcal_`col2',`j',1)

  * check if we have marriage info
*  if "`marr_col'"!="" { // we have a marriage column
*    gen vcal3_`i' = substr(vcal_`col3',`j',1)
*    * set up parameter to add into reshape below, and collapse further below
*    local vcal3_ vcal3_
*    local ev906 ev906a=vcal3_
*  }
  * increase the episode number if there is a change in vcal_1
  replace eps = eps+1 if vcal1_`i' != prev_vcal1
  * set the episode number
  gen int ev004`i' = eps 
  * save the vcal1 value for the next time through the loop
  replace prev_vcal1 = vcal1_`i'
}


* Step 7.2
* drop the calendar variables now we have the separate month by month variables
drop vcal_* eps prev_vcal1

* reshape the new month by month variables into a long format
reshape long ev004 vcal1_ vcal2_ , i(caseid) j(i)

* update the discontinuation code to a blank if it is empty
replace vcal2_ = " " if vcal2_ == ""

* label the event number variable
label variable ev004 "Event number"


* Step 7.3
* create the century month code (CMC) for each month
gen cmc=v017+i-1

* drop the blank episode after the date of interview
drop if i > v019

* capture the variable labels for the v variables
foreach v of varlist v* { 
  local l`v' : variable label `v'
} 
* and the value labels for v101 v102 v106
foreach v of varlist v1* { 
  local `v'lbl : value label `v'
}


* Step 7.4
* collapse the episodes within each case, keeping start and end, the event code,
* and other useful information
collapse (first) v001 v002 v003 v005 v007 v008 v011 v017 v018 v019 v101 v102 v106  sstate ///
  (first) ev900=cmc (last) ev901=cmc (count) ev901a=cmc ///
  (last) ev902a=vcal1_ ev903a=vcal2_ `ev906', by(caseid ev004)

* replace the variable label for all of the v* variables
foreach v of varlist v* {
  label variable `v' `"`l`v''"'
}
* and the value labels for v101 v102 v106 v190
foreach v of varlist v1* { 
  label val `v' ``v'lbl'
}

* label the variables created in the collapse statement
label variable ev900  "CMC event begins"
label variable ev901  "CMC event ends"
label variable ev901a "Duration of event"
label variable ev902a "Event code (alpha)"
label variable ev903a "Discontinuation code (alpha)"
format ev004 %2.0f
format ev900 ev901 %4.0f


* Step 7.5
* convert the event string variable for the episode (ev902a) to numeric (ev902)

* set up a list of codes used in the calendar,
* with the position in the string of codes being the code that will be assigned
* use a tilde (~) to mark gaps in the coding that are not used for this survey 
* Emergency contraception (E), Other modern method (M) and Standard days method (S)
* are recent additions as standard codes and may mean something different in earlier surveys
* note that some of the codes are survey specific so this will need adjusting
* tab vcal1_ to see the full list of codes to handle for the survey you are using
local methodlist = "123456789WNALCFEMS~"
* convert the contraceptive methods to numeric codes, using the position in the string
gen ev902 = strpos("`methodlist'",ev902a)
* now convert the birth, termination and pregnancy codes to 81, 82, 83 respectively
gen preg = strpos("BTP",ev902a)
replace ev902 = preg+80 if preg>0
drop preg
* convert the missing code to 99
replace ev902 = 99 if ev902a == "?"
* now check if there are any codes that were not converted, and change these to -1
replace ev902 = -1 if ev902 == 0 & ev902a != "0"

* list cases where the event code was not recoded
list caseid ev004 ev902 ev902a if ev902==-1


* Step 7.6
* convert the discontinuation string variable for the episode (ev903a) to numeric (ev903)
* set up a list of codes used in the calendar
* use a tilde (~) to mark gaps in the coding that are not used for this survey 
local reasonlist = "123456789CFAD~~~~"
* convert the reasons for discontinuation to numeric codes, using the position in the string
gen ev903 = strpos("`reasonlist'",ev903a) if ev903a != " "
* now convert the special codes for other, don't know and missing to 96, 98, 99 respectively
gen special = strpos("W~K?",ev903a)
replace ev903 = special + 95 if special > 0
drop special
* now check if there are any codes that were not converted, and change these to -1.
replace ev903 = -1 if ev903 == 0 & ev903a != " "

* list cases where the reason for discontinuation code was not recoded
list caseid ev004 ev903 ev903a if ev903==-1


* Step 7.7
* capture the previous event and its duration for this respondent
by caseid: gen ev904  = ev902[_n-1]  if _n > 1
by caseid: gen ev904x = ev901a[_n-1] if _n > 1
* capture the following event and its duration for this respondent
by caseid: gen ev905  = ev902[_n+1]  if _n < _N
by caseid: gen ev905x = ev901a[_n+1] if _n < _N


* Step 7.8
* label the event file variables and values
label variable ev902  "Event code"
label variable ev903  "Discontinuation code"
label variable ev904  "Prior event code"
label variable ev904x "Duration of prior event"
label variable ev905  "Next event code"
label variable ev905x "Duration of next event"
label def event ///
  0 "No method used" ///
  1 "Pill" ///
  2 "IUD" ///
  3 "Injectable" ///
  4 "Diaphragm" ///
  5 "Condom" ///
  6 "Female sterilization" ///
  7 "Male sterilization" ///
  8 "Periodic abstinence/Rhythm" ///
  9 "Withdrawal" ///
 10 "Other traditional methods" ///
 11 "Norplant" ///
 12 "Abstinence" ///
 13 "Lactational amenorrhea method" ///
 14 "Female condom" ///
 15 "Foam and Jelly" ///
 16 "Emergency contraception" ///
 17 "Other modern method" ///
 18 "Standard days method" ///
 81 "Birth" ///
 82 "Termination" ///
 83 "Pregnancy" ///
 99 "Missing" ///
 -1 "***Unknown code not recoded***" 
label def reason ///
  0 "No discontinuation" ///
  1 "Became pregnant while using" ///
  2 "Wanted to become pregnant" ///
  3 "Husband disapproved" ///
  4 "Side effects" ///
  5 "Health concerns" ///
  6 "Access/availability" ///
  7 "Wanted more effective method" ///
  8 "Inconvenient to use" ///
  9 "Infrequent sex/husband away" ///
 10 "Cost" ///
 11 "Fatalistic" ///
 12 "Difficult to get pregnant/menopause" ///
 13 "Marital dissolution" ///
 96 "Other" ///
 98 "Don't know" ///
 99 "Missing" ///
 -1 "***Unknown code not recoded***" 
label val ev902 event
label val ev903 reason
label val ev904 event
label val ev905 event
format ev901a ev902 ev903 ev904 ev904x ev905 ev905x %2.0f


* Step 7.9
* convert marriage codes to numeric, if it exists
capture confirm variable ev906a
if !_rc { // variable exists
  gen ev906 = 7
  replace ev906=0 if ev906a=="0"
  replace ev906=1 if ev906a=="X"
  replace ev906=9 if ev906a=="?"
  label variable ev906a "Married at end of episode (alpha)"
  label variable ev906  "Married at end of episode"
  label def marriage 0 "Not married" 1 "Married" 7 "Unknown code" 9 "Missing" 
  label val ev906 marriage
  format ev906 %1.0f
}


* Step 7.10
* save the events file
save  "Nigeria2018eventsfile.dta", replace
*******************************************************************************
*******************************************************************************
*******************************************************************************
*******************************************************************************
*******************************************************************************

**defining local date without spaces
local currdate = date(c(current_date),"DMY")
local stryear = string(year(`currdate'))
local strmonth = string(month(`currdate'))
local strday = string(day(`currdate'))
local date = "`strmonth'_`strday'_`stryear'"
di "`date'"


**CHANGE LINE BELOW **
* cd "C:\Users\21098\Documents\Contraceptive Discontinuation\Events files manual"

*erase any previous files
foreach x in 12  {
	capture erase "eventfile_`x'mrates_`date'.csv"
	capture erase "eventfile_`x'mrates2_`date'.csv"
}


capture log close
log using "discontinuation rates `date'.log", replace

*test on ALL women - coded for switching
local country 10	20	30	40	50	60	70	80	90	100	110	120	130	140	150	160	170	180	190	200	210	220	230	240	250	260	270	280	290	300	310	320	330	340	350	360	370
noisily{
foreach c of local country {
	use  "Nigeria2018eventsfile.dta", clear
	keep if sstate== `c'
	g country="`c'"
	capture ren V007 v007
	capture ta v007
	ta country

	**prepare variables needed for calculation of rates
	* weight variable
	g wgt=v005/1000000

	* checking against table 8.2, reasons for discontinuing contraceptive methods.
	* note that table 8.2 uses all episodes that ended in the 60 months prior to interview.
	* this is a different denominator than the discontinuation rates.
	recode ev902 (1=1 Pill)(2=2 IUD)(3=3 Injections)	///
		(11=4 Implants)(5=5 "Male condom")(13=6 LAM)	///
		(8=8 "Periodic abstinence")(9=9 Withdrawal)	///
		(7 10 18 26 27 = 10 Other)(else=.), g(wev902)
	* Other includes: Male sterilization, Other, Emergency contraception, Herbs, Massage.
	* Note that this is not the same grouping as in table 8.1.
	* Tabulate all discontinuations that occurred within the last five years
	ta ev903 wev902 [iw=wgt] if ev903 != 0 & v008-ev901 < 60
	* add ", column nofreq" to the end of the above to get percentages instead of counts.

	**time from beginning of event to interview
	g tbeg_int=v008-ev900
	label var tbeg_int "time from beginning of event to interview"

	**time from end of event to interview
	g tend_int = v008-ev901
	label var tend_int "time from end of event to interview"

	**Dropping events that were ongoing when calendar began
	drop if v017==ev900

	**drop births, pregnancies, episodes of non-use, and terminations.
	* KEEP missing methods. to exclude, change 99 below to 100.
	drop if (ev902>80 & ev902<99) | ev902==0

	*Discontinuation Indicator
	g discind = 0
	replace discind = 1 if ev903!=0
	*censoring those who discontinue in last three months
	replace discind = 0 if tend_int < 3
	label var discind "discontinuation indicator"
	ta discind
	ta ev903 discind, m

	*Creating the duration variable
	*length of episode of use
	g eventb = ev900
	g evente = ev901
	g uselgth = (evente - eventb)+1
	label var uselgth "length of episode"
	sum uselgth

	*taking away exposure time outside of the 3 to 62 month window
	g contlgthc = uselgth
	replace contlgthc = uselgth - (3-tend_int) if tend_int < 3
	recode contlgthc -3/0=0

	*remove sterilized women from denominator - NOT for this run
	*replace contlgthc=. if ev902==6
	*ta contlgthc ev902, m

	*Generating a late entry variable
	g entry = 0
	replace entry = tbeg_int - 62 if tbeg_int >= 63
	ta tbeg_int entry

	*censoring any discontinuations that are assoc with use > 59 months
	*not censoring for this file
	*replace discind = 0 if (contlgthc-entry) > 59

	** Recode contraceptive method
	recode ev902 				 ///
		(1  = 1 Pill)			 ///
		(2  = 2 IUD)			 ///
		(3  = 3 Injectable)		 ///
		(11 = 4 Implant)			 ///
		(5  = 5 "Male condom")		 ///
		(8  = 6 "Periodic abstinence") ///
		(9  = 7 Withdrawal)		 ///
		(13 18 = 8 "LAM/EC")		 ///
		(nonmissing = 98 Other)		 ///
		(missing = .), gen(method)
	ta ev902 method, m
	* Other category is male/female sterilization, "other", herbs, massage. (possibly also 2 cases of EC)

	** Computing variables for reasons for discontinuation
	** ignoring switching

	* recode reasons for discontinuation - EXCL switching
	recode ev903 			     	///
		(0       = .)		     	///
		(1       = 1 "Failure")	     	///
		(2       = 2 "Desires preg")	///
		(9 12 13 = 3 "Other fert")	///
		(4 5     = 4 "Health/side ef")	///
		(7 8     = 5 "Method related")	///
		(6 10    = 6 "Cost/access")  	///
		(nonmissing = 7 "Other/DK") if discind==1, gen(discat7)
	ta discat7
	ta ev903 discat7 [iw=wgt] if discind==1, m

	** Switching Methods

	*switching directly from one method to the next:
	capture drop eventb
	g eventb  = ev900
	g evente1 = ev901 + 1
	sort v001 v002 v003 ev004
	by v001 v002 v003: gen rswitch = 1 if evente1==eventb[_n+1]

	*if reason was "wanted more effective method" allow for a 1-month gap
	g evente2 = evente+2
	sort v001 v002 v003 ev004
	by v001 v002 v003: replace rswitch = 1 if ev903==7 & evente2>=eventb[_n+1] & ev905==0

	*not a switch if returned back to the same method
	sort v001 v002 v003 ev004
	by v001 v002 v003: replace rswitch = . if (ev902==ev902[_n+1]) & evente1!=eventb[_n+1]
	ta rswitch

	* calculate different var for switching
	g discatsw=.
	replace discatsw = 1 if rswitch==1			& discind==1
	replace discatsw = 2 if discatsw==. & ev903!=0  & discind==1
	label def discatsw 1 "switch" 2 "other reason"
	label val discatsw discatsw
	ta discatsw


	**Dropping those events that started in the month of the interview and two months prior**
	drop if tbeg_int < 3
	**Dropping events that started and ended before 62 months prior to survey**
	drop if tbeg_int > 62 & tend_int > 62


	**competing risks estimates - TOTAL - no switching

	capture stset, clear
	stset contlgthc [iw=wgt], failure(discat7==1) enter(entry)
	stcompet discattotal = ci, compet1(2) compet2(3) compet3(4) compet4(5) compet5(6) compet6(7)
	* convert rate to percentage
	g dratetotal=discattotal*100

	**competing risks estimates - TOTAL - SWITCHING
	capture stset, clear
	stset contlgthc [iw=wgt], failure(discatsw==1) enter(entry)
	stcompet discattotalsw = ci, compet1(2)
	*convert rate to percentage
	g dratetotalsw=discattotalsw*100

	**competing risks estimates - running by method
	tokenize pill IUD inj impl mcond pabs withd lamec other
	foreach x in 1 2 3 4 5 6 7 8 98 {
		* by reason - no switching
		capture stset, clear
		stset contlgthc if method==`x' [iw=wgt], failure(discat7==1) enter(entry)
		stcompet discat`1' = ci, compet1(2) compet2(3) compet3(4) compet4(5) compet5(6) compet6(7)
		* convert rate to percentage
		g drate`1'=discat`1'*100

		* for switching
		capture stset, clear
		stset contlgthc if method==`x' [iw=wgt], failure(discatsw==1) enter(entry)
		stcompet discat`1'sw = ci, compet1(2)
		* convert rate to percentage
		g drate`1'sw=discat`1'sw*100

		macro shift
	}

	label var dratepill  "Pill"
	label var drateIUD   "IUD"
	label var drateinj   "Injection"
	label var drateimpl  "Implants"
	label var dratemcond "Male condom"
	label var dratepabs  "Periodic abstinence"
	label var dratewithd "Withdrawal"
	label var dratelamec "LAM/EC"
	label var drateother "Other"
	label var dratetotal "All methods"

************************************************
**** SAVE DATA FILES FOR OUTPUT ****************
************************************************

	*save data file with results
	save "`c'drates `date'.dta", replace


	***SAVE Ns
	*weighted count
	collapse (count) v008 [iw=wgt], by(method)
	ren v008 methodNwt
	save "`c'methodNwt.dta", replace

	use "`c'drates `date'.dta", clear
	*unweighted Ns
	drop if entry!=0
	contract country method, freq(methodNunwt)
	sort method
	save "`c'methodNunwt.dta", replace


************************************************
****FORMAT DATA FOR OUTPUT TABLE****************
************************************************

*** SAVE DISCON RATES - 6, 12, 24 AND 36 MONTHS

	foreach x in 12 {
		use "`c'drates `date'.dta", clear
		*collect information from relevant time period only
		drop if contlgthc> `x'
		*Keep only discontinuation information
		keep method drate* contlgthc discat7 discatsw wgt
		*Save small dataset
		save "`c'_`x'mresults_`date'.dta", replace

		* Collapse and save a file just for switching
		collapse(max) dratetotalsw dratepillsw drateIUDsw drateinjsw drateimplsw dratemcondsw dratepabssw dratewithdsw dratelamecsw drateothersw, by(discatsw)
		* only keep row for switching, not for other reasons
		drop if discatsw!=1
		save "`c'switching.dta", replace

		* Collapse main data by discontinuation category and save
		use "`c'_`x'mresults_`date'.dta"
		collapse(max) dratetotal dratepill drateIUD drateinj drateimpl dratemcond dratepabs dratewithd dratelamec drateother, by(discat7)
		*drop missing values
		drop if discat7==.
		save "`c'reasons.dta", replace

		* Calculate total discontinuation and save
		collapse(sum) dratetotal dratepill drateIUD drateinj drateimpl dratemcond dratepabs dratewithd dratelamec drateother
		g discat7 = 8
		save "`c'total.dta", replace

		* Go back to data by reasons and merge others into it
		use "`c'reasons.dta"
		append using "`c'total.dta"

		*MERGE IN SWITCHING DATA
		append using "`c'switching.dta"
		replace discat7=9 if discatsw==1
		foreach z in pill IUD inj impl mcond pabs withd lamec other total {
			replace drate`z' = drate`z'sw if discatsw==1
		}

		*replace empty cells with zeros for each method
		foreach z in pill IUD inj impl mcond pabs withd lamec other total {
			replace drate`z' = 0 if drate`z'==.
		}

		*MERGE IN UNWEIGHTED NS
		append using "`c'methodNunwt.dta"
		recode discat7 .=10, g(discat)
		label def discat7 8 "Total" 9 "Switching" 10 "Unweighted N" 11 "Weighted N", add
		label val discat discat7
		label var discat "`x'-month contraceptive discontinuation rates"
		tokenize pill IUD inj impl mcond pabs withd lamec other
		foreach z in 1 2 3 4 5 6 7 8 98 {
			replace drate`1' = methodNunwt if discat==10 & method==`z'
			macro shift
		}
		egen    totalNunwt = total(methodNunwt)
		replace dratetotal = totalNunwt  if discat==10

		*MERGE IN WEIGHTED NS
		append using "`c'methodNwt.dta"
		recode discat .=11
		tokenize pill IUD inj impl mcond pabs withd lamec other
		foreach z in 1 2 3 4 5 6 7 8 98 {
			replace drate`1'  = methodNwt if discat==11 & method==`z'
			macro shift
		}
		egen    totalNwt   = total(methodNwt)
		replace dratetotal = totalNwt  if discat==11
		save "`c'_`x'mresults_`date'.dta", replace

		** Now tabulate - this version with methods in the rows

		collapse(max) dratetotal dratepill drateIUD drateinj drateimpl dratemcond dratepabs dratewithd dratelamec drateother, by(discat)

		list discat dratepill drateIUD drateinj drateimpl dratemcond dratepabs dratewithd dratelamec drateother dratetotal, tab div abb(16) sep(9) noobs linesize(160)
		outsheet discat dratepill drateIUD drateinj drateimpl dratemcond dratepabs dratewithd dratelamec drateother dratetotal using `c'_`x'mrates_`date'_2.csv, comma replace

		** Simpler version with methods in the columns
		* tabout8 discat using `c'_`x'mrates_`date'_2.csv, app ///
			c(mean dratepill mean drateIUD   mean drateinj   mean drateimpl  mean dratemcond ///
			  mean dratepabs mean dratewithd mean dratelamec mean drateother mean dratetotal) ///
			h2(`x'-month contraceptive discontinuation rates) h3(|Pill|IUD|Injection|Implants|Male condom|Periodic abstinence|Withdrawal|LAM/EC|Other|Total) ///
			style(csv) lines(0)
	}

	*erase files
	foreach x in  12 {
		erase "`c'_`x'mresults_`date'.dta"
	}
	erase "`c'drates `date'.dta"
	erase "`c'methodNunwt.dta"
	erase "`c'methodNwt.dta"
	erase "`c'switching.dta"
	erase "`c'reasons.dta"
	erase "`c'total.dta"

}
}