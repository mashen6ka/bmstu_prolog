node(1, [2]).
node(2, [3]).
node(3, [4, 15]).
node(4, [5, 14]).
node(5, [6, 13]).
node(6, [7, 12]).
node(7, [8, 11]).
node(8, [9, 10]).
node(9, [10]).
node(10, [11]).
node(11, [12]).
node(12, [13]).
node(13, [14]).
node(14, [15]).
node(15, []).
statement(1, "x", "INPUT", 0).
statement(2, "y", "INPUT", 0).
statement(3, "x", "GT", 2).
statement(4, "x", "LT", 6).
statement(5, "y", "GT", 3).
statement(6, "y", "LT", 10).
statement(7, "x", "NEQV", "y").
statement(8, "x", "EQV", "y").
statement(9, "", "ENDIF", "").
statement(10, "", "ENDIF", "").
statement(11, "", "ENDIF", "").
statement(12, "", "ENDIF", "").
statement(13, "", "ENDIF", "").
statement(14, "", "ENDIF", "").
statement(15, "", "", 0).