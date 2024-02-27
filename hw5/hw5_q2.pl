is_not_empty(Graph) :- 
    length(Graph, N),
    N > 0.

max_vertix_index(Graph) :- 
    flatten(Graph, Flattened),
    max_list(Flattened, Max),
    length(Graph, N),
    N >= Max.

min_vertix_index(Graph) :- 
    flatten(Graph, Flattened),
    min_list(Flattened, Min),
    Min >= 1.

all_lists(Graph) :-
    is_list(Graph),
    maplist(is_list, Graph).

not_list_of_lists_of_lists([]).
not_list_of_lists_of_lists([X|Xs]) :-
    is_list(X),
    maplist(number, X),
    not_list_of_lists_of_lists(Xs).


legal_graph(graph(Graph)) :-
    is_not_empty(Graph),
    max_vertix_index(Graph),
    min_vertix_index(Graph),
    all_lists(Graph),
    not_list_of_lists_of_lists(Graph).

edge(graph(Graph), X, N) :-
    legal_graph(graph(Graph)),
    nth1(X, Graph, Xneighbors),
    member(N, Xneighbors).

path(graph(Graph), A, B, P) :-
    legal_graph(graph(Graph)),
    path_aux(Graph, A, B, [], P),
    A \= B.

path_aux(_, Dist, Dist, _, [Dist]).

path_aux(Graph, Cur, Dist, Visited, [Cur | Path]) :-
    nth1(Cur, Graph, CurNeighbors),
    member(Next, CurNeighbors),
    \+ member(Next, Visited),
    path_aux(Graph, Next, Dist, [Cur | Visited], Path).



circle_friendly_path(graph(Graph), A, B, P) :-
    legal_graph(graph(Graph)),
    circle_friendly_path_aux(Graph, A, B, [], P).

circle_friendly_path_aux(_, Dist, Dist, _, [Dist]).

circle_friendly_path_aux(Graph, Cur, Dist, Visited, [Cur | Path]) :-
    nth1(Cur, Graph, CurNeighbors),
    member(Next, CurNeighbors),
    \+ member(Next, Visited),
    circle_friendly_path_aux(Graph, Next, Dist, [Cur | Visited], Path).


% Predicate to find cycles in the graph
circle(graph(Graph), P) :-
    legal_graph(graph(Graph)),
    length(Graph, N),
    between(1, N, Node),
    circle_friendly_path(graph(Graph), Node, Node2, P1),
    edge(graph(Graph),Node2, Node),
    append(P1, [Node], P).

dag(graph(Graph)):-
    legal_graph(graph(Graph)),
    \+ circle(graph(Graph), _ ).
