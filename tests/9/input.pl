node(1, [2]).
node(2, [3, 4]).
node(3, [4]).
node(4, [5, 6]).
node(5, [6]).
node(6, [7, 8]).
node(7, [8]).
node(8, [9, 10]).
node(9, [10]).
node(10, [11, 12]).
node(11, [12]).
node(12, [13, 14]).
node(13, [14]).
node(14, []).
statement(1, "x", "ASSIGN", 0).
statement(2, "x", "GEQV", "x").
statement(3, "", "ENDIF", "").
statement(4, "x", "LEQV", "x").
statement(5, "", "ENDIF", "").
statement(6, "x", "EQV", "x").
statement(7, "", "ENDIF", "").
statement(8, "x", "NEQV", "x").
statement(9, "", "ENDIF", "").
statement(10, "x", "GTV", "x").
statement(11, "", "ENDIF", "").
statement(12, "x", "LTV", "x").
statement(13, "", "ENDIF", "").
statement(14, "", "", 0).