# termenv

Configuration of terminal environment with ansible playbook.

The configuration contains very basic setup with:
- [`zsh`](https://zsh.sourceforge.io/)
- [`oh-my-zsh`](https://ohmyz.sh/)
- [`PoverLevel10k`](https://github.com/romkatv/powerlevel10k)
- [`zsh-dircolors-solarized`](https://github.com/joel-porquet/zsh-dircolors-solarized)
- [`tmux`](https://github.com/tmux/tmux) with Powerline theme.
- [`fzf`](https://ohmyz.sh/) with [`fzf ohmyz plugin`](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf)

# Prerequisites

## Fedora

```
sudo dnf install git ansible
```

## Ubuntu

```
sudo apt-get update
sudo apt-get install git ansible
```

# Install

```
git clone https://github.com/jazik/termenv.git
cd termenv
ansible-playbook -i hosts termenv.yml
```

# Sample screen shots

![Zsh command line](../media/termenv.png?raw=true)

![Tmux](../media/termenv-tmux.png?raw=true)

# Testing playbooks

In order to run local tests install `vagrant` with both `libvirt` and
`VirtualBox` providers. Check our host system distro guidelines how
to install those.

To test the playbook and configuration there is [Vagrantfile](Vagrantfile)
with two predefined configurations. One for `fedora` and one for `ubuntu`.
There are also couple of custom options to run local tests or to have
envs for manual testing.

```
vagrant [--local=no|yes] [--no-install=yes|no] <command> [fedora|ubuntu]

--local
   Run playbook from Github (no, default) or from local current
   directory (yes)

--no-install
   Install dependencies and run playbook (yes, default) or skip
   installation (no) and just start machine for manual testing

<command>
   vagrant commands such as up, destroy, ssh etc

fedora|ubuntu
   Linux distro to deploy, in none is selected both are created.
```

For example to run playbook for `fedora` from local repo:

```
vagrant --local=yes up fedora
vagrant ssh fedora
vagrant destroy fedora
```

The tests are not automated, nothing is really checked after playbook
is executed. But provisioning of machine will fail if playbook fails.
The configuration have to be then checked manually by ssh-ing to the
machine and looking around.
