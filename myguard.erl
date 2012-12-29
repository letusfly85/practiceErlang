-module (myguard).
-export ([sample/2,samplee/3]).

sample(X,Y) when X > Y -> X;
sample(X,Y) -> Y.

samplee(A, B, L) when A >= -1.0 andalso A+1 > B and
        is_atom(L) orelse (is_list(L) andalso length(L) >2) -> L.
