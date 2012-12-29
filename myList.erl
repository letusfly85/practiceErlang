-module (myList).
-export ([sumList/2]).

sumList([H|T], Result) -> sumList(T, [H|Result]);
sumList([],    Result) -> Result.
