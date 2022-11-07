node(1, [2]).
node(2, [3]).
node(3, [4, 5]).
node(4, [5]).
node(5, [6, 7]).
node(6, [7]).
node(7, [8, 9]).
node(8, [9]).
node(9, [10, 11]).
node(10, [11]).
node(11, []).
statement(1, "x", "ASSIGN", 0).
statement(2, "y", "ASSIGN", 0).
statement(3, "x", "GEQV", "y").
statement(4, "", "ENDIF", "").
statement(5, "x", "LEQV", "y").
statement(6, "", "ENDIF", "").
statement(7, "y", "GEQV", "x").
statement(8, "", "ENDIF", "").
statement(9, "y", "LEQV", "x").
statement(10, "", "ENDIF", "").
statement(11, "", "", 0).