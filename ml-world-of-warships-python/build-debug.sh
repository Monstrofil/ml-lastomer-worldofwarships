cp -R ml_client tempdirectory
rm -R ../debug/
/d/workspace/python27/python.exe prebuild.py
mkdir ../debug/
mkdir ../debug/scripts/
cp -R tempdirectory ../debug/scripts/client
rm -R tempdirectory