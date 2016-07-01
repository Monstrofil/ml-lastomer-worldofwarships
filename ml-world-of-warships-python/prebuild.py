# -*- coding: cp1251 -*-
import py_compile
import fnmatch
import os

EXT = '.ml'

for root, dirnames, filenames in os.walk('tempdirectory'):
    for filename in fnmatch.filter(filenames, '*.py'):
        print os.path.join(root, filename)
        py_compile.compile(os.path.join(root, filename))
        os.remove(os.path.join(root, filename))

        if 'ml_entry' in filename:
            continue
        os.rename(os.path.join(root, filename + 'c'), os.path.join(root, filename[:-2] + 'ml'))