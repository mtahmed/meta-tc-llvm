# meta-tc-llvm

This is currently a work-in-progress. It will need refinement overtime.
This work is based on earlier work by Mark Hatle hosted at this wiki page:
[Adding a secondary toolchain](http://www.openembedded.org/wiki/Adding_a_secondary_toolchain)

## Status

Able to build all the packages for `core-image-minimal` except the following:

- linux-yocto-tiny
- dtc
- elfutils
- gcc
- gcc-cross
- gcc-cross-initial
- gcc-runtime
- prelink
- eglibc
- rpm
- libgcc
- e2fsprogs

Some of the packages that do build require patches either from upstream or
the ones added by me to my [poky](https://github.com/mtahmed/poky) repository.

## Installation

Clone this repository into your poky directory.

```bash
git clone https://github.com/mtahmed/poky.git
cd poky
git clone https://github.com/mtahmed/meta-tc-llvm.git
```

This `meta-tc-llvm` layer and the `poky-clang` tree that it is used with do not
have a recipe to build clang (yet) and rely on the user providing their own
pre-built clang. There are two ways to achieve this:

#### Install clang on host OS

Simply installing clang on the host OS is sufficient if you do not want to build
clang yourself. This does require that the clang provided by the host OS has
all targets enabled (`--enable-targets=all` option).

#### Build clang yourself

One can also build clang themselves and install to `poky/meta-tc-llvm`
directory (so that the `poky/meta-tc-llvm/bin/` has the llvm+clang binaries and
`poky/meta-tc-llvm/lib` has the llvm+clang libraries.)

## Usage

After the `source oe-init-build-env build-dir`, change bblayers.conf file
to include the `meta-tc-llvm` layer and change the other `conf/local.conf` file
as needed.

# Contact

- Muhammad Tauqir Ahmad
- muhammad.tauqir.ahmad@gmail.com
- [csclub.uwaterloo.ca/~mtahmed](http://csclub.uwaterloo.ca/~mtahmed)
