#!/bin/bash

if [[ $1 == '-i' ]]; then

  echo -n 'Host: '
  read drachost

  echo -n 'Username: '
  read dracuser
else
  drachost=192.168.1.29
  dracuser=root
fi

# echo -n 'Password: '
# read -s dracpwd
# echo

dracpwd=dmr5669

/Library/Java/JavaVirtualMachines/jdk-17.0.2.jdk/Contents/Home/bin/java -jar $HOME/lib/java/avctKVM.jar \
  -Djava.library.path=/Library/Java/JavaVirtualMachines/jdk-17.0.2.jdk/Contents/Home/lib com.avocent.idrac.kvm.Main \
  ip=$drachost kmport=5900 vport=5900 user=$dracuser passwd=$dracpwd \
  apcp=1 version=2 vmprivilege=true "helpurl=https://$drachost:443/help/contents.html"

# /Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home/bin/java
