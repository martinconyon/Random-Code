*****************************************************
* Stata Do File: Using duplicates to Manage Duplicates
*****************************************************

* Load example dataset for duplicate management
use "https://www.stata-press.com/data/r18/dupxmpl", clear

* Inspect the dataset structure
describe
list in 1/10

*****************************************************
* Example 1: Reporting Duplicates Across All Variables
*****************************************************

* Aim: Report duplicate records to identify any surplus copies
duplicates report

* Output shows how many duplicate copies exist and how many are surplus
* Duplicates are identified on all variables in the dataset

*****************************************************
* Example 2: Reporting Duplicates by Specific Variables
*****************************************************

* Aim: Check for duplicates based on specific variables (id, x, and y)
duplicates report id x y

* Output provides counts for duplicates and surplus copies on selected variables

*****************************************************
* Example 3: Tagging Duplicates
*****************************************************

* Aim: Create a variable that tags duplicates for easy identification
* The variable 'duptag' will indicate the number of duplicate copies (0 if unique)

duplicates tag, generate(duptag)

* Display the results, listing only tagged duplicates
list if duptag > 0

* To view duplicates in the Data Browser
* browse if duptag > 0

*****************************************************
* Example 4: Listing All Duplicates
*****************************************************

* Aim: List each occurrence of duplicated records based on all variables
duplicates list

* List all duplicates in dataset, showing groups of duplicate observations

*****************************************************
* Example 5: Listing Duplicates by Specific Variables with Separator
*****************************************************

* Aim: List duplicates by id, x, and y, separating by 'id' for easier viewing
duplicates list id x y, sepby(id)

* This lists duplicates specifically on id, x, and y, separating groups by 'id'

*****************************************************
* Example 6: Listing One Example of Each Duplicate Group
*****************************************************

* Aim: List only one example per group of duplicates
duplicates examples

* Provides a concise view by listing just the first record from each group of duplicates

*****************************************************
* Example 7: Dropping Duplicates
*****************************************************

* Aim: Drop duplicates based on all variables in the dataset
duplicates drop

* This keeps only the first occurrence of each duplicate group, removing surplus copies

*****************************************************
* Example 8: Dropping Duplicates on Specific Variables with Force Option
*****************************************************

* Aim: Drop duplicates on id, x, and y, even if other variables are not identical
* 'force' is required to confirm that dropping is intentional and controlled

duplicates drop id x y, force

* Keeps the first occurrence based on id, x, and y, discarding any others

*****************************************************
* Example 9: Summarizing Duplicate Management Steps
*****************************************************

* Reload dataset and tag duplicates to confirm operations
use "https://www.stata-press.com/data/r18/dupxmpl", clear
duplicates tag, generate(duptag)

* Summarize tagged duplicates
tabulate duptag

* Final listing of all unique observations after dropping duplicates
duplicates drop
list
