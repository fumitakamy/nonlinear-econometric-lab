' adf test

'output matrix (mout)
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

nn.uroot(adf,exog=trend,lag=1,save=mout1)
mout(!k,1)=mout1(3,1)
equation eq1.ls d(nn) nn(-1) d(nn(-1)) c @trend
mout(!k,2)=eq1.@tstats(1)

'scalar kk=1
'series sint=@sin(2*3.141592*@trend*kk/@obs(nn))
'series cost=@cos(2*3.141592*@trend*kk/@obs(nn))
'nn.uroot(adf, exog=sint, lag=1,save=mout1)

next


