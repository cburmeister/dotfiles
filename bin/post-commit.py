#!/usr/bin/env python

import os
import datetime

my_dir = os.path.expanduser('~/Dropbox/commit-captures')
if not os.path.exists(my_dir):
    os.makedirs(my_dir)

filename = '%s/%s.jpeg' % (my_dir, datetime.datetime.now())
filename = filename.replace(' ', '_')

os.system('imagesnap -q %s &' % filename)
