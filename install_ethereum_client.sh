#!/usr/bin/env sh

CLIENT="$1"
if [ -z "$CLIENT" ]; then
    echo "Missing client"
    exit 1
fi

if [ "$CLIENT" != "geth" ] && [ "$CLIENT" != "parity" ]; then
    echo "Client must be either 'geth' or 'parity'"
    exit 1
fi

VERSION="$2"
if [ -z "$VERSION" ]; then
    echo "Missing Version"
    exit
fi

OS="$3"
if [ -z "$OS" ]; then
    OS="linux"
fi

ARCH="$4"
if [ -z "$ARCH" ]; then
    ARCH="amd64"
fi

install_parity() {
    case $OS in
        ("linux")   OS="unknown-linux-gnu";;
        ("darwin")  OS="apple-darwin";;
        ("windows") OS="pc-windows-msvc";;
    esac

    case $ARCH in
        ("amd64")   ARCH="x86_64";;
        ("386")     ARCH="i686";;
    esac

    RELEASE=https://releases.parity.io/v$VERSION/$ARCH-$OS/parity
    curl -sfSO "${RELEASE}"

    chmod +x parity
    mv parity parity-$VERSION
}

install_geth() {
    COMMIT=https://api.github.com/repos/ethereum/go-ethereum/commits/v$VERSION
    ID=`curl $COMMIT | jq -r '.sha' | cut -c1-8`

    NAME=geth-$OS-$ARCH-$VERSION-$ID
    RELEASE=https://gethstore.blob.core.windows.net/builds/$NAME.tar.gz

    curl -sfSO "${RELEASE}"
    tar -xvzf $NAME.tar.gz

    mv $NAME/geth geth-$VERSION
    chmod +x geth-$VERSION

    rm $NAME.tar.gz
    rm -rf $NAME
}

if [ "$CLIENT" = "geth" ]; then
    install_geth
elif [ "$CLIENT" = "parity" ]; then
    install_parity
fi
