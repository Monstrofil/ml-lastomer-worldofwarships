set -e

cp -R ml_client tempdirectory
python prebuild.py
mkdir $WORKSPACE/build/scripts/
cp -R tempdirectory $WORKSPACE/build/scripts/client
rm -R tempdirectory