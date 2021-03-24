read_input(File, K, C) :-
    open(File, read, Stream),
    read_line(Stream, [_, K]),
    read_line(Stream, C).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).
        
shortest_length(List, K, ShortestLength, List_1_to_k) :-
    shortest_sublist(List, K, Sublist, List_1_to_k),
    length(Sublist, ShortestLength).

shortest_sublist(List, K, Sublist, List_1_to_k) :-
    take_sublist(List, HeadList, TailList, List_1_to_k),         % find minimum headlist with all K items
    reduce_sublist(HeadList, [First|Rest]),                % reduce that headlist to get a sublist
    length([First|Rest], Length1),
    (   Length1 = K                                 % there is no shorter sublist(because the one we found is exactly K)
    ->  Sublist = [First|Rest]
    ;   append(Rest, TailList, NewList),
        (   shortest_sublist(NewList, K, NewSublist, List_1_to_k) % find a new sublist in the rest of the list
        ->  (   length(NewSublist, Length2),
                (   Length1 < Length2
                ->  Sublist = [First|Rest])          % new sublist is not shorter than the previous
                ;   Sublist = NewSublist )           % new sublist is shorter than the previous
        ;   Sublist = [First|Rest]  ) ).  
        
take_sublist(List, HeadList, TailList, List_1_to_k) :-
    append(HeadList, TailList, List),
    subset(List_1_to_k, HeadList).
    
reduce_sublist([First|Rest], ReducedList) :-
    (   memberchk(First, Rest)
    ->  reduce_sublist(Rest, ReducedList)
    ;   ReducedList = [First|Rest] ).
    
colors1(File, Answer) :- 
    read_input(File, K, C), 
    numlist(1, K, List_1_to_k),
    (  subset(List_1_to_k, C) 
    -> shortest_length(C, K, Answer, List_1_to_k)
    ;  Answer is 0).

colors(File, Answer) :- once(colors1(File, Answer)).
