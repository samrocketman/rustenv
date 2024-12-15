# Rust Dev Environment

A simple rust development environment for my Desktop Linux machines.

> **WARNING:** this environment gets set up with my personal dotfiles including
> git author settings.

# Building

To build the initial docker image run the following command.

    docker build -t rust .

Will pull in the latest available version of Rust.

# Installation

Add to `.bashrc` file the following function.

```bash
# rust environment provided by my rustenv project
function rustenv() {
    docker run -it --rm -v "$PWD":"$PWD" -w "$PWD" rust
}
```

# Usage

Start this from the root of a Git repository containing a Rust project.

    rustenv
