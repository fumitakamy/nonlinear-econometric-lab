'EViews code for Toda-Yamamoto causality test

'output matrix (mout)
matrix(4,3) mout1
matrix(4,3) mout2
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

var var!k.ls 1 2 y x @ c @trend y(-3) x(-3)
freeze(tab!k) var!k.testexog(name=exog)
delete exog

mout1(!k,1)=tab!k(11,2)
mout2(!k,1)=tab!k(20,2)

equation eq1.ls y y(-1) y(-2) y(-3) c @trend x(-1) x(-2) x(-3)
freeze(tab1!k) eq1.wald c(6)=0, c(7)=0
mout1(!k,2)=tab1!k(7,2)
mout1(!k,3)=tab1!k(6,2)

equation eq2.ls x x(-1) x(-2) x(-3) c @trend y(-1) y(-2) y(-3)
freeze(tab2!k) eq2.wald c(6)=0, c(7)=0
mout2(!k,2)=tab2!k(7,2)
mout2(!k,3)=tab2!k(6,2)


next


