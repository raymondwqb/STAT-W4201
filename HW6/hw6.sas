libname repeat 'C:\Users\QIANBO\Desktop\HW6';
*import data from csv;
proc import out=repeat.repeatdata
    Datafile = 'C:\Users\QIANBO\Desktop\HW6\ChickWeight.csv'
    Dbms =csv replace;
run;
proc print data = repeat.repeatdata;
run;

ods listing close;
ods graphics on;
options papersize=letter;
ods pdf file='C:\Users\QIANBO\Desktop\HW6\compoundsy.pdf';
title'Repeated Measures on Chick Weight';
title2'compound symmetry assumption';

*correlation compound symmetry assumption;
proc mixed data = repeat.repeatdata;
class Diet Chick Time;
model weight= Diet Time Diet*Time / outp=repeat.csparam residual;
repeated/type=cs sub=Chick(Diet) rcorr ;
run;
ods pdf close;

ods pdf file='C:\Users\QIANBO\Desktop\HW6\unstructured.pdf';
title'Repeated Measures on Chick Weight';
title2'unstructured correlation assumption';
*correlation unstructured assumption;
proc mixed data = repeat.repeatdata;
class Diet Chick Time;
model weight = Diet Time Diet*Time / outp=repeat.unparam residual;
repeated/type=un sub=Chick(Diet) rcorr;
run;
ods pdf close;
ods graphics off;

ods pdf file='C:\Users\QIANBO\Desktop\HW6\normalcs.pdf';
title'Noramlity test on residuals';
title2'compound symmetry assumption';
*test normality;
proc univariate data=repeat.csparam normal; 
var resid;
run;
ods pdf close;

ods pdf file='C:\Users\QIANBO\Desktop\HW6\normalun.pdf';
title'Noramlity test on residuals';
title2'unstructured correlation assumption';
*test normality;
proc univariate data=repeat.unparam normal; 
var resid;
run;
ods pdf close;

ods pdf file='C:\Users\QIANBO\Desktop\HW6\homo.pdf';
title'Constant Variance test on raw data';
title2;
proc glm data=repeat.repeatdata; 
class Diet Chick Time; 
model weight = Diet;  
means Diet / HOVTEST=BARTLETT;  
means Diet / HOVTEST=LEVENE;
run;
ods pdf close;
ods listing;
title;
