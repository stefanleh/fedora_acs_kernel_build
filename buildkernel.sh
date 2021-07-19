#!/bin/bash

if [[ $1 == *".fc3"* ]]; then

	cd /root
	VERSION=$1
	koji download-build --arch=src kernel-$VERSION
	rm /root/rpmbuild/ -rf
	rpmdev-setuptree
	rpm -Uvh kernel-$VERSION.src.rpm
	cd /root/rpmbuild/SOURCES/
	cat /root/acso.patch >> linux-kernel-test.patch
	cat /root/agesa.patch >> linux-kernel-test.patch
	#sed -i -e 's/^CONFIG_USB_XHCI_HCD=y/CONFIG_USB_XHCI_HCD=m/g' kernel-x86_64-fedora.config
	cd /root/rpmbuild/SPECS/
	dnf builddep kernel.spec -y
	#sed -i 's/# END OF PATCH DEFINITIONS/Patch9001: agesa.patch\n# END OF PATCH DEFINITIONS/g' kernel.spec
	#sed -i 's/# END OF PATCH DEFINITIONS/Patch9000: acso.patch\n# END OF PATCH DEFINITIONS/g' kernel.spec
	sed -i 's/# define buildid .local/%define buildid .acsagesa/g' kernel.spec
	rpmbuild -bb --without debug --target=x86_64 kernel.spec
	rm /root/rpmbuild/RPMS/x86_64/kernel-debuginfo* -rf
	cd /root/rpmbuild/RPMS/x86_64/
	ls -al
	mv kernel* /rpms/

fi
