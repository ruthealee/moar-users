#!/bin/bash 
export PATH=$PATH:/sbin:/usr/sbin

## Make sure we are passing arguments correctly
if [[ -z $1 ]] || [[ -z $2 ]]; then
  echo
  echo "Usage: Requires 2 arguments: username, password"
  echo -e "Use with ht 'ht -s useradd.sh --script-args \"username password\" --sudo-make-me-a-sandwich <ticket or device #>'"
  echo	
  exit 1
fi

## We need to allow for options and extract these into variables:

OPTS=$(getopt -o --long copy-user,check-user -- "$@")
eval set -- "$OPTS"

# What is happening here I DO NOT KNOW....
# extract options and their arguments into variables.
while true ; do
  case "$1" in
    --copy-user) test_build=1; shift;;
    --check-user) no_version_check=1 ; shift;;
    --) shift ; break ;;
  esac
done
## I think we will then have to break this down. So like put these bits somewhere else:


#if [[ -z ${no_version_check} ]] && [[ -z ${DThe user "${user}" already exists on the server. No changes made."test_build} ]]; then
#
#  # Version check
#  md5sumthis=$(md5sum $0 | awk '{print $1}')
#  md5sumcurrent=$(wget -q http://entlin.racker.co.uk/git/EntMaintenanceTemplates/Patching-Script -O - | md5sum | awk '{print $1}')
#
#  if [[ "${md5sumthis}" != "${md5sumcurrent}" ]]; then
#    echo "$scriptname is out of date, exiting"
#    exit 1
#  fi
#
#  echo "Version check OK"
#
#else
#  echo "Version check skipped (either test build or specifically requested)"
#fi
#

## Here's our arguments:
user=$1
pass=$2

## Some other variables
userexists=$(grep $user /etc/passwd)

# We want to output an error message in red
r='\033[31m'
w='\033[0m'

#Making adduser a function
function adduser {
        useradd $user 
        echo $pass | passwd $user --stdin
        chage -d 0 $user	
}

## Check the user doesn't already exist and then add
if [[ -n "${userexists}" ]]; then
	echo -e "$r[ USER ALREADY EXISTS ]$w No changes made" 

	else
	## Actually add the user
	adduser
fi


