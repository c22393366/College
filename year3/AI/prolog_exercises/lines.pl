point(1,2).
point(3,2).
point(3,3).

segment(point(1,2), point(3,2)).
segment(point(1,2), point(3,3)).

hor(S):- S = segment(P1, P2), P1 = point(X, Y), P2 = point(Z, Y).
vert(S):- S = segment(P1, P2), P1 = point(X, Y), P2 = point(X, Z).