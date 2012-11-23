#!/bin/sh
. ./ver.sh
raco planet remove $DRS_VER
echo "You must restart DrRacket to unload the tool"
