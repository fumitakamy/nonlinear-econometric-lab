' fractional frequency fourier adf (FFF-ADF) test

'output matrix (mout)
'first column: optimal frequncy
'second column: FFF-ADF staitic
matrix(5,2) mout
For !k=1 to 5

if !k==1 then
series nn=gi
endif

if !k==2 then
series nn=cpu
endif

if !k==3 then
series nn=epu
endif

if !k==4 then
series nn=gpr
endif

if !k==5 then
series nn=eui
endif

scalar aic0=-10000

For !kk=0.1 to 4 step 0.1
series trendt=@trend
scalar no=@obs(nn)
series sint=@sin(2*3.141592*trendt*!kk/no)
series cost=@cos(2*3.141592*trendt*!kk/no)
equation eq1.ls d(nn) nn(-1) d(nn(-1)) c trendt sint cost

scalar aic1=eq1.@aic
if aic1>aic0 then
mout(!k,1)=!kk
mout(!k,2)=eq1.@tstats(1)
scalar aic0=eq1.@aic
endif

next     

next


