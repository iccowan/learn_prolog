wasKilled(thomas).
wasAtHome(ian).
wasAtHome(newcomb).
wasPresent(X) :- not(wasAtHome(X)).
isMurderer(X) :- wasPresent(X),
                 not(wasKilled(X)).
