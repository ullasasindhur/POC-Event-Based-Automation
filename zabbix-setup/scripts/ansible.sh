#!/bin/bash
sudo yum install python3 -y
python3 -m pip -V
sudo python3 -m pip install --upgrade pip
python3 -m pip install --user ansible
