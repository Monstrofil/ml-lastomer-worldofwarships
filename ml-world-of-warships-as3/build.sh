#!/bin/bash

python prebuild.py
/home/monstrofil/dev/flash/flex/bin/mxmlc -load-config+=WorldofWarshipsHammerConfigUbuntu.xml -omit-trace-statements -debug=false -incremental=true -swf-version=12 -o $WORKSPACE/build/gui/flash/XVMBackground.swf
cp -a configs/. $WORKSPACE/build/