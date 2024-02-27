:- [hw5_q2].




fill_list(0, []).
fill_list(N, [N|Rest]) :-
    N > 0,
    N1 is N - 1,
    fill_list(N1, Rest).

graph_vertices(graph(Edges), Res):-
    length(Edges, L),
    fill_list(L, Res).

graph_edges(graph(Edges), Result) :-
    findall([X, Y], (nth1(X, Edges, Neighbors), member(Y, Neighbors)), Result).



delete_node_edges([], _ , []).
delete_node_edges([[X, _] | Rest], Vertex, Result) :-
    X =:= Vertex,
    delete_node_edges(Rest, Vertex, Result).
delete_node_edges([[X, Y] | Rest], Vertex, [[X, Y] | Result]) :-
    X =\= Vertex,
    delete_node_edges(Rest, Vertex, Result).

del(X, [X|Xs], Xs).
del(X, [Y|Ys], [Y|Zs]) :- del(X, Ys, Zs).



node_witout_parents(Vertices, Edges, Node, Visited):-
    member(Node, Vertices),
    \+ member( [ _ | [Node] ], Edges),
    \+ member(Node, Visited).


topological_sort(graph([]), []).
topological_sort(graph(Graph), R):-
	dag(graph(Graph)),
    graph_edges(graph(Graph), E),
    graph_vertices(graph(Graph), V),
    topological_sort_aux(E, V, R, []) .

topological_sort_aux([], [] , [], _):- !.
topological_sort_aux([], V , Res, _):-
    permutation(Res, V).
    
topological_sort_aux(E, V, [ Node | Sorted], Visited):-
    length(E, N), 
    N > 0,
    node_witout_parents(V, E, Node, Visited),
    delete_node_edges(E, Node, NewE),
    del(Node, V, NewV),
    topological_sort_aux(NewE, NewV, Sorted, [Node | Visited]).













node_reachables(graph(Graph), Node, R):-
    Node2 is 1,
    node_reachables(graph(Graph), Node, Node2, R), !.
    

node_reachables(graph(Graph), _ , Node2, []):-
    length(Graph, N),
    N < Node2, !.

node_reachables(graph(Graph), Node, Node2, Reachables):-
    length(Graph, N),
    N >= Node2,
    \+ path(graph(Graph), Node, Node2, _),
    Node3 is Node2 + 1,
    node_reachables(graph(Graph), Node, Node3, Reachables), !.

node_reachables(graph(Graph), Node, Node2, [Node2|Reachables]):-
    length(Graph, N),
    N >= Node2,
    path(graph(Graph), Node, Node2, _),
    Node3 is Node2 + 1,
    node_reachables(graph(Graph), Node, Node3, Reachables), !.
    

all_nodes_reachables(graph(Graph), R):-
    length(Graph, N),
    Node is 1,
    all_nodes_reachables(graph(Graph), Node, N, R ), !.
    

all_nodes_reachables(_, Node, MaxN, [] ):-
    Node > MaxN, !.
    
all_nodes_reachables(graph(Graph), Node, MaxN, [NodeR |R]):-
    MaxN >= Node,
    node_reachables(graph(Graph), Node, NodeR),
    Next is Node + 1,
    all_nodes_reachables(graph(Graph), Next , MaxN, R), !.



delete_node_reachables(Reachables, Node, NewReachables):-
    Index is Node-1,
    length(Left, Index),
    append(Left, [[-1]], NLeft), 
    append(Left, [_|Right], Reachables),
    append(NLeft, Right, NewReachables).
    


delete_at(Node, List, Result) :-
    Index is Node -1,
    length(Left, Index),
    append(Left, [_|Right], List),
    append(Left, Right, Result).



find_node_component(Node, _ , [], [Node]).


find_node_component(Node, Reachables, NodeReachables, NodeComp):-
    nth1(1, NodeReachables, CheckNode),
    nth1(CheckNode, Reachables, CheckComp),
    \+ member(Node, CheckComp),
    delete_at(1, NodeReachables, NewNodeReacahbles),
    find_node_component(Node, Reachables, NewNodeReacahbles, NodeComp).

find_node_component(Node, Reachables, NodeReachables, [CheckNode | NodeComp]):-
    nth1(1, NodeReachables, CheckNode),
    nth1(CheckNode, Reachables, CheckComp),
    member(Node, CheckComp),
    delete_node_reachables(Reachables, CheckNode, NewReachables),
    delete_at(1, NodeReachables, NewNodeReacahbles),
    find_node_component(Node, NewReachables, NewNodeReacahbles, NodeComp).



find_sorted_components(Graph,Reachables, Comps):-
    length(Graph, MaxN),
    Node is 1,
    find_sorted_components(Reachables, Comps, Node, MaxN).
    

find_sorted_components(_, [], Node, MaxN):-
    Node > MaxN.
    
    
find_sorted_components(Reachables, [SortedNodeComp|Comps], Node, MaxN):-
    MaxN >= Node,
    nth1(Node, Reachables, NodeReachables),
    find_node_component(Node, Reachables, NodeReachables, NodeComp),
    sort(NodeComp, SortedNodeComp),
    Node2 is Node + 1,
    find_sorted_components(Reachables, Comps, Node2, MaxN).


find_components(Graph,Reachables, Comps):-
    find_sorted_components(Graph,Reachables, SortedComps),
    list_to_set(SortedComps, Comps).


correct_comp(graph(_), Comp):-
    length(Comp, 1), !.

correct_comp(graph(Graph), Comp):-
    member(Node1, Comp),
    member(Node2, Comp),
    Node1 =\= Node2,
    path(graph(Graph), Node1, Node2, _).
    



all_correct_comp(graph(_), []):- !.
all_correct_comp(graph(Graph), [Comp|Rs]):-
	correct_comp(graph(Graph), Comp),
    all_correct_comp(graph(Graph), Rs).

scc(graph(Graph), S):-
    all_nodes_reachables(graph(Graph), Reachables),
    find_components(Graph,Reachables, S).

scc(graph(Graph), S):-
	\+ var(S),
    all_correct_comp(graph(Graph), S), !.