#!/bin/bash
${AFL_PATH}/afl-tmin -t 3000 -i ${1} -m 999999999 -o min.md ./build/bypass-validator
