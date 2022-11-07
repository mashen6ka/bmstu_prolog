#!/usr/bin/env python3

import glob
import subprocess

inputs = glob.glob('./tests/*')

for base_path in inputs:
    input_path = base_path[2:] + '/input'
    command = ['swipl', '-g', f'consult(main), consult({input_path}), traverse(1)', '-g', 'halt']
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    
    with open(base_path + '/output.txt') as expected:
        expected_data = expected.read()
        if stdout.decode('ascii') != expected_data:
            print('===', input_path, 'FAIL')
            print('EXPECTED:')
            print(expected_data)
            print('OUTPUT:')
            print(stdout.decode('ascii'))
        else:
            print('===', input_path, 'OK')
