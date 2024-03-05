#!/bin/sh
# Permit scp
#todo: parse parse command  "scp -f" and "scp -t" to force rootpath
 
case $SSH_ORIGINAL_COMMAND in
 'scp'*)
    exec $SSH_ORIGINAL_COMMAND 
    ;;
 '/usr/lib/openssh/sftp-server'*)
    exec $SSH_ORIGINAL_COMMAND 
    ;;
   *)
    echo "Access Denied"
    ;;
esac
