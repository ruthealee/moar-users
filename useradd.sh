#!/bin/bash 
export PATH=$PATH:/sbin:/usr/sbin

## Make sure we are passing arguments correctly
if [[ -z $1 ]] || [[ -z $2 ]]; then
  echo
  echo "Usage: Requires 2 arguments: username, password"
  echo "Use with ht 'ht -s useradd.sh --script-args username password --sudo-make-me-a-sandwich <ticket or device #>'"
  echo	
  exit 1
fi

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


