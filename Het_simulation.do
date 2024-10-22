* Set pwd

cd "/Users/martin/Sync/Teaching/Teaching - 2024 PhD1502 Econometrics"

* Log output
capture log close
log using het_sim, replace

* Where am I?

pwd

* Clear all data and set seed for reproducibility
clear all
set seed 12345


* Set the number of observations
set obs 1000

* Generate independent variables
generate x1 = rnormal(0, 1)
generate x2 = rnormal(0, 1)

* Generate error term with constant variance (homoskedasticity)
generate u = rnormal(0, 1)

* Define true coefficients
scalar beta0 = 2
scalar beta1 = 3
scalar beta2 = -1

* Generate dependent variable
generate y = beta0 + beta1*x1 + beta2*x2 + u

* Estimate OLS model
regress y x1 x2

* Test for heteroskedasticity using Breusch-Pagan test
estat hettest

* Test for heteroskedasticity using White's test
estat imtest, white

* Create a scatter plot of residuals vs. x1 for homoskedastic model
predict resid_homo, residuals
twoway (scatter resid_homo x1), ///
    title("Residuals vs x1 (Homoskedastic Model)") ///
    xlabel(minmax) ylabel(minmax)
graph export "homoskedastic_residuals.png", replace

* Homoskedastic model estimation with robust standard errors
regress y x1 x2, robust

* Store results
estimates store homo_model

* Introduce heteroskedasticity into the error term
drop u
generate u_het = (1 + 0.5*x1)*rnormal(0, 1)

* Generate new dependent variable with heteroskedastic errors
generate y_het = beta0 + beta1*x1 + beta2*x2 + u_het

* Estimate OLS model on the heteroskedastic data
regress y_het x1 x2

* Test for heteroskedasticity using Breusch-Pagan test
estat hettest

* Test for heteroskedasticity using White's test
estat imtest, white

* Create a scatter plot of residuals vs. x1 for heteroskedastic model
predict resid_het, residuals
twoway (scatter resid_het x1), ///
    title("Residuals vs x1 (Heteroskedastic Model)") ///
    xlabel(minmax) ylabel(minmax)
graph export "heteroskedastic_residuals.png", replace

* Heteroskedastic model estimation with robust standard errors
regress y_het x1 x2, robust

* Store results
estimates store het_model

* Compare coefficients and standard errors
* Install 'estout' package if not installed
cap which esttab
if _rc ssc install estout

* Create a table comparing the two models
esttab homo_model het_model using "model_comparison.rtf", replace se b(%9.4f) se(%9.4f) label

* Alternatively, display results in Stata
esttab homo_model het_model, se b(%9.4f) se(%9.4f) label


