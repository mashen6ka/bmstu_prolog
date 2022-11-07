node(1, [2]).
node(2, [3]).
node(3, [4, 5]).
node(4, [5]).
node(5, []).
statement(1, "x", "ASSIGN", 0).
statement(2, "y", "ASSIGN", 1).
statement(3, "x", "GTV", "y").
statement(4, "", "ENDIF", "").
statement(5, "", "", 0).