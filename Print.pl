isSorted([H1, H2 | T]) :- H1 @=< H2 -> isSorted(T);
                          0 @>= length(T) -> true;
                          false.
