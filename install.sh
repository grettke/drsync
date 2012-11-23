#!/bin/sh
. ./ver.sh
raco planet fileinject $DRS_VER
echo "You must restart DrRacket to use the tool"
