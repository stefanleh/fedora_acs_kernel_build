Docker Image for building custom ACS & Agesa patched Fedora kernels
===================================================================

# Find the image at DockerHub

    https://hub.docker.com/r/stefanlehmann/acs_fedora

# Pull the image from DockerHub

    docker pull stefanlehmann/acs_fedora

# Build the image (optional)

    docker build -t stefanlehmann/acs_fedora -f Dockerfile .

# Run the kernel build

    docker run -it -v /mnt/faststorage/kernel:/rpms stefanlehmann/acs_fedora 5.7.17-200.fc32

Replace `/mnt/faststorage/kernel` with the directory the resulting kernel rpms should be written to.
Replace `5.7.17-200.fc32` with the kernel version you want to build.

# Install the built rpms

    rpm -ivh kernel-* --force
    
# Make the new kernel known to grub (EFI only)

    grub2-mkconfig -o /etc/grub2-efi.cfg
