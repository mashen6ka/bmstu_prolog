class Var:
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return f'VAR {self.name}'


class Assign:
    def __init__(self, name, value):
        self.name = name
        self.value = value

    def __str__(self):
        return f'{self.name} = {self.value}'


class Input:
    def __init__(self, name):
        self.name = name

    def __str__(self):
        return f'INPUT {self.name}'


class If:
    def __init__(self, name, operator, value, children):
        self.name = name
        self.value = value
        self.operator_symbol = operator
        self.operator = self._operator_word(operator)
        self.children = children

    def _operator_word(self, operator):
        if operator == "=": return "EQ"
        if operator == "!=": return "NEQ"
        if operator == ">": return "GT"
        if operator == "<": return "LT"
        return ""

    def __str__(self):
        return f'IF {self.name} {self.operator_symbol} {self.value}'


class Print:
    def __init__(self, value):
        self.value = value

    def __str__(self):
        return f'PRINT "{self.value}"'


def format_code(node, code_offset, code):
    TAB = '    '
    return '({:3})|\t{:}{:}'.format(node, TAB * code_offset, str(code))


def generate(program, offset = 0, code_offset = 0):
    vertices = []
    statements = []
    code = []

    i = offset + 1
    for statement in program:
        if isinstance(statement, Assign):
            vertices.append(f'node({i}, [{i+1}]).')
            statements.append(f'statement({i}, "{statement.name}", "ASSIGN", {statement.value}).')
            code.append(format_code(i, code_offset, statement))
            i += 1
        elif isinstance(statement, Input):
            vertices.append(f'node({i}, [{i+1}]).')
            statements.append(f'statement({i}, "{statement.name}", "INPUT", 0).')
            code.append(format_code(i, code_offset, statement))
            i += 1
        elif isinstance(statement, Print):
            vertices.append(f'node({i}, [{i+1}]).')
            statements.append(f'statement({i}, "", "", 0).')
            code.append(format_code(i, code_offset, statement))
            i += 1
        elif isinstance(statement, If):
            v, s, c = generate(statement.children, i, code_offset + 1)
            
            vertices.append(f'node({i}, [{i+1}, {i+2+len(v)}]).')
            statements.append(f'statement({i}, "{statement.name}", "{statement.operator}", {statement.value}).')
            code.append(format_code(i, code_offset, statement))
            
            vertices.extend(v)
            statements.extend(s)
            code.extend(c)
            i += len(v) + 1
            
            vertices.append(f'node({i}, [{i+1}]).')
            statements.append(f'statement({i}, "", "ENDIF", "").')
            code.append(format_code(i, code_offset, 'ENDIF'))
            i += 1
        
    if offset == 0:
        vertices.append(f'node({i}, []).')
        statements.append(f'statement({i}, "", "", 0).')

    return vertices, statements, code


program = [
    Input("x"),
    If("x", ">", "0", [
        If("x", "<", 0, [

        ]),
        If("x", ">", -1, [
            
        ])
    ])
]


vertices, statements, code = generate(program)
with open("input.pl", "w") as input_file:
    input_file.write('\n'.join(vertices))
    input_file.write('\n')
    input_file.write('\n'.join(statements))
print('\n'.join(code))
