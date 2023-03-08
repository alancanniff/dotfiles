#!/usr/bin/env python3

import argparse
import shlex
from subprocess import run, PIPE, CalledProcessError


def capture(cmd):
    cmd = shlex.split(cmd)

    try:
        cp = run(cmd, check=True, stderr=PIPE, stdout=PIPE)
    except CalledProcessError:
        return ""

    return cp.stdout.strip().decode()


def toolbox():
    cmd = 'grep -oP "(?<=name=\\").*[^\\"]" /run/.containerenv'
    return capture(cmd)


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='Remotely power cycle a host through its management interface')  # noqa
    group = parser.add_mutually_exclusive_group()
    group.add_argument('--toolbox', action='store_true')

    args = parser.parse_args()

    if args.toolbox:
        print(toolbox(), end='')
