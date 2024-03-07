#!/bin/bash
set -Eeo pipefail

# shellcheck disable=2154
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR


chr=/home
mkdir -p "${chr}"
chown root:root "${chr}"
chmod 755 "${chr}"

myBinaries=("sh" "/usr/lib/openssh/sftp-server" "/usr/lib/ssh/sftp-server" "scp" "ash")
for bin in ${myBinaries[@]}; do
  pathBin=`which $bin` || continue
  cp -v --parents "$pathBin" "${chr}"
  list="$(ldd $pathBin | awk '{if ($2=="=>") print $3 ;else print $1}')"
  for item in `echo "$list" | sort| uniq`
  do
   cp -v --parents "$item" "${chr}" || :
  done
done

cp --parents /usr/local/bin/permit-scp.sh ${chr}  
mkdir ${chr}/dev
mknod ${chr}/dev/null c 1 3
chmod 666 ${chr}/dev/null
cp --parents /etc/passwd /lib/x86_64-linux-gnu/libnss_files.so.2  ${chr}/ || :

