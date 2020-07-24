#!/bin/bash

appKey()
{
  profile=$1
  appName=$2

  if [ -z $appName ]
  then
    appName=${PWD##*/}
  fi

  if [ ! -z $profile ]
  then
    profile=" --profile $profile"
  fi

  aws kms list-aliases$profile --query "Aliases[?AliasName=='alias/ecs/$appName'].TargetKeyId"
}

sops()
{
  option=$1
  profile=$2

  if [ -z $profile ]
  then
    echo "The profile arg is required."
    exit 1
  fi

  # There's an error that doesn't make this command to run by this script. So, just paste and execute to work
  echo AWS_SDK_LOAD_CONFIG=1 AWS_PROFILE=$profile sops $option -i src/main/resources/application-$profile.yml | xclip -r -sel clip
  echo "Done! Paste the command and execute."
}

getStatus()
{
  profile=$1

  if [ ! -z $profile ]
  then
    profile="--profile $profile"
  fi

  aws sts get-caller-identity $profile
}

usage()
{
  echo "$(basename "$0") [command...]"
  echo
  echo "    -k, --get-key       show the current app key for the given profile and appName(optional)"
  echo "    -e, --encrypt       encrypt the application-*.yml for the given profile"
  echo "    -d, --decrypt       decrypt the application-*.yml for the given profile"
  echo "    -s, --status        get the status to know if it is connected to AWS"
  echo

  exit 0
}


#### Main

case $1 in
  -k | --get-key )
    appKey $2 $3
    ;;
  -e | --encrypt )
    sops "-e" $2
    ;;
  -d | --decrypt )
    sops "-d" $2
    ;;
  -s | --status )
    getStatus $2
    ;;
  * )
    usage
esac
