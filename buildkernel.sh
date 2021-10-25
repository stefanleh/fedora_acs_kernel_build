#!/bin/bash

if [[ $1 == *".fc3"* ]] 
then
	cd /root
	VERSION=$1
	koji download-build --arch=src kernel-$VERSION
	rm /root/rpmbuild/ -rf
	rpmdev-setuptree
	rpm -Uvh kernel-$VERSION.src.rpm
	cd /root/rpmbuild/SOURCES/
	cat /root/acso.patch >> linux-kernel-test.patch
	cat /root/agesa.patch >> linux-kernel-test.patch
	cd /root/rpmbuild/SPECS/
	dnf builddep kernel.spec -y
	sed -i 's/# define buildid .local/%define buildid .acsagesa/g' kernel.spec
	rpmbuild -bb --without debug --without debuginfo --target=x86_64 kernel.spec
	cd /root/rpmbuild/RPMS/x86_64/
	ls -al
	mv kernel* /rpms/
else 
	exec "$@"
fi
