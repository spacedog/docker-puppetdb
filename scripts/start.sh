#!/bin/bash

SCRIPT_FOLDER=/my_init

# Run init scripts
for SCRIPT in ${SCRIPT_FOLDER}/*
do
  if [ -f $SCRIPT -a -x $SCRIPT ]
  then
    $SCRIPT
  fi
done

/usr/sbin/puppetdb ssl-setup &&
/usr/sbin/puppetdb foreground


