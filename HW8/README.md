# STAT W4201

## HW 8

### Problem 1
> Reading Assignment: Ramsey and Schafer (2nd Ed), Chapter 22 (Log-Linear Regression for Poisson Counts).

### Problem 2
#### Consider the Valve characteristics data (Display 22.16, Ramsey and Schafer, 2nd Ed).
Display 22.16 shows characteristics and numbers of failures observed in valve types from one pressurized water reactor.
There are five explanatory factors:
- system (1 D containment, 2 D nuclear, 3 D power conversion, 4 D safety, 5 D process auxiliary);
- operator type (1 D air, 2 D solenoid, 3 D motor-driven, 4 D manual); 
- valve type (1 D ball, 2 D butterfly, 3 D diaphragm, 4 D gate, 5 D globe, 6 D directional control); 
- head size (1 D less than 2 inches, 2 D 2–10 inches, 3 D 10–30 inches);
- operation mode (1 D normally closed, 2 D normally open). 

The lengths of observation periods are quite different, as indicated in the last column, time. Using an offset for log of observation time, identify the factors associated with large numbers of valve failures.

> (a). Repeat 1 for all 4 Diet Levels.    
> (b). Do Problem Number 24, Page 667, using the R function glm.    
> (c). Assess the goodness of fit of the model.    

### Problem 3
> Repeat 2(a) using the glmnet package and comment on the results.

### Display 22.16
| System | Operator | Value | Size | Mode | Failures | Time |
|:------:|:--------:|:-----:|:----:|:----:|:--------:|:----:|
|1       |3         |4      |3     |1     |2         |4     |
|1       |3         |4      |3     |2     |2         |4     |
|1       |3         |5      |1     |1     |1         |2     |
|2       |1         |2      |2     |2     |0         |2     |
|2       |1         |3      |2     |1     |0         |2     |
|2       |1         |3      |2     |2     |0         |1     |

