node(1, [2]).
node(2, [3]).
node(3, [4]).
node(4, [5, 6]).
node(5, [6]).
node(6, [7, 18]).
node(7, [8]).
node(8, [9]).
node(9, [10, 13]).
node(10, [11]).
node(11, [12]).
node(12, [13]).
node(13, [14, 17]).
node(14, [15]).
node(15, [16]).
node(16, [17]).
node(17, [18]).
node(18, [19, 20]).
node(19, [20]).
node(20, [21, 22]).
node(21, [22]).
node(22, []).
statement(1, "x", "INPUT", 0).
statement(2, "w", "ASSIGN", -1).
statement(3, "y", "ASSIGN", -1).
statement(4, "w", "EQV", "y").
statement(5, "", "ENDIF", "").
statement(6, "x", "GT", 0).
statement(7, "y", "ASSIGN", 0).
statement(8, "w", "ASSIGN", 0).
statement(9, "x", "GT", 1).
statement(10, "y", "ASSIGN", 1).
statement(11, "w", "ASSIGN", 1).
statement(12, "", "ENDIF", "").
statement(13, "x", "GT", 2).
statement(14, "y", "ASSIGN", 2).
statement(15, "w", "ASSIGN", 2).
statement(16, "", "ENDIF", "").
statement(17, "", "ENDIF", "").
statement(18, "w", "EQV", "y").
statement(19, "", "ENDIF", "").
statement(20, "w", "NEQV", "y").
statement(21, "", "ENDIF", "").
statement(22, "", "", 0).