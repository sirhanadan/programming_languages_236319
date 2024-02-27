
%base cases: 0 + n = n.
add(bot, bot, bot).
add( X, bot, X).
add( bot, X, X).
%recursion: n + m = (n-1) + (m+1) -> call recursively until 0 is  reached.
add( s(A), B, R):-
    add(A, s(B), R).


%base case: 0*anything = 0
multiply( _, bot, bot).
multiply(bot, _, bot).
%recursion: A * B = B + B + ... + B (A times)
multiply( s(A), B, R):-
    multiply(A, B, R1), 
    add(B, R1, R).

%base case: anything to the power of 0 is 1. (0^0 isn't a valid input)
power(_, bot, s(bot)).
%base case: 1 to the power of anyting is 1.
power(s(bot), _ , s(bot)).
%base case: anything to the power of 1 is itself.
power( X, s(bot), X).
%recursion: A^B = A * A * ... * A (B times).
power( A, s(B), R):-
    power( A, B, R1),
    multiply(A, R1, R).



