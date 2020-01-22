/*
Determines if a number is prime.
isPrime(3). will return true, because 3 is prime.
isPrime(4). will return false, because 4 is not prime.
*/

isPrime(X) :- X @=< 2 -> true; prime(X, 2).
prime(X, Y) :- Y @>= X -> true; isDivisibleBy(X, Y) -> false; prime(X, Y+1).
isDivisibleBy(X, Y) :- 0 is X mod Y. 
