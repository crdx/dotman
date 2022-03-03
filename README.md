# dotman

dotman is a dotfile manager for those who...

- like to store their dotfiles in a git repository.
- like to deploy their dotfiles to many remote machines.
- like to be able to simply deploy a minimal-dependency shell script.
- don't want a dependency on automation tools and would rather deploy via ssh.
- don't want to have to write any significant amount of shell script if avoidable.
- enjoy configuring tools using ruby DSLs.

## Installation

Install from [rubygems.org](https://rubygems.org/gems/dotman-bin).

```
gem install dotman-bin
```

The binary is called `dotman`.

## Command line interface

```
Usage:
    dotman [ --home=PATH ] --base=PATH build

Options:
    -b, --base=PATH    Directory from where configuration files should be sourced
    --home=PATH        Directory where symlinks should be placed [default: $HOME]
```

## Usage

A `Dotfile` is a lot like a `Vagrantfile`. It's pure Ruby, but via use of DSL-like patterns it looks more like a configuration file, while still leveraging all the power of a full programming language.

The `dotman build` command operates by reading the `Dotfile` in the current directory and processing it. It outputs to standard output a dependency-free Bash script which will install your dotfiles.

"Install", in this case, means to create a symlink from your *home* directory to the relevant files inside your *base* directory. This means that updating your dotfiles on a machine requires nothing more than a `git pull`.

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
    config.link 'profile',    to: '.profile',    only: [:huck, :sawyer, :twain]
    config.link 'ssh/config', to: '.ssh/config', only: [:huck]
end
```

The machine's hostname can be used as a conditional. The `only` and `except` options can restrict or exclude machines from the action.

It's also possible to create aliases to hostnames using `alias_host`, if the machine's name is unwelcome.

Place this file in the root directory of the git repository where your dotfiles are stored.

The output of `dotman build` is a shell script. You probably want to redirect it into a file, perhaps called `install`.

```
dotman build --base $HOME/.conf > install
```

## Deployment

Deploying over ssh is simple.

```bash
#!/bin/bash
set -e

git push

COMMAND='cd $HOME/.conf && git pull && ./install'

for MACHINE in clemens finn sawyer; do
    ssh -t $MACHINE $COMMAND
done
```

This is all it takes to mass-deploy your dotfiles across any number of machines in your "fleet".

## Tests

Run tests with `just test`.

Code coverage is output to `coverage/`, and stands at almost 100%.

## Development

Use `just install` to build and install locally for testing.

Use `just publish` to release to rubygems.org.

## Contributions

Open an [issue](https://github.com/crdx/dotman/issues) or send a [pull request](https://github.com/crdx/dotman/pulls).

## Licence

[MIT](LICENCE.md).
