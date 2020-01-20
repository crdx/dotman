# dotman

dotman is a dotfile manager for those who

- like to store their dotfiles in a git repository
- like to deploy their dotfiles to many remote machines
- like to be able to simply deploy a minimal-dependency shell script
- don't want a dependency on automation tools and would rather deploy via ssh
- don't want to have to write any significant amount of shell script if avoidable
- enjoy configuring tools using ruby DSLs

## Installation

Install from [rubygems.org](https://rubygems.org/gems/dotman-bin).

```
gem install dotman-bin
```

The binary is called `dotman`.

## Command line interface
```
Usage:
    dotman [options] build

Options:
        --base=BASE  Dir from where symlinks should be sourced [default: ~/.dotfiles/files]
        --home=HOME  Dir where symlinks should be placed       [default: ~]
```

## Usage


A `Dotfile` is a lot like a `Vagrantfile`. It's pure Ruby, but via use of DSL-like patterns it looks more like a configuration file, while still leveraging all the power of a full programming language.

The `dotman build` command operates by reading the `Dotfile` in the current directory and processing it. It outputs to standard output a dependency-free Bash script which will install your dotfiles.

"Install", in this case, means to create a symlink from your *home* directory to the relevant files inside your *base* directory. This means that updating your dotfiles on a machine requires nothing more than a `git pull`.

The default of `~/.dotfiles/files` for the base directory can be overridden with `--base`, and the default of `~` for the home directory can be overridden with `--home`.

## Example

In this example your machine naming scheme is literature-themed.

```rb
Dotfile.configure do |config|
    config.alias_host :twain, :clemens
    config.alias_host :huck, :finn

    config.link 'bashrc', to: '.bashrc',    except: [:twain]
    config.link 'bashrc', to: '.bash_extras', only: [:twain]

    %w[bash_completion.d tmux.conf inputrc vimrc vim].each do |entry|
        config.link entry, to: '.' + entry
    end

    config.link 'gitconfig',  to: '.gitconfig',  except: [:twain]
    config.link 'profile',    to: '.profile',      only: [:huck, :sawyer, :twain]
    config.link 'kitty',      to: '.config/kitty', only: [:huck, :sawyer

    config.link 'ssh/config', to: '.ssh/config', only: [:huck]
end
```

The machine's hostname can be used as a conditional. The `only` and `except` options can restrict or exclude machines from the action.

It's also possible to create aliases to hostnames using `alias_host`, if the machine's name is unwelcome.

Place this file in the root directory of the git repository where your dotfiles are stored. If happy with the defaults, ensure the relevant files are in the `files/` directory, otherwise specify a different one with `--base`.

The output of `dotman build` is a shell script. You probably want to redirect it into a file, perhaps called `install`.

```
dotman build > install
```

This `install` script can be run from anywhere. It does not necessarily have to be kept alongside the relevant `files/` directory, but it makes sense. The author checks it into their dotfiles repository and runs it as part of the post-`git clone` procedure, and recommends this approach.

## Deployment

Deploying over ssh is incredibly simple.

```bash
#!/bin/bash
set -e

git push

COMMAND='cd $HOME/.dotfiles && git pull && ./install'

for MACHINE in clemens finn sawyer; do
    ssh -t $MACHINE $COMMAND
done
```

This is all it takes to mass-deploy your dotfiles across any number of machines in your "fleet".

## Tests

Run tests with `tools/test`.

Code coverage is output to `coverage/`, and stands at almost 100%.

## Development

Use `tools/install` to build and install locally for testing.

Use `tools/publish` to release to rubygems.org.

## Bugs or contributions

Open an [issue](http://github.com/crdx/dotman/issues) or send a [pull request](http://github.com/crdx/dotman/pulls).

## Licence

[MIT](LICENCE.md).
