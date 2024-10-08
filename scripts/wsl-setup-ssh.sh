#!/bin/bash

if [[ ! -e /mnt/c ]]; then
  echo "no C drive was detected at /mnt/c/. this shell is not in WSL. this script is only intended to run in WSL. exiting"
  exit 1
fi

WSL_USER=$(whoami)
WINDOWS_USER=$WSL_USER
CONTAINER_USER="root"
USAGE="usage: wsl-setup-ssh.sh [--windows-user STRING] [--wsl-user STRING] [--container-user STRING]

WARNING: runs sudo when setting file permissions

For more, see https://serverfault.com/a/253314

Path	              Permission
.ssh directories    0700 (drwx------)
private keys        0600 (-rw-------)
config              0600 (-rw-------)
public keys         0644 (-rw-r--r--)
authorized_keys     0644 (-rw-r--r--)
known_hosts         0644 (-rw-r--r--) 

Copies the windows /c/users/$WINDOWS_USER/.ssh folder to wsl at /home/$WSL_USER/.ssh and sets the chown of each file to '$CONTAINER_USER'. 
File permissions might need to be checked manually

Assumptions
- SSH is already setup properly in windows
- Script is ran inside WSL
- container user '$CONTAINER_USER' is an available user inside WSL

Optional
  --windows-user    STRING        Defaults to $WINDOWS_USER (whoami). The user to use when copying the .ssh folder
  --wsl-user        STRING        Defaults to $WSL_USER (whoami). The user to use when copying the .ssh folder
  --container-user  STRING        Defaults to $CONTAINER_USER. The user to set key permissions to
  -h, --help                      Show this help
"
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
  case $1 in
    --windows-user)
      WINDOWS_USER=$2
      shift # past argument
      shift # past value
      ;;
    --wsl-user)
      WSL_USER=$2
      shift # past argument
      shift # past value
      ;;
    --container-user)
      CONTAINER_USER=$2
      shift # past argument
      shift # past value
      ;;
    -h|--help)
      printf "$USAGE"
      exit 0
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

WINDOWS_SSH_FOLDER=/mnt/c/users/$WINDOWS_USER/.ssh
WSL_SSH_FOLDER=/home/$WSL_USER/.ssh
echo "copying ssh folder from $WINDOWS_SSH_FOLDER to $WSL_SSH_FOLDER, setting read-write permissions on keys, and changing ownership to $CONTAINER_USER"
mkdir $WSL_SSH_FOLDER
cp -rf $WINDOWS_SSH_FOLDER/* $WSL_SSH_FOLDER
# bad owner or permissions on ~/.ssh/config
# https://serverfault.com/questions/253313/ssh-returns-bad-owner-or-permissions-on-ssh-config#:~:text=These%20commands%20should%20fix%20the%20permission%20problem%3A%20chown,more%20files%20are%20affected%2C%20replace%20config%20with%20%2A.
sudo chown -R -v $CONTAINER_USER $WSL_SSH_FOLDER
sudo chmod -R -v 0600 $WSL_SSH_FOLDER
sudo find $WSL_SSH_FOLDER -name known_hosts -type f -exec chmod -v 644 {} \;
sudo find $WSL_SSH_FOLDER -name "*.pub"     -type f -exec chmod -v 644 {} \;
sudo chmod -v 0700 $WSL_SSH_FOLDER
