#### Bash completion for Composer package and dependency manager

##### Requirements

* composer

##### Installation

1. To install you need to copy or make a symlink to `/usr/share/bash-completion/completions`

2. Then just relogin or restart your console

##### Usage

Before using completion you should install a composer as `composer` executable.
After then all done you can use it like `apt-get`.
Here is some features:

* package name will be searched when using `require` command

* if previous was a package, so next will be a version completion of this package
