# Using official php runtime base image
from ubuntu:14.04

MAINTAINER "Toshiki Inami <t-inami@arukas.io>"

# Install dependencies
run apt-get update && \
    apt-get install -y curl build-essential && \
    apt-get build-dep -y emacs24

# Install emacs
env EMACS_VERSION="24.4"
run TMP_DIR=$(mktemp -d) && \
    curl -sSL -o $TMP_DIR/emacs.tar.xz http://ftpmirror.gnu.org/emacs/emacs-$EMACS_VERSION.tar.xz && \
    tar -xJ -C $TMP_DIR -f $TMP_DIR/emacs.tar.xz && \
    cd $TMP_DIR/emacs-$EMACS_VERSION && \
    ./configure && \
    make -j 8 install && \
    rm -rf $TMP_DIR

workdir /files

CMD ["emacs","-q","--no-splash", "-f","tetris"]
