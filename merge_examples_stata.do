* Merge examples using Stata

*****************************************************
* Example 1: One-to-one merge with assert option
*****************************************************

* Aim: Perform a 1:1 merge on "make" variable, requiring exact matches
use "https://www.stata-press.com/data/r18/autosize", clear
describe
list

* Perform merge, ensuring all observations match with assert(match)

merge 1:1 make using "https://www.stata-press.com/data/r18/autoexpense"

* merge 1:1 make using "https://www.stata-press.com/data/r18/autoexpense", assert(match)

* Uncomment to see work.  Will stop program because not matched


* Display merged results
tabulate _merge
list

*****************************************************
* Example 2: Keep only matched observations, no _merge variable
*****************************************************

* Aim: Retain only matched observations and avoid generating _merge variable
use "https://www.stata-press.com/data/r18/autosize", clear

* Remove _merge if it exists to prevent conflicts
capture drop _merge

* Perform merge, keeping only matched observations and suppressing _merge variable
merge 1:1 make using "https://www.stata-press.com/data/r18/autoexpense", keep(match) nogenerate

* Display final dataset with only matched observations
list

*****************************************************
* Example 3: Many-to-one merge with region data
*****************************************************

* Aim: Perform an m:1 merge where each region in master matches one region in using dataset
use "https://www.stata-press.com/data/r18/sforce", clear

* Drop _merge if it exists to avoid conflicts
capture drop _merge

* Merge with many-to-one relationship on "region" variable
merge m:1 region using "https://www.stata-press.com/data/r18/dollars"

* Display merge results to verify matches
tabulate _merge

*****************************************************
* Example 4: Overlapping variables, master values take precedence
*****************************************************

* Aim: Many-to-one merge, keeping values from master dataset where variables overlap
use "https://www.stata-press.com/data/r18/overlap1", clear

* Drop _merge if it exists
capture drop _merge

* Perform m:1 merge on "id" with overlap in variable names; master data takes precedence
merge m:1 id using "https://www.stata-press.com/data/r18/overlap2"

* Display merged data, grouped by unique ids
list, sepby(id)

*****************************************************
* Example 5: Update missing data in master from using dataset
*****************************************************

* Aim: Merge and update missing values in master dataset with values from using dataset
use "https://www.stata-press.com/data/r18/overlap1", clear

* Drop _merge if it exists
capture drop _merge

* Perform merge with update option to fill missing master values
merge m:1 id using "https://www.stata-press.com/data/r18/overlap2", update

* Display results to check updated values
list, sepby(id)

*****************************************************
* Example 6: Replace non-missing master data with values from using dataset
*****************************************************

* Aim: Merge and replace all values in master dataset with those in using dataset where available
use "https://www.stata-press.com/data/r18/overlap1", clear

* Drop _merge if it exists
capture drop _merge

* Perform merge with update replace option to replace master values
merge m:1 id using "https://www.stata-press.com/data/r18/overlap2", update replace

* Display results to check replaced values
list, sepby(id)

*****************************************************
* Example 7: Keep only matched data after updating
*****************************************************

* Aim: Merge and keep only matched records after updating missing values in master dataset
use "https://www.stata-press.com/data/r18/overlap1", clear

* Drop _merge if it exists
capture drop _merge

* Perform merge with update option, keep only matched and updated observations
merge m:1 id using "https://www.stata-press.com/data/r18/overlap2", update keep(3 4 5)

* Display matched and updated data only
list, sepby(id)

*****************************************************
* Example 8: One-to-many merge with overlap datasets
*****************************************************

* Aim: Perform a 1:m merge on "id" variable with multiple entries in using dataset
use "https://www.stata-press.com/data/r18/overlap2", clear

* Drop _merge if it exists
capture drop _merge

* Perform 1:m merge on "id" allowing multiple matches in using dataset
merge 1:m id using "https://www.stata-press.com/data/r18/overlap1"

* Display merged data by unique id
list, sepby(id)
