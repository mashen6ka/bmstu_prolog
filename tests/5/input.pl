node(1, [2]).
node(2, [3]).
node(3, [4, 6]).
node(4, [5]).
node(5, [6]).
node(6, [7, 10]).
node(7, [8, 9]).
node(8, [9]).
node(9, [10]).
node(10, [11, 12]).
node(11, [12]).
node(12, []).
statement(1, "x", "INPUT", 0).
statement(2, "n", "ASSIGN", 0).
statement(3, "x", "GT", 1).
statement(4, "n", "ASSIGN", 1).
statement(5, "", "ENDIF", "").
statement(6, "n", "NEQ", 1).
statement(7, "n", "GT", 0).
statement(8, "", "ENDIF", "").
statement(9, "", "ENDIF", "").
statement(10, "n", "GT", 0).
statement(11, "", "ENDIF", "").
statement(12, "", "", 0).