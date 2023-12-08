% Hechos que representan los arcos del grafo
% arco(X, Y) significa que existe un arco desde X hasta Y
%arco('c', 'a').
%arco('c', 'b').
%arco('c1', 'b').
%arco('c1', 'a').
%arco('c', 'c1').

% a.

% A es hermano de B si existe un C tal que C es arco de A y B
hermano(A, B) :- arco(C, A), arco(C, B), A \= B.

% b.

% B es alcanzable desde A si existe un arco de A a B, o si existe un C
% tal que existe un arco de A a C y B es alcanzable desde C
alcanzable(A, B) :- arco(A, B).
alcanzable(A, B) :- arco(A, C), alcanzable(C, B).

% c.

% C alcanza tanto a A como a B; y no existe ningun C' alcanzable desde
% C, que a su vez alcance a A y B
lca(A, B, C) :-
    alcanzable(C, A),
    alcanzable(C, B),
    not((alcanzable(C, C1), alcanzable(C1, A), alcanzable(C1, B))).
