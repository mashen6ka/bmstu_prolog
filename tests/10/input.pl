node(1, [2]).
node(2, [3]).
node(3, [4, 7]).
node(4, [5, 6]).
node(5, [6]).
node(6, [7]).
node(7, []).
statement(1, "x", "ASSIGN", 0).
statement(2, "y", "ASSIGN", 1).
statement(3, "x", "NEQV", "y").
statement(4, "x", "EQV", "y").
statement(5, "", "ENDIF", "").
statement(6, "", "ENDIF", "").
statement(7, "", "", 0).