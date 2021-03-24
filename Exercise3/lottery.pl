read_input(File, K, N, Q, Lot_tickets, Lucky_numbers) :-
	open(File, read, Stream),
	read_line(Stream, [K, N, Q]),
	read_lines(Stream, N, Lot_tickets),
	read_lines(Stream, Q, Lucky_numbers).
	
read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).

read_lines(Stream, N, L) :-
    ( N = 0 -> L = []
    ; read_string(Stream, S),
      N1 is N-1,
      read_lines(Stream, N1, L1),
      L = [S|L1] ).
      
read_string(Stream, L) :-
	read_line_to_codes(Stream, Line),
	atom_string(Line, L).
	
insert_from_list_to_map(List, K, Assoc) :-
	empty_assoc(Assoc0),
	insert_from_list_to_map(List, K, K, Assoc0, Assoc).

insert_from_list_to_map([], K, K, Assoc, Assoc) :- !.
insert_from_list_to_map([H|T], K, Ktemp, Assoc0, Assoc) :-
	Ktemp1 is Ktemp-1,
	Length is K-Ktemp+1,
	sub_string(H, Ktemp1, Length, 0, Substring),
	( get_assoc(Substring, Assoc0, Value) -> Value1 is Value+1
	; Value1 is 1), 
	put_assoc(Substring, Assoc0, Value1, Assoc1),
	( Ktemp1=0 -> Ktemp2 is K, insert_from_list_to_map(T, K, Ktemp2, Assoc1, Assoc)
	; insert_from_list_to_map([H|T], K, Ktemp1, Assoc1, Assoc)).	

number_of_winners(Assoc, String, K, Ktemp, Winners) :-
	Ktemp1 is Ktemp-1,
	Length is K-Ktemp1,
	sub_string(String, Ktemp1, Length, 0, Substring),
	( get_assoc(Substring, Assoc, Value) -> Winners is Value
	; Winners is 0).
	
find_winning_sum(Assoc, String, K, Sum) :-
	find_winning_sum(Assoc, String, K, K, 0, Sum).

find_winning_sum(Assoc, String, K, 0, Sum, Sum) :- !.
find_winning_sum(Assoc, String, K, Ktemp, PreviousSum, Sum) :-
	number_of_winners(Assoc, String, K, Ktemp, CurrentWinners),
	CurrentSum is (CurrentWinners*(2^(K-Ktemp+1) - 1) - CurrentWinners*(2^(K-Ktemp) - 1)),
	TotalSum is ((CurrentSum+PreviousSum) mod ((10^9) + 7)),
	Ktemp1 is Ktemp-1,
	( CurrentWinners=0 -> find_winning_sum(Assoc, String, K, 0, TotalSum, Sum)
	; find_winning_sum(Assoc, String, K, Ktemp1, TotalSum, Sum)).	

aux_lottery(Assoc, LuckyList, K, ListofLists) :-
	aux_lottery(Assoc, LuckyList, K, [], ListofLists).
	
aux_lottery(Assoc, [], K, ListofLists, ListofLists) :- !.
aux_lottery(Assoc, [H|T], K, PreviousList, ListofLists) :-	
	number_of_winners(Assoc, H, K, K, Winners),
	find_winning_sum(Assoc, H, K, Sum),
	append(PreviousList, [[Winners, Sum]], CurrentList),
	aux_lottery(Assoc, T, K, CurrentList, ListofLists).
					
lottery(File, L) :-
	read_input(File, K, N, Q, Lot, Luck),
	insert_from_list_to_map(Lot, K, Assoc),
	aux_lottery(Assoc, Luck, K, L).
