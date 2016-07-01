cp -R ml_client tempdirectory
python prebuild.py
rm -R $WORKSPACE../build/scripts/client
cp -R tempdirectory $WORKSPACE../build/scripts/client
rm -R tempdirectory