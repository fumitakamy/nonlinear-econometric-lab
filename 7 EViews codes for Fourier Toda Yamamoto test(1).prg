'Fractional Frequency Fourier Toda-Yamamoto causality test

'output matrix (mout)
matrix(4,4) mout
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
series x=eui
endif

'estimation using VAR
matrix(40,2) maic
matrix(40,1) mcof
scalar nn1=0
scalar aic0=-10000
For !kk=0.1 to 4 step 0.1
scalar no=@obs(y)
series sint=@sin(2*3.141592*@trend*!kk/no)
series cost=@cos(2*3.141592*@trend*!kk/no)
var var00.ls 1 2 y x @ c @trend y(-3) x(-3) sint cost
scalar aic1=var00.@aic
scalar nn1=nn1+1
maic(nn1,1)=var00.@aic
	if aic1>aic0 then
	scalar kk0!k=!kk
	scalar aic0=var00.@aic
	endif
next
series sint0=@sin(2*3.141592*@trend*kk0!k/no)
series cost0=@cos(2*3.141592*@trend*kk0!k/no)
var var0.ls 1 2 y x @ c @trend y(-3) x(-3) sint0 cost0
freeze(tab!k) var0.testexog(name=exog)
delete exog

'mout(!k,1)=tab!k(11,2)
'mout(!k,2)=tab!k(20,2)

equation eq2.ls y y(-1) y(-2) x(-1) x(-2) c @trend y(-3) x(-3) sint0 cost0
eq2.makeresids res1
stom(res1, resm1)
matrix resmi1=@transpose(resm1)
scalar ssr11=resmi1*resm1
scalar ssr12=eq2.@ssr
scalar n1=resm1.@rows
scalar pi=4*@atan(1)
scalar lk11=-(n1/2)*(1+@log(pi*2)+@log(ssr11/n1))
scalar lk12=eq2.@logl
scalar nk=n1-eq2.@df
scalar df=eq2.@df
scalar obs=@obs(y)
scalar akaike11=(-2*lk11/n1)+(2*nk/n1)
scalar akaike12=eq2.@aic
scalar akaike13=-2*(lk12/n1)+2*(nk/n1)

equation eq3.ls x y(-1) y(-2) x(-1) x(-2) c @trend y(-3) x(-3) sint0 cost0
eq3.makeresids res1
stom(res1, resm1)
matrix resmi1=@transpose(resm1)
scalar ssr21=resmi1*resm1
scalar ssr22=eq3.@ssr
scalar n1=resm1.@rows
scalar pi=4*@atan(1)
scalar lk21=-(n1/2)*(1+@log(pi*2)+@log(ssr21/n1))
scalar lk22=eq3.@logl
scalar nk=n1-eq3.@df
scalar df=eq3.@df
scalar obs=@obs(y)
scalar akaike21=(-2*lk21/n1)+(2*nk/n1)
scalar akaike22=eq3.@aic
scalar akaike23=-2*(lk22/n1)+2*(nk/n1)

scalar lk21=-(n1/2)*(1+@log(pi*2)+@log((ssr11+ssr21)/n1))
scalar lk22=var0.@logl
scalar akaike31=-2*(lk21/n1)+2*(nk*2/n1)
scalar akaike32=-2*(lk22/(n1))+2*(nk*2/n1)
scalar akaike33=var0.@aic

'dependent variable is y
scalar nn1=0
scalar aic01=-10000
For !kk=0.1 to 4 step 0.1
scalar no=@obs(y)
series sint=@sin(2*3.141592*@trend*!kk/no)
series cost=@cos(2*3.141592*@trend*!kk/no)
equation eq01.ls y y(-1) y(-2) x(-1) x(-2) c @trend y(-3) x(-3) sint cost
scalar aic11=eq01.@aic
scalar nn1=nn1+1
	if aic11>aic01 then
	scalar kk01!k=!kk
	scalar aic01=eq01.@aic
	endif
next
series sint0=@sin(2*3.141592*@trend*kk01!k/no)
series cost0=@cos(2*3.141592*@trend*kk01!k/no)
equation eq01!k.ls y y(-1) y(-2) x(-1) x(-2) c @trend y(-3) x(-3) sint0 cost0
freeze(tab01!k) eq01!k.wald c(5)=0,c(6)=0,c(7)=0,c(8)=0,c(9)=0,c(10)=0  

mout(!k,1)=kk01!k
mout(!k,2)=tab01!k(6,2)

'dependent variable is x
scalar nn1=0
scalar aic02=-10000
For !kk=0.1 to 4 step 0.1
scalar no=@obs(y)
series sint=@sin(2*3.141592*@trend*!kk/no)
series cost=@cos(2*3.141592*@trend*!kk/no)
equation eq02.ls x y(-1) y(-2) x(-1) x(-2) c @trend y(-3) x(-3) sint cost
scalar aic12=eq02.@aic
scalar nn1=nn1+1
	if aic12>aic02 then
	scalar kk02!k=!kk
	scalar aic02=eq02.@aic
	endif
next
series sint0=@sin(2*3.141592*@trend*kk02!k/no)
series cost0=@cos(2*3.141592*@trend*kk02!k/no)
equation eq02!k.ls x y(-1) y(-2) x(-1) x(-2) c @trend y(-3) x(-3) sint0 cost0
freeze(tab02!k) eq02!k.wald c(5)=0,c(6)=0,c(7)=0,c(8)=0,c(9)=0,c(10)=0 

mout(!k,3)=kk02!k
mout(!k,4)=tab02!k(6,2)

next


