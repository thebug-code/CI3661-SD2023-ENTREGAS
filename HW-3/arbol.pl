% Hechos que representan los arcos del grafo
% arco(X, Y) significa que existe un arco desde X hasta Y
arco(a, b).
arco(b, c).
arco(c, d).

% a.

% A es hermano de B si existe un C tal que C es arco de A y B
hermano(A, B) :- arco(C, A), arco(C, B), A \= B.

% b.

% B es alcanzable desde A si existe un arco de A a B, o si existe un C
% tal que existe un arco de A a C y B es alcanzable desde C
alcanzable(A, B) :- arco(A, B), \+ alcanzable(A, B).
alcanzable(A, B) :- arco(A, C), alcanzable(C, B), \+ alcanzable(A, B).

% c.

% C alcanza tanto a A como a B; y no existe ningun C' alcanzable desde
% C, que a su vez alcance a A y B
lca(A, B, C) :-
    alcanzable(C, A),
    alcanzable(C, B),
    not((alcanzable(C, C1), alcanzable(C1, A), alcanzable(C1, B))).

% d.

% Indica si el grafo es un arbol
tree(A) :- 
    not(ciclo(A)),         % No hay ciclos
    not(alcanzable(_, A)), % No hay algun nodo que alcance a A
    arborescence(A).       % Es una arborescencia

% Indica si el grafo tiene un ciclo
ciclo(X) :- ciclo(X, []).

ciclo(Curr, Visited) :-
    member(Curr, Visited),
    !. 

ciclo(Curr, Visited) :-
    arco(Curr, Next),
    ciclo(Next, [Curr|Visited]) .

% Indica si el grafo es una arborescencia
arborescence(A) :-
    findall(B, arco(A, B), Hijos),
    forall(member(H, Hijos), arborescence(H)).



% https://stackoverflow.com/questions/6721139/cycle-detection-in-a-graph
