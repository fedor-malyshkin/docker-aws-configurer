#!/bin/sh

cd /scripts
python3 -m venv venv
. venv/bin/activate
if test -f "requirements.txt"; then
    pip install -r requirements.txt
fi
python3 configure.py