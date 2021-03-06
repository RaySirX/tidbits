#! /bin/bash
#
#U NAME
#U    sampleSkeleton.sh - Sample skeleton script
#U
#U SYNOPSIS
#U    sampleSkeleton.sh <mandatory> [optional]
#U
#U DESCRIPTION
#U    What's the use case of this script?
#U
#U OPTIONS
#U    mandatory   - mandatory argument
#U    optional    - optional argument
#U
#
# History
#     Raymond Tai - Jan 1, 2017 - Initial Implementation
#
function usage() {
# usage - Any comment in script starting with '#U' will show up in "usage"
  egrep "^#U" $0 | sed -e 's/^#U //g' -e 's/^#U//g'
  exit 1
}

function timestamp() {
  date +"%F %T"
}

function logMessage() {
  echo $(timestamp) - $1
}

function logSection() {
  logMessage "-------------------------------------------"
  logMessage "$1"
  logMessage "-------------------------------------------"
}

function onErrorExit() {
# onErrorExit - if status is non-zero print message and exit
  local status=$1
  local message=${2:-Exiting due to unexpected status code ${status}}
  if [ ${status} -ne 0 ]; then
     logSection $2
     exit 998
  fi
}

#
# parse arguments
#
TEMP=`getopt -o u:v:x --long upgrade:,--version:,--noDE -n 'installDE' -- "$@"`
if [ $? != 0 ] ; then
   usage
   exit 1
fi
eval set -- "$TEMP"

while true ; do
  case "$1" in
    -u|--upgrade) instance=$2
        action=--upgrade
        shift 2
        ;;
    -v|--version) version=$2
        shift 2
        ;;
    -x|--noDE) noDE=1
        shift
        ;;
    --) shift ; break ;;
    *) usage; exit 1 ;;
  esac
done

#
# Check initial conditions, arguments, san
#
if [ "${checkCondition}" = "Unknown" ]; then
  usage
  exit 1
fi

#
# Start of use case
#
logSection "$0"

runSomething
status=$?
onErrorExit ${status} "runSomething went wrong"
onErrorExit $(runSomethingThatReturnsNumericStatus)
#
# End of use case
#
logSection "DONE"
