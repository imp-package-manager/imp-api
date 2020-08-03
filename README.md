![AURA](https://raw.githubusercontent.com/patztablook22/meta/master/aura/logo.png)



## “AUR packages - _Anywhere._”

**CROSS-PLATFORM** [Arch User Repository](https://aur.archlinux.org) Assistant written in Ruby.

![demo](https://raw.githubusercontent.com/patztablook22/meta/master/aura/demo.gif)

This tool aims to provide simple yet powerful functionality. \
It will assist you when installing packages from the AUR. \
It does cloning for you, can parse PKGBUILD, and even try to execute it a in given environment, yielding feedback on what to target manually.

## Installation
```
curl -s https://raw.githubusercontent.com/patztablook22/aura/master/install.sh | bash
```

## TL;DR Examples
```bash

# install opera-beta
# automatically checking for local files
# and using them instead of downloading

aura opera-beta

# install discord after downloading a corrupt file
# e.g. due to SIGINT

aura --redo discord

# install kewl and keep it in the fakeroot
# to check the files it will create
# also skip "glibc" dependency
# and show what exactly is happening

aura --keep --skip glibc --verbose kewl

```

## Usage
```bash

# print help
aura --help

# request a package from the AUR if necessary and try to build it
aura package

# request a package from the AUR and try to (re)build it
aura package --redo

# keep the package in the fakeroot dir for testing / review
aura package --keep

# skip checking dependency "dep" and "another"
aura package --skip dep,another

# verbose mode
aura package --verbose

```

## Config
Default config location: `GIT_BASE/config.txt` \
For the installer, that is `~/.config/aura/config.txt` \
The config file is being parsed using the same internal PKGBUILD parser \
hence the syntax; example:

```PKGBUILD
aurs = /my/aur/repositories
pkgs = /my/packages
root = /my/root
redo = false

# not yet implemented
errs = /my/aura/error/file.txt
```

## Manual installation

**Dependencies**
  - git
  - ruby
  
**Steps**
  1. dependencies
  2. clone the repository into `~/.config/`
  3. execute `BASEDIR/aura`
  4. you can link it into `/usr/bin/`

# Development notes

The complexity of packages this tool can handle shall increase.
