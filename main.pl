% example: some([1,2,3], =(3)).
some(List, Predicate) :- once(some_(List, Predicate)).
some_([H|_], Predicate) :- call(Predicate, H).
some_([_|T], Predicate) :- some_(T, Predicate).

% example: somev([1,2,3], =, 3).
somev(List, Predicate, X) :- once(somev_(List, Predicate, X)).
somev_([H|_], Predicate, X) :- call(Predicate, H, X).
somev_([_|T], Predicate, X) :- somev_(T, Predicate, X).

% example: somel([1,2,3], =, [3]).
somel(LeftList, Predicate, RightList) :- some(RightList, somev(LeftList, Predicate)).

% example: remove([1,2,3], [1], R).
remove(L, [], L) :- !.
remove([X|Tail], [X|Rest], Result) :- !, remove(Tail, Rest, Result).
remove([X|Tail], L, [X|Result]):- remove(Tail, L, Result).


:- dynamic level/1.
level(1).
push_level :-
    level(Current),
    Next is Current + 1,
    retract(level(Current)),
    asserta(level(Next)).
pop_level :-
    level(Current),
    Prev is Current - 1,
    retract(level(Current)),
    asserta(level(Prev)).


% traverse(Level, node(Vertex, Adjacency))
traverse(Vertex) :-
    node(Vertex, List),
    traverse(node(Vertex, List)).

traverse(node(_Vertex, [])) :- write("EOF"), !.
traverse(node(Vertex, [H])) :-
    write("Statement "), write(Vertex), writeln(": OK"),
    router(Vertex),
    node(H, List),
    traverse(node(H, List)).
traverse(node(Vertex, [T, F])) :-
    write("Statement "), write(Vertex), write(": "),
    (router(Vertex)
    	->	writeln("OK"),
        	node(T, TList), traverse(node(T, TList))
   		;	writeln("UNREACHABLE"),
    		node(F, FList), traverse(node(F, FList))
    ).


:- dynamic var/6.
create_var(Level, Name, Left, Right, Possible, Impossible) :-
    asserta(var(Level, Name, Left, Right, Possible, Impossible)).
delete_var(Level, Name) :-
    (retract(var(Level, Name, _Left, _Right, _Possible, _Impossible)) ; true).
delete_vars(Level) :-
    (retractall(var(Level, _Name, _Left, _Right, _Possible, _Impossible)) ; true).

:- dynamic always_true/1.
always_true_on(Level) :- asserta(always_true(Level)).
always_true_off(Level) :- (retract(always_true(Level)) ; true).

copy_vars_to_next_level_except(Level, NewLevel, Except) :-
    forall((var(Level, Name, Left, Right, Possible, Impossible), Name \= Except),
           create_var(NewLevel, Name, Left, Right, Possible, Impossible)).

copy_vars_to_next_level_except2(Level, NewLevel, Except1, Except2) :-
    forall((var(Level, Name, Left, Right, Possible, Impossible), Name \= Except1, Name \= Except2),
           create_var(NewLevel, Name, Left, Right, Possible, Impossible)).

copy_vars_to_prev_level(Level, PrevLevel) :-
    forall(var(Level, Name, Left, Right, Possible, Impossible),
           (delete_var(PrevLevel, Name),
            create_var(PrevLevel, Name, Left, Right, Possible, Impossible))).

copy_possibles_to_prev_level(Level, PrevLevel) :-
    forall((var(Level, Name, Left, Right, Possible, _Impossible),
            var(PrevLevel, Name, PrevLeft, PrevRight, PrevPossible, PrevImpossible)),
           ((Left = Right
			->	append(PrevPossible, Possible, SubUpdatedPossible),
            	append(SubUpdatedPossible, [Left], UpdatedPossible)
			;   append(PrevPossible, Possible, UpdatedPossible)),
           delete_var(PrevLevel, Name),
           create_var(PrevLevel, Name, PrevLeft, PrevRight, UpdatedPossible, PrevImpossible))).


router(Vertex) :-
    statement(Vertex, Variable, Operation, Value),
    Operation = "ASSIGN",
    level(Level),
    delete_var(Level, Variable),
    create_var(Level, Variable, Value, Value, [], []).

router(Vertex) :-
    statement(Vertex, Variable, Operation, _Value),
    Operation = "INPUT",
    level(Level),
    delete_var(Level, Variable),
    create_var(Level, Variable, -inf, inf, [], []).

