Set i  securities   /hardware, software, show-biz, t-bills/;
alias (i,j);

Scalar target     target mean annual return on portfolio % /100/,
       lowyield   yield of lowest yielding security,
       highrisk   variance of highest security risk ;

Parameters  mean(i)  mean annual returns on individual securities (%)
      / hardware   8
        software   9
        show-biz  12
        t-bills    7 /

Table v(i,j)  variance-covariance array (%-squared annual return)
                  hardware  software  show-biz  t-bills
       hardware      4         3         -1        0
       software      3         6          1        0
       show-biz     -1         1         10        0
       t-bills       0         0          0        0 ;

lowyield = smin(i, mean(i)) ;
highrisk = smax(i, v(i,i)) ;
display lowyield, highrisk ;

Variables  x(i)       fraction of portfolio invested in asset i
           variance   variance of portfolio
Positive Variable x;

Equations  fsum    fractions must add to 1.0
           dmean   definition of mean return on portfolio
           dvar    definition of variance;

fsum..     sum(i, x(i))                     =e=  10.0;
dmean..    sum(i, mean(i)*x(i))             =e=  target;
dvar..     sum(i, x(i)*sum(j,v(i,j)*x(j)))  =e=  variance;

Model portfolio  / fsum, dmean, dvar / ;
Solve portfolio using nlp minimizing variance;
display x.l, variance.l;