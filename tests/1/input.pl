node(1, [2]).
node(2, [3]).
node(3, [4]).
node(4, [5, 15]).
node(5, [6, 14]).
node(6, [7, 13]).
node(7, [8, 12]).
node(8, [9, 11]).
node(9, [10]).
node(10, [11]).
node(11, [12]).
node(12, [13]).
node(13, [14]).
node(14, [15]).
node(15, [16, 17]).
node(16, [17]).
node(17, []).
statement(1, "x", "INPUT", 0).
statement(2, "y", "INPUT", 0).
statement(3, "n", "ASSIGN", 1).
statement(4, "x", "GT", 10).
statement(5, "x", "LT", 15).
statement(6, "y", "GT", 2).
statement(7, "y", "LT", 4).
statement(8, "x", "GTV", "y").
statement(9, "n", "ASSIGN", 3).
statement(10, "", "ENDIF", "").
statement(11, "", "ENDIF", "").
statement(12, "", "ENDIF", "").
statement(13, "", "ENDIF", "").
statement(14, "", "ENDIF", "").
statement(15, "n", "EQ", 3).
statement(16, "", "ENDIF", "").
statement(17, "", "", 0).