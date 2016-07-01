set -e

cp -R ml_client tempdirectory
python prebuild.py
mkdir ../build/scripts/
cp -R tempdirectory ../build/scripts/client
rm -R tempdirectory