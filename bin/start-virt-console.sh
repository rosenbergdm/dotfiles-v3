#!/bin/bash

echo -n 'Host: '
read drachost

echo -n 'Username: '
read dracuser

echo -n 'Password: '
read -s dracpwd
echo
/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home/bin/java -cp /Users/davidrosenberg/lib/java/avctKVM.jar -Djava.library.path=/Library/Java/JavaVirtualMachines/jdk1.8.0_112.jdk/Contents/Home/lib com.avocent.idrac.kvm.Main ip=$drachost kmport=5900 vport=5900 user=$dracuser passwd=$dracpwd apcp=1 version=2 vmprivilege=true "helpurl=https://$drachost:443/help/contents.html"

