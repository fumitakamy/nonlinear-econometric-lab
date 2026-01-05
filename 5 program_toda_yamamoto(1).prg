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

var var!k.ls 1 2 y x @ c @trend y(-3) x(-3)
freeze(tab!k) var!k.testexog(name=exog)
delete exog

next


