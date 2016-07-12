#!/bin/bash

python prebuild.py
/home/monstrofil/dev/flash/flex/bin/mxmlc -load-config+=WorldofWarshipsHammerConfigUbuntu.xml -omit-trace-statements -debug=false -incremental=true -swf-version=12 -o $WORKSPACE/build/gui/flash/XVMBackground.swf

mkdir ml-lastomer
python file_divide.py config/__background.xml ml-lastomer/ RootBlock
cp -R ml-lastomer/ configs/gui/flash/ml-lastomer/

cp -a configs/. $WORKSPACE/build/