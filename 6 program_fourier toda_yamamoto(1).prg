'toda-yamamoto

matrix(5,2) mout
series y=gi
For !k=1 to 4

If !k=1 then 
series x=cpu
endif
If !k=2 then 
series x=epu
endif
If !k=3 then 
series x=gpr
endif
If !k=4 then 
series x4=eui
endif

matrix(40,2) maic
matrix(40,1) mcof
scalar nn1=0
scalar aic0=-10000
For !kk=0.1 to 4 step 0.1
scalar no=@obs(y)
series sint=@sin(2*3.141592*@trend*!kk/no)
series cost=@cos(2*3.141592*@trend*!kk/no)
var var0.ls 1 2 y x @ c @trend y(-3) x(-3) sint cost
scalar aic1=var0.@aic
scalar nn1=nn1+1
maic(nn1,1)=var0.@aic
	if aic1>aic0 then
	scalar kk0=!kk
	scalar aic0=var0.@aic
	endif
next
series sint0=@sin(2*3.141592*@trend*kk0/no)
series cost0=@cos(2*3.141592*@trend*kk0/no)
var var0.ls 1 2 y x @ c @trend y(-3) x(-3) sint0 cost0
freeze(tab!k) var0.testexog(name=exog)
delete exog

next


