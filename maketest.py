#!/usr/bin/env python3

import glob
import subprocess
import os
import shutil

tests = glob.glob('./tests/*')

next_test = sorted(list(map(lambda x: int(x[8:]), tests)))[-1] + 1
next_dir = './tests/' + str(next_test)

os.mkdir(next_dir)
shutil.copy2('./input.pl', next_dir + '/input.pl')

command = ['python3', 'generate.py']
process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = process.communicate()

with open(next_dir + '/code.txt', 'w') as code:
  code.write(stdout.decode('ascii'))

command = ['swipl', '-g', 'consult(main), consult(input), traverse(1)', '-g', 'halt']
process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = process.communicate()

with open(next_dir + '/output.txt', 'w') as output:
  output.write(stdout.decode('ascii'))
