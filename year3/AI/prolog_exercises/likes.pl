man(jim).
man(mary).
mortal(X) :- man(X).
likes(X, A) :- man(X), dog(A).

dog(rex).
dog(lassie).

cat(snoops).

hates(X, Y):- dog(X), cat(Y).
chases(Y, X):- hates(X, Y).