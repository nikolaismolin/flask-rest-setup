#!/bin/bash

set -x

src_dir=$(cd $(dirname $0)/.. ; echo $PWD)
venv_dir=$src_dir/venv

# Create our virtual environment, without pip.
# One could have the OS install pip and make that part of the venv
#   process, but I've run into bugginess with that, and using
#   get-pip.py (below) is more foolproof.
# For example, Amazon Linux 2016.09 has a broken ensurepip for
#   Python3.
python3 -m venv --without-pip $venv_dir || exit $?


# Install pip.
source $venv_dir/bin/activate || exit $?
# I keep get-pip.py as a part of the source distribution, but you can
#   download the get-pip.py script via:
# wget https://https://bootstrap.pypa.io/get-pip.py
# I believe that we don't need to specify the $venv_dir because the
#   venv has already been activated.
#python3 $src_dir/get-pip.py $venv_dir || exit $?
python3 $src_dir/get-pip.py || exit $?
pip3 install --upgrade pip || exit $?


# Install dependencies.
pip3 install -r $src_dir/sentiment-clf/requirements.txt || exit $?


