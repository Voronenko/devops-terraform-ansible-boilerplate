#!/bin/bash

ALREADY_SCANNED=`ssh-keygen -f ~/.ssh/known_hosts -F $1`

if [ -z "${ALREADY_SCANNED}" ]; then
  echo "host needs to be scanned for $1"
  ssh-keyscan -H -T 10 $1 >> ~/.ssh/known_hosts
fi
