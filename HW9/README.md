# STAT W4201

## HW 9

Consider the colon data in the R package "survival". It gives adjuvant chemotherapy data for colon cancer. Levamisole is a low-toxicity compound previously used to treat worm infestations in animals; 5-FU is a moderately toxic (as these things go) chemotherapy agent. There are two records per person, one for recurrence (etype=1) and one for death (etype=2).

Other important variables include:
- rx: Treatment: Obs(ervation), Lev(amisole), Lev(amisole)+5-FU
- sex: 1=male 
- age: in years 
- time: days until event or censoring 
- status: censoring status

For the following, consider survival to be “Days until Death”, i.e., etype=2.

### Problem 1

> Using the Kaplan-Meier method, estimate the survival curve for each treatment group: Lev(amisole) and Lev(amisole)+5-FU.

### Problem 2

> Estimate the median survival time for each of the two treatment groups, using the estimated survival curves.

### Problem 3

> Using the log-rank test, determine whether there is a difference in survival between the two groups.

### Problem 4
> Using a Cox proportional hazards model, estimate the hazard rate for Levamisole relative to 5-FU, adjusting for Age and Sex.

### Problem 5

> Give a 95% confidence interval for the hazard rate in 4.
> Repeat 1 using the L-1 regularized logistic regression.
