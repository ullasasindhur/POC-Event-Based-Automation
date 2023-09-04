#!/bin/bash
curl $AAP_LINK -o setup.tar.gz
tar zxvf setup.tar.gz
rm setup.tar.gz
sudo subscription-manager register --username $USERNAME --password $PASSWORD --auto-attach