#!/usr/bin/env python

import sys

if len(sys.argv) > 1:
    n = int(sys.argv[1])
else:
    n = 20

print r'''
    /\___/\
   /       \
  |  o    o |
  \     #   |
   \   _|_ /
   /       \______
  / _______ ___   \
  |_____   \   \__/
   |    \__/
   |       |
''',
print '   |       |\n' * n,
print r'''   |       |
   /        \
  /   ____   \
  |  /    \  |
  | |      | |
 /  |      |  \
 \__/      \__/
'''
