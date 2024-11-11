woman(mia).
woman(jody).
woman(yolanda).
man(ruben).
loves(mia, ruben).
loves(yolanda, ruben).

jealous(X, Y) :- loves(X, Z), loves(Y, Z), X \= Y, man(Z).


playAirGuitar(jody).
party.

happy(yolanda).
listens2music(mia).
listens2music(yolanda) :- happy(yolanda).
playsAirGuitar(yolanda) :- listens2music(yolanda).


