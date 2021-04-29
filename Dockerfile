FROM fedora:33
RUN dnf upgrade -y
RUN dnf install koji rpmdevtools dnf-plugins-core -y
WORKDIR /root
COPY acso.patch /root/acso.patch
COPY agesa.patch /root/agesa.patch
COPY buildkernel.sh .
RUN chmod +x buildkernel.sh
RUN mkdir /rpms
VOLUME /rpms
ENTRYPOINT ["/root/buildkernel.sh"]
