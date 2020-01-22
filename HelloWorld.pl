likes(ian, prolog).
likes(newcomb, prolog).
likes(ian, newcomb).

likes(X, Y) :- likes(Y, X).
