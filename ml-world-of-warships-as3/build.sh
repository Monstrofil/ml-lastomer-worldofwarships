#!/bin/bash
python prebuild.py
/home/monstrofil/dev/flash/flex/bin/mxmlc -load-config+=WorldofWarshipsHammerConfigUbuntu.xml -debug=true -incremental=true -swf-version=12 -o ../build/gui/flash/XVMBackground.swf
cp -a configs/. ../build/gui/flash/
rm ../build/gui/flash/XVMBackground.swf.cache
