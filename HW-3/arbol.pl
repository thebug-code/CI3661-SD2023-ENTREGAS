% Hechos
arco('a', 'b').
arco('b', 'c').

% Define el predicado hermano
hermano(A, B) :- arco(C, A), arco(C, B).

% Define el predicado alcanzable
alcanzable(A, A).
alcanzable(A, B) :- arco(A, B).
alcanzable(A, B) :- arco(A, C), alcanzable(C, B).
