pythagorean(A, B, C) :-
    A_Squared  is A * A,
    B_Squared  is B * B,
    C_Squared  is C * C,
    Sum is A_Squared + B_Squared,
    C_Squared =:= Sum.

    
devs(N, N).

devs(N, D)  :- N > 2,
    D > 1, 
    D =\= N,
    N mod D =\= 0,
    Next is D + 1,
    devs(N, Next).


prime(2).
prime(N) :- N > 2, devs(N, 2).


is_even(N) :- N > 2, N mod 2 =:= 0.

goldbach(X, Y, N) :-
    is_even(N),
    goldbach_aux(X, Y, N, 2).

goldbach_aux(X, Y, N, R) :-
    R < N,
    prime(R),
    Y is N - R,
    prime(Y),
    X = R.

goldbach_aux(X, Y, N, R) :-
    R < N,
    Next is R + 1,
    goldbach_aux(X, Y, N, Next).
