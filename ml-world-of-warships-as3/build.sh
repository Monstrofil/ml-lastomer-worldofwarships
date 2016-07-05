#!/bin/bash

python prebuild.py
/home/monstrofil/dev/flash/flex/bin/mxmlc -load-config+=WorldofWarshipsHammerConfigUbuntu.xml -omit-trace-statements -debug=false -incremental=true -swf-version=12 -o $WORKSPACE/build/gui/flash/XVMBackground.swf
/usr/bin/python /home/monstrofil/dev/xml2as/xml2as.py.pyc -i $WORKSPACE/configs/gui/unbound/dock.xml -n $WORKSPACE/MLDock -f /home/monstrofil/dev/flash/flex/bin/mxmlc
/home/monstrofil/dev/flash/flex/bin/mxmlc $WORKSPACE/MLDock.as -compatibility-version 4.12.1 -output $WORKSPACE/build/gui/flash/MLDock.swf
cp -a configs/. $WORKSPACE/build/