#!/bin/bash

appKey()
{
  appName=$1
  profile=$2

  if [ -z $appName ]
  then
    echo "App name is required for this command."
    exit 1
  fi

  if [ ! -z $profile ]
  then
    profile=" --profile $profile"
  fi

  echo "aws kms list-aliases$profile --query \"Aliases[?AliasName=='alias/ecs/$appName'].TargetKeyId\""
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

  echo "AWS_SDK_LOAD_CONFIG=1 AWS_PROFILE=$profile sops $option -i src/main/resources/application-$profile.yml"
}

usage()
{
  echo "$(basename "$0") [command...]"
  echo
  echo "    -k, --get-key       show the current app key for the given appName and profile"
  echo "    -e, --encrypt       encrypt the application-*.yml for the given profile"
  echo "    -d, --decrypt       decrypt the application-*.yml for the given profile"
  echo

  exit 1
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
  -h | --help )
    usage
    ;;
  * )
    exit 1
esac
