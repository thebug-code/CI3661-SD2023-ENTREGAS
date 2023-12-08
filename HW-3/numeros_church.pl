% Define la funcion up/2
up(X, up(Y)) :- up(X, Y).

% Caso base
up(_, *).

% a.

% Define el predicado sum/3
sum(*, Y, Y).
sum(up(X), Y, up(Z)) :- sum(X, Y, Z).

% b.

% Define el predicado resta/3
resta(X, *, X).
resta(up(X), up(Y), Z) :- resta(X, Y, Z).

% c.

% Define el predicado mult/3
mult(*, _, *).
mult(up(X), Y, Z) :- mult(X, Y, W), sum(W, Y, Z).
