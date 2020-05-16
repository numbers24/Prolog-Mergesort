range(S,E,M) :- S<E,S=<M,M=<E.

?- range(1,2,2).
?- not(range(1,2,3)).

reverseL(X,RevX):- rev(X,RevX,[]).
rev([],X,X).
rev([H|T],X,RevX):-rev(T,X,[H|RevX]).

?- reverseL([],X).
?- reverseL([1,2,3],X).
?- reverseL([a,b,c],X).

memberL(X,[X|_]).
memberL(X,[_|T]) :- memberL(X,T).

?- not(memberL(1, [])).
?- memberL(1,[1,2,3]).
?- not(memberL(4,[1,2,3])).
?- memberL(X, [1,2,3]).

zip([],[],[]).
zip([_|_],[],[]).
zip([],[_|_],[]).
zip([X|T1],[Y|T2],[X-Y|T3]) :- zip(T1,T2,T3).

?- zip([1,2],[a,b],Z).
?- zip([a,b,c,d], [1,X,y], Z).
?- zip([a,b,c],[1,X,y,z], Z).
?- length(A,2), length(B,2), zip(A, B, [1-a, 2-b]).

insert(X,[],[X]).
insert(X,[H|T],[X,H|T]) :- X =< H,!.
insert(X,[H|T1],[H|T2]) :- insert(X,T1,T2).

?- insert(3, [2,4,5], L).
?- insert(3, [1,2,3], L).
?- not(insert(3, [1,2,4], [1,2,3])).
?- insert(3, L, [2,3,4,5]).
?- insert(9, L, [1,3,6,9]).
?- insert(3, L, [1,3,3,5]).


remove_duplicates(L1,L2) :- remove_duplicates(L1,[],L2).
remove_duplicates([],_,[]).
remove_duplicates([H|T],ACC,X) :- memberL(H,ACC), remove_duplicates(T,ACC,X).
remove_duplicates([H|T],ACC,[H|X]) :- not(memberL(H,ACC)), remove_duplicates(T,[H|ACC],X).


?- remove_duplicates([1,2,3,4,2,3],X).
?- remove_duplicates([1,4,5,4,2,7,5,1,3],X).
?- remove_duplicates([], X).

intersectionL([],_,[]).
intersectionL([H|T1],L2,[H|T2]) :- memberL(H,L2), !, intersectionL(T1,L2,T2).
intersectionL([_|T],L2,L3) :- intersectionL(T,L2,L3).

?- intersectionL([1,2,3,4],[1,3,5,6],[1,3]).
?- intersectionL([1,2,3,4],[1,3,5,6],X).
?- intersectionL([1,2,3],[4,3],[3]).

prefix(P,L) :- append(P,_,L).
suffix(S,L) :- append(_,S,L).

partition([],[],[]).
partition([H],[H],[]).
partition(L,P,S) :- length(L,N), length(P,PL), PL is div(N,2), length(S,SL), SL is N-div(N,2), prefix(P,L), suffix(S,L),!.


?- partition([a],[a],[]).
?- partition([1,2,3],[1],[2,3]).
?- partition([a,b,c,d],X,Y).

merge([],X,X).
merge(X,[],X).
merge([],[],[]).
merge([H1|T1],[H2|T2],[H1|T3]) :- H1=<H2, merge(T1,[H2|T2],T3). 
merge([H1|T1],[H2|T2],[H2|T3]) :- H1>H2, merge([H1|T1],T2,T3).

?- merge([],[1],[1]).
?- merge([1],[],[1]).
?- merge([1,3,5],[2,4,6],X).

mergesort([],[]).
mergesort([A],[A]).
mergesort([H1,H2|T],S) :- partition([H1,H2|T],L,R), mergesort(L,SL), mergesort(R,SR), merge(SL,SR,S).

?- mergesort([3,2,1],X).
?- mergesort([1,2,3],Y).
?- mergesort([],Z).
