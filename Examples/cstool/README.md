# cstool

An implementation of [cstool](https://github.com/aquynh/capstone/tree/master/cstool) in Swift.

Demonstrates how to use Capstone from Swift with [capstone-swift](https://github.com/zydeco/capstone-swift).

## Differences from reference implementation

* Padding between instruction bytes and mnemonic is calculated based on the biggest instruction.
* Uses `--version` instead of `-v` to show Capstone version and info.
* Differences in detailed instruction printing.
