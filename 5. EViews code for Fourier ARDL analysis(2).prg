'EViews codes for Fractional Frequency Fourier ARDL analysis

'output matrix (mout)
matrix(5,2) mout
series y=gi
series x1=cpu
series x2=epu
series x3=gpr
series x4=eui

' manual calculation: long-run
' optimal frequncy: kk0
series trend=@trend+1
matrix(40,2) maic
matrix(40,1) mcof
scalar nn1=0
scalar aic0=-10000
For !kk=0.1 to 4 step 0.1
scalar no=@obs(y)
series sint=@sin(2*3.141592*trend*!kk/no)
series cost=@cos(2*3.141592*trend*!kk/no)
equation eq0.ls y y(-1) x1 x1(-1) x2 x2(-1) x3 x3(-1) x4 x4(-1) c sint cost
scalar aic1=eq0.@aic
scalar nn1=nn1+1
mcof(nn1,1)=eq0.@coefs(1)
maic(nn1,1)=eq0.@aic
maic(nn1,2)=!kk
	if aic1>aic0 then
	scalar kk0=!kk
	scalar aic0=eq0.@aic
endif
next

series sint0=@sin(2*3.141592*@trend*kk0/no)
series cost0=@cos(2*3.141592*@trend*kk0/no)
equation eq0.ls y y(-1) x1 x1(-1) x2 x2(-1) x3 x3(-1) x4 x4(-1) c sint0 cost0

' manual calculation: short-run
scalar lr11=(eq0.@coef(2)+eq0.@coef(3))/(1-eq0.@coef(1))
scalar lr12=(eq0.@coef(4)+eq0.@coef(5))/(1-eq0.@coef(1)) 
scalar lr13=(eq0.@coef(6)+eq0.@coef(7))/(1-eq0.@coef(1))
scalar lr14=(eq0.@coef(8)+eq0.@coef(9))/(1-eq0.@coef(1))
scalar lr2=(eq0.@coef(11)+eq0.@coef(12))/(1-eq0.@coef(1))
series coin=y-lr11*x1-lr12*x2-lr13*x3-lr14*x4-lr2*(sint0+cost0)
equation eq11.ls d(y) d(x1) d(x2) d(x3) d(x4) coin(-1) c 
equation eq12.ls d(y) d(x1) d(x2) d(x3) d(x4) c sint0 cost0 y(-1) x1(-1) x2(-1) x3(-1) x4(-1)
scalar ssr1=eq12.@ssr
equation eq13.ls d(y) d(x1) d(x2) d(x3) d(x4) c
scalar ssr2=eq13.@ssr
scalar ff_num=(ssr2-ssr1)/7
scalar ff_den=ssr1/eq12.@df
scalar ff=ff_num/ff_den

'calculation using "ardl
equation eq1.ardl(fixed, deplags=1, reglags=1) y x1 x2 x3 x4
equation eq10.ardl(fixed, deplags=1, reglags=1) y x1 x2 x3 x4 @ sint0 cost0

' 1) fixed
matrix(40,2) maic2
matrix(40,1) mcof2
scalar nn1=0
scalar aic02=-10000
For !kk=0.1 to 4 step 0.1
scalar no=@obs(y)
series sint=@sin(2*3.141592*trend*!kk/no)
series cost=@cos(2*3.141592*trend*!kk/no)
equation eq2.ardl(fixed, deplags=1, reglags=1) y x1 x2 x3 x4 @ sint cost
scalar aic2=eq2.@aic
scalar nn1=nn1+1
mcof2(nn1,1)=eq2.@coefs(1)
maic2(nn1,1)=eq2.@aic
maic2(nn1,2)=!kk
	if aic2>aic02 then
	scalar kk02=!kk
	scalar aic02=eq2.@aic
endif
next

' 2) determined by AIC
matrix(40,2) maic3
matrix(40,1) mcof3
scalar nn1=0
scalar aic03=-10000
For !kk=0.1 to 4 step 0.1
scalar no=@obs(y)
series sint=@sin(2*3.141592*trend*!kk/no)
series cost=@cos(2*3.141592*trend*!kk/no)
equation eq3.ardl(deplags=1, reglags=3) y x1 x2 x3 x4 @ sint cost
scalar aic3=eq3.@aic
scalar nn1=nn1+1
mcof3(nn1,1)=eq3.@coefs(1)
maic3(nn1,1)=eq3.@aic
maic3(nn1,2)=!kk
	if aic3>aic03 then
	scalar kk03=!kk
	scalar aic03=eq3.@aic
endif
next


