#!/usr/bin/env python

import sys
import os
import atexit

# color prompt
# sys.ps1 = '\001\033[1;36m\002>>> \001\033[0m\002'

# tab completion
try:
    import readline
except ImportError:
    # Silently ignore missing readline module
    pass
else:
    import rlcompleter
    readline.parse_and_bind('tab: complete')

# history
histfile = os.path.join(os.environ['HOME'], '.python_history')
try:
    readline.read_history_file(histfile)
except IOError:
    pass

atexit.register(readline.write_history_file, histfile)
del os, histfile
