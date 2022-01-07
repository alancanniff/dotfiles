#!/usr/bin/env bash
set -e

find . \( -not -regex .*.build/.* \) -and \( -type f -name *.sv -or -type f -name *.v \) |
xargs verible-verilog-format --flagfile verible-format.flags

# xargs verible-verilog-format \
#     --indentation_spaces=4 \
#     --inplace
