import glob
import subprocess

inputs = glob.glob('./tests/*.pl')

for input_path in inputs:
    path = input_path[2:len(input_path)-3]
    command = ['swipl', '-g', f'consult(main), consult({path}), traverse(1)', '-g', 'halt']
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    
    with open(input_path + '.output') as expected:
        expected_data = expected.read()
        if stdout.decode('ascii') != expected_data:
            print('===', input_path, 'FAIL')
            print('EXPECTED:')
            print(expected_data)
            print('OUTPUT:')
            print(stdout.decode('ascii'))
        else:
            print('===', input_path, 'OK')
