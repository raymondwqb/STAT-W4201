# STAT W4201

## HW 8

### Problem 1
> Reading Assignment: Ramsey and Schafer (2nd Ed), Chapter 22 (Log-Linear Regression for Poisson Counts).

### Problem 2
#### Consider the Valve characteristics data (Display 22.16, Ramsey and Schafer, 2nd Ed).
Display 22.16 shows characteristics and numbers of failures observed in valve types from one pressurized water reactor.
There are five explanatory factors:
- system (1 = containment, 2 = nuclear, 3 = power conversion, 4 = safety, 5 = process auxiliary);
- operator type (1 = air, 2 = solenoid, 3 = motor-driven, 4 = manual); 
- valve type (1 = ball, 2 = butterfly, 3 = diaphragm, 4 = gate, 5 = globe, 6 = directional control); 
- head size (1 = less than 2 inches, 2 = 2–10 inches, 3 = 10–30 inches);
- operation mode (1 = normally closed, 2 = normally open). 

The lengths of observation periods are quite different, as indicated in the last column, time. Using an offset for log of observation time, identify the factors associated with large numbers of valve failures.

> (a). Repeat 1 for all 4 Diet Levels.    
> (b). Do Problem Number 24, Page 667, using the R function glm.    
> (c). Assess the goodness of fit of the model.    

### Problem 3
> Repeat 2(a) using the glmnet package and comment on the results.

### Display 22.16 (First 6 of 91 rows)
| System | Operator | Valve | Size | Mode | Failures | Time |
|:------:|:--------:|:-----:|:----:|:----:|:--------:|:----:|
|1       |3         |4      |3     |1     |2         |4     |
|1       |3         |4      |3     |2     |2         |4     |
|1       |3         |5      |1     |1     |1         |2     |
|2       |1         |2      |2     |2     |0         |2     |
|2       |1         |3      |2     |1     |0         |2     |
|2       |1         |3      |2     |2     |0         |1     |
|...     |...       |...    |...   |...   |...       |...   |

