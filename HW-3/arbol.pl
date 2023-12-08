% Hechos
arco('C', 'A').
arco('C', 'C').

% Define el predicado hermano
hermano(A, B) :- arco(C, A), arco(C, B).