router(Vertex) :-
    statement(Vertex, Name, Operation, Value),
    Operation = "EQ",
    level(Level), var(Level, Name, Left, Right, Possible, Impossible),
    not(member(Value, Impossible)),
    (Left = Value, Right = Value
    	->	push_level, level(NextLevel),
    		always_true_on(NextLevel), write("[ALWAYS TRUE] ")
    	;	(Left =< Value, Value =< Right; member(Value, Possible)),
    		push_level, level(NextLevel)
    ),
    copy_vars_to_next_level_except(Level, NextLevel, Name),
    create_var(NextLevel, Name, Value, Value, [], []).

router(Vertex) :-
    statement(Vertex, Name, Operation, Value), 
    Operation = "NEQ",
    level(Level), var(Level, Name, Left, Right, Possible, Impossible),
    (
    	(((Value < Left; Value > Right), not(member(Value, Possible))) ;
         ((Left = Right, Value \= Left), not(member(Value, Possible))) ;
    	 member(Value, Impossible))
    	->  push_level, level(NextLevel),
    		always_true_on(NextLevel), write("[ALWAYS TRUE] ")
    	;   ((Left \= Right, Left =< Value, Value =< Right) ; member(Value, Possible)),
    		push_level, level(NextLevel)
    ),
    copy_vars_to_next_level_except(Level, NextLevel, Name),
    append(Impossible, [Value], UpdatedImpossible),
    create_var(NextLevel, Name, Left, Right, Possible, UpdatedImpossible).

router(Vertex) :-
    statement(Vertex, Name, Operation, Value),
    Operation = "GT",
    level(Level), var(Level, Name, Left, Right, Possible, Impossible),
    (Left > Value
    	->	push_level, level(NextLevel),
    		always_true_on(NextLevel), write("[ALWAYS TRUE] ")
    	;	(Right > Value ; remove(Possible, Impossible, FilteredPossible), somev(FilteredPossible, >, Value)),
    		push_level, level(NextLevel)
    ),
    copy_vars_to_next_level_except(Level, NextLevel, Name),
    (Left = Right -> NewLeft is Left ; NewLeft is Value + 1),
    create_var(NextLevel, Name, NewLeft, Right, Possible, Impossible).

router(Vertex) :-
    statement(Vertex, LName, Operation, RName),
    Operation = "GTV",
    level(Level), 
    var(Level, LName, LLeft, LRight, LPossible, LImpossible),
    write(var(Level, LName, LLeft, LRight, LPossible, LImpossible)),
    var(Level, RName, RLeft, RRight, RPossible, RImpossible),
    write(var(Level, RName, RLeft, RRight, RPossible, RImpossible)),
    remove(LPossible, LImpossible, LFilteredPossible),
    remove(RPossible, RImpossible, RFilteredPossible),
    (LLeft > RRight
        ->  push_level, level(NextLevel),
            always_true_on(NextLevel), write("[ALWAYS TRUE] ")
        ;   (LRight >= RLeft ; somev(LFilteredPossible, >, RFilteredPossible)),
            push_level, level(NextLevel)
    ),
    copy_vars_to_next_level_except2(Level, NextLevel, LName, RName),
    (RLeft \= -inf -> LNewLeft  is max(LLeft, RLeft + 1)   ; LNewLeft  is LLeft),
    (LRight \= inf -> RNewRight is min(LRight - 1, RRight) ; RNewRight is RRight),
    include(<(LNewLeft), LPossible, LNewPossible),
    include(>(RNewRight), RPossible, RNewPossible),
    create_var(NextLevel, LName, LNewLeft, LRight, LNewPossible, LImpossible),
    create_var(NextLevel, RName, RLeft, RNewRight, RNewPossible, RImpossible).

router(Vertex) :-
    statement(Vertex, Name, Operation, Value),
    Operation = "LT",
    level(Level), var(Level, Name, Left, Right, Possible, Impossible),
    (Right < Value
    	->	push_level, level(NextLevel),
    		always_true_on(NextLevel), write("[ALWAYS TRUE] ")
    	;	(Left < Value ; remove(Possible, Impossible, FilteredPossible), somev(FilteredPossible, <, Value)),
    		push_level, level(NextLevel)
    ),
    copy_vars_to_next_level_except(Level, NextLevel, Name),
    (Left = Right -> NewRight is Right ; NewRight is Value - 1),
    create_var(NextLevel, Name, Left, NewRight, Possible, Impossible).

router(Vertex) :-
    statement(Vertex, _Name, Operation, _Value),
    Operation = "ENDIF",
    level(Level), pop_level, level(PrevLevel),
    (always_true(Level)
    	->	(PrevLevel \= 0 -> copy_vars_to_prev_level(Level, PrevLevel); true)
    	;	(PrevLevel \= 0 -> copy_possibles_to_prev_level(Level, PrevLevel); true)
    ),
    always_true_off(Level),
    delete_vars(Level).

router(Vertex) :-
    statement(Vertex, _Name, Operation, _Value),
    Operation = "", !.
