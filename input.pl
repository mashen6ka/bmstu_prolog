node(1, [2]).
node(2, [3, 8]).
node(3, [4, 5]).
node(4, [5]).
node(5, [6, 7]).
node(6, [7]).
node(7, [8]).
node(8, []).
statement(1, "x", "INPUT", 0).
statement(2, "x", "GT", 0).
statement(3, "x", "LT", 0).
statement(4, "", "ENDIF", "").
statement(5, "x", "GT", -1).
statement(6, "", "ENDIF", "").
statement(7, "", "ENDIF", "").
statement(8, "", "", 0).