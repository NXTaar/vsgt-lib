#!/bin/bash

FLAGS=${1//\*/} # current window flag
FLAGS=${FLAGS//-/⦁} # last window flag
FLAGS=${FLAGS//\#/} # window activity flag
FLAGS=${FLAGS//\~/} # window silence flag
FLAGS=${FLAGS//\!/} # window bell flag
FLAGS=${FLAGS//Z/} # window zoomed flag

echo ${FLAGS}
