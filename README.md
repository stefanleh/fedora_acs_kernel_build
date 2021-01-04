Docker Image for building custom ACS & Agesa patched Fedora kernels
===================================================================

# Build the image

  docker build -f Dockerfile .

# Run the build

  docker run -it -v /mnt/faststorage/kernel:/rpms   687ccc28e350 5.7.17-200.fc32
