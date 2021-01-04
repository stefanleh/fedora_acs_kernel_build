Docker Image for building custom ACS & Agesa patched Fedora kernels
===================================================================

# Build the image (optional)

    docker build -t stefanlehmann/acs_fedora -f Dockerfile .

# Run the build

    docker run -it -v /mnt/faststorage/kernel:/rpms stefanlehmann/acs_fedora 5.7.17-200.fc32
