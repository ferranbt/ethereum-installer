
# Ethereum installer

Ethereum installer is a script to install different versions of [Geth](https://github.com/ethereum/go-ethereum) and [Parity](https://github.com/paritytech/parity-ethereum). Currently, the installer does not validate the signatures of the downloads.

## Usage

The general syntax is:

```
$ ./install_ethereum_client CLIENT VERSION [OS=linux ARCH=amd64]
```

For example:

```
$ ./install_ethereum_client parity 2.0.6
```
