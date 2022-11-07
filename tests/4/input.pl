node(1, [2]).
node(2, [3]).
node(3, [4, 8]).
node(4, [5, 7]).
node(5, [6]).
node(6, [7]).
node(7, [8]).
node(8, []).
statement(1, "x", "ASSIGN", 5).
statement(2, "y", "ASSIGN", 10).
statement(3, "x", "EQ", 5).
statement(4, "y", "NEQ", 10).
statement(5, "", "", 0).
statement(6, "", "ENDIF", "").
statement(7, "", "ENDIF", "").
statement(8, "", "", 0).