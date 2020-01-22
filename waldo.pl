/*
Ian Cowan
Waldo in Prolog
CSC 341

You must run this in SWI Prolog for everything to run correctly.
To run, follow the directions below:

1. In the same directory as "waldo.pl", type
-  swipl waldo.pl
2. Enter your desired inputs in the form that follows:
-  If a single package, simply enter " a. "
-  If multiple packages, use single quotes so " 'a b'. "
3. When finished, press the associated EOF key, or type " end_of_file. "

Example:

Input:
    swipl waldo.pl
    |: 'waldo a b'.
    |: 'a b'.
    |: b.

Output:
    b
    a
    waldo
*/

% Clear all of the possible database entries
:- abolish(package/1).
:- abolish(dependency/2).
:- abolish(installing/1).
:- abolish(installed/1).

% Run the program
run :- getInputs(),
       halt().

% Gets the inputs from the user and adds them to
% the database as necessary
getInputs() :- read(X),
               getInputs(X).
getInputs(X) :- X = end_of_file,
                writeln(''),
                printPackageOrder(waldo, 0),
                retractall(installing(Y)),
                retractall(installed(Y)),
                printPackageOrder(waldo, 1).
getInputs(X) :- atomic_list_concat(L, ' ', X),
                create_rule(L),
                getInputs().

% Creates a rule for a particular
% In more detail, this adds a package to the database
% and then results to the rule to add its dependencies
create_rule([H | T]) :- assert(package(H)),
                        addDepends(H, T).

% Adds a package's dependencies to the database
addDepends(_, []) :- true.
addDepends(P, [D | T]) :- assert(dependency(P, D)),
                          addDepends(P, T).

% Prints the packages in order
% The program makes 2 passes:
%    The first pass makes sure waldo can be installed with no error
%    The second pass prints out the packages in their proper install order
printPackageOrder(X, _) :- installed(X).
printPackageOrder(X, _) :- installing(X),
                        writeln('ERROR'),
                        halt().
printPackageOrder(X, B) :- package(X),
                        assert(installing(X)),
                        findall(D, dependency(X, D), L),
                        printPackageOrder(L, B),
                        printPackage(X, B),
                        retract(installing(X)),
                        assert(installed(X)).
printPackageOrder([], _) :- true.
printPackageOrder([H | T], B) :- printPackageOrder(H, B),
                                 printPackageOrder(T, B).
printPackageOrder(X, _) :- not(package(X)),
                           writeln('ERROR'),
                           halt().
printPackageOrder(X, B) :- printPackage(X, B),
                           assert(installed(X)).

% Checks to see if the package should be printed or not
% depending on the pass 
printPackage(_, B) :- B = 0.
printPackage(X, B) :- B = 1, writeln(X).

% Dynamic rules for the database
:- dynamic package/1.
:- dynamic dependency/2.
:- dynamic installing/1.
:- dynamic installed/1.

% Runs the program when loaded
:- run.
