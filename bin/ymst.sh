#!/bin/bash
set -e
cd `dirname $0`
mailfile=`mktemp`
cat - > $mailfile
ruby send.rb $mailfile
rm $mailfile
