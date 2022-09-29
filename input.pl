node(1, [2]).
node(2, [3]).
node(3, [4]).
node(4, [5, 7]).
node(5, [6]).
node(6, [7]).
node(7, [8, 11]).
node(8, [9, 10]).
node(9, [10]).
node(10, [11]).
node(11, []).
statement(1, "x", "INPUT", 0).
statement(2, "y", "ASSIGN", 20).
statement(3, "n", "INPUT", 0).
statement(4, "n", "GT", 0).
statement(5, "x", "ASSIGN", 10).
statement(6, "", "ENDIF", "").
statement(7, "x", "GTV", "y").
statement(8, "x", "GTV", "y").
statement(9, "", "ENDIF", "").
statement(10, "", "ENDIF", "").
statement(11, "", "", 0).