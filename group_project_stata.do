* ---------------------------------------------------------------------------- *
* Stata Script for STATS 506 Group Project:
*   Parametric and Nonparametric ANOVA
* 
* Stata version: Stata SE 14.0
*
* Data: Diet.csv
*   imported from the working directory
* 
* Author: Xinye Jiang (xinyej@umich.edu)
* Updated: November 22, 2018
* ---------------------------------------------------------------------------- *

*---------------------------------*
* Import and process the data set *
*---------------------------------*

* Import the dataset
import delimited Diet.csv

* Observe the data preliminarily by checking its summary
summarize

* Take a deeper look at the variable 'gender'
list gender in 1/10

* Remove observations with missing values in 'gender' and destring 'gender'
drop if gender == " "
destring gender, replace

* Generate the variable 'weightloss'
generate weightloss = weight6weeks - preweight

* Keep only the needed variables and save the dataset
keep gender diet weightloss
save diet.dta

* Divide the dataset by 'gender'
keep if gender == 0
save diet_female.dta
use diet.dta, clear
keep if gender == 1
save diet_male.dta


*------------------*
* Parametric ANOVA *
*------------------*

* Parametric one-way ANOVA for female data
* Regard 'diet' as the grouping variable
use diet_female.dta, clear
oneway weightloss diet, tabulate
* Run the Tukey post hoc test for pairwise comparison
pwmean weightloss, over(diet) mcompare(tukey) effects

* Parametric one-way ANOVA for male data
* Regard 'diet' as the grouping variable
use diet_male.dta, clear
oneway weightloss diet, tabulate
* Run the Tukey post hoc test for pairwise comparison
pwmean weightloss, over(diet) mcompare(tukey) effects

* Parametric two-way ANOVA for the whole dataset
* Regard 'gender' and 'diet' as two grouping variables
use diet.dta, clear
anova weightloss i.gender##i.diet
* Pairwise comparison
* contrast g.gender##g.diet


*------------------------------------------*
* Nonparametric ANOVA: Kruskal-Wallis Test *
*------------------------------------------*

* Nonparametric ANOVA for female data
use diet_female.dta, clear
kwallis weightloss, by(diet)

* Non-parametric ANOVA for male data
use diet_male.dta, clear
kwallis weightloss, by(diet)


