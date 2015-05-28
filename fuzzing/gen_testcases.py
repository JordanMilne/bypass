#!/bin/env python

# dump all of our testcases into a directory as separate files, like AFL
# wants.

import os.path
import sys
import itertools

sys.path.append("../dep/snudown")
import test_snudown

cases = itertools.chain(test_snudown.cases.keys(), test_snudown.wiki_cases.keys())
for i, md in enumerate(cases):
    test_path = os.path.join('testing', 'testcases', 'test_default_%d.md' % i)
    # only reasonably sized tests
    if len(md) < 1024:
        with open(test_path, 'w') as f:
            f.write(md)
