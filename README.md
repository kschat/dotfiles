# Kschat's Dotfiles


## About

Once upon a time I accidently deleted my home directory. This is an attempt
to never lose my configuration again. Currently this supports OS X and Arch
Linux, as those are my primary OSs.

## Prerequisites

The `bootstrap.zsh` file uses some `zsh` only features, and thus requires that
`zsh` is installed on your system. Eventually I'd like to provide a way to have
`bootstrap.zsh` be written using `zsh` and auto-install `zsh` if it's missing.
For now, you'll need to install it manually.

## Install

Once `zsh` is installed, use the following:

``` shell
git clone https://github.com/kschat/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootsrap.zsh
```

## Options

The `bootstrap.zsh` script accepts a few arguments as well

``` shell
bootstrap.zsh [-v|vv|vvv --verbose] [-d --debug] [-f --force] /path/to/install
```

## What you get

### Arch

![Arch screenshot](http://i.imgur.com/XIFggpE.png)

### OS X

![macOS screenshot](http://i.imgur.com/ZkoaD8J.png)
