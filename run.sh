#!/usr/bin/env sh

python3 generate.py
swipl -g "consult(main), consult(input), traverse(1)" -g halt
echo
