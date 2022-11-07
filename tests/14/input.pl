node(1, [2]).
node(2, [3]).
node(3, [4, 5]).
node(4, [5]).
node(5, []).
statement(1, "x", "INPUT", 0).
statement(2, "y", "INPUT", 0).
statement(3, "x", "NEQV", "x").
statement(4, "", "ENDIF", "").
statement(5, "", "", 0).