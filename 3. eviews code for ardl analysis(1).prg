' EViews code for ARDL analysis

'output matrix (mout)
matrix(2,1) mout

series y=gi
series x1=cpu
series x2=epu
series x3=gpr
series x4=eui

'manual calcutation for long-run
equation eq0.ls y y(-1) x1 x1(-1) x2 x2(-1) x3 x3(-1) x4 x4(-1) c @trend
scalar lr11=(eq0.@coef(2)+eq0.@coef(3))/(1-eq0.@coef(1))
scalar lr12=(eq0.@coef(4)+eq0.@coef(5))/(1-eq0.@coef(1)) 
scalar lr13=(eq0.@coef(6)+eq0.@coef(7))/(1-eq0.@coef(1))
scalar lr14=(eq0.@coef(8)+eq0.@coef(9))/(1-eq0.@coef(1))
scalar lr2=eq0.@coef(11)/(1-eq0.@coef(1))
series coin=y-lr11*x1-lr12*x2-lr13*x3-lr14*x4-lr2*@trend
equation eq11.ls d(y) d(x1) d(x2) d(x3) d(x4) coin(-1) c 

'manual calculation for conditional error correction
equation eq12.ls d(y) d(x1) d(x2) d(x3) d(x4) c @trend y(-1) x1(-1) x2(-1) x3(-1) x4(-1)
scalar ssr1=eq12.@ssr
equation eq13.ls d(y) d(x1) d(x2) d(x3) d(x4) c
scalar ssr2=eq13.@ssr
scalar ff_num=(ssr2-ssr1)/(eq12.@ncoef-eq13.@ncoef)
scalar ff_den=ssr1/eq12.@df

'bounds test statistic
scalar ff=ff_num/ff_den
mout(1,1)=ff

'calculation using "ardl
equation eq1.ardl(fixed, deplags=1, reglags=1,trend=linear) y x1 x2 x3 x4
freeze(table1) eq1.boundstest
mout(2,1)=table1(48,2)


