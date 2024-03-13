# termenv

Configuration of terminal environment with ansible playbook.

The configuration contains very basic setup with:
- [`zsh`](https://zsh.sourceforge.io/)
- [`oh-my-zsh`](https://ohmyz.sh/)
- [`PowerLevel10k`](https://github.com/romkatv/powerlevel10k)
- [`zsh-dircolors-solarized`](https://github.com/joel-porquet/zsh-dircolors-solarized)
- [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions)
- [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting)
- [`tmux`](https://github.com/tmux/tmux) with Powerline theme.
- [`fzf`](https://github.com/junegunn/fzf) with [`fzf ohmyz plugin`](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf)
- [`neovim`](https://neovim.io/) with couple of handy plugins inspired by
  [`bcampolo/nvim-starter-kit`](https://github.com/bcampolo/nvim-starter-kit)
- [`nerd-fonts`](https://www.nerdfonts.com)

Inspired also by:
- [Terminal History Auto Suggestions As You Type With Oh My Zsh](https://www.dev-diaries.com/blog/terminal-history-auto-suggestions-as-you-type/)

# Prerequisites

The ansible script performs package installations. The user under which
you execute the script needs to be in `sudoers`.

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
ansible-playbook -i hosts --ask-become-pass termenv.yml
```

# Customization

All the roles are run by default. If you wish to install only some of
the roles or skip some roles, use `ansible` `tags`, which are defined
in [termenv.yml](termenv.yml).

For example to skip `tmux` run:

```
ansible-playbook -i hosts termenv.yml --skip-tags tmux
```

Or to install only `tmux` run:

```
ansible-playbook -i hosts termenv.yml --tags tmux
```

# Fonts

The `nerd-fonts` tag installs latest version of Fira Mono Nerd Fonts.

If you are installing the playbook in a remote system, container or
in a virtual machine, then note that the terminal will not display patched
fonts unless you install the fonts in your local system.
For how to configure your terminal to use the fonts see your terminal
documentation.

You can also use the playbook to install any other Nerd Font,
just pass the name as an option:

```
ansible-playbook -i hosts nerdfonts.yml -e "font_name=YourFontName"
```

The `YourFontName` should be the name of the Nerd Font zip file without .zip.
You can find it by checking the download link from
[Nerd Fonts Downloads](https://www.nerdfonts.com/font-downloads).

# Sample screen shots

![Zsh command line](../media/termenv.png?raw=true)

![Tmux](../media/termenv-tmux.png?raw=true)

# Testing playbooks

## Docker/Podman/Moby

If you would like to see how the environment looks or you would like
to experiment with the configuration, there is a [Dockerfile](Dockerfile)
in the project repo to create the environment quickly:

For environment on Fedora:

```
docker build -t termenv . --build-arg DISTRO=fedora
```

Or for Ubuntu:

```
docker build -t termenv . --build-arg DISTRO=ubuntu
```

Then run the container:

```
docker run --rm -it termenv
````

The playbooks are cloned from Github `main`.

## With Vagrant

In order to run local tests install `vagrant` with both `libvirt` and
`VirtualBox` providers. Check your host system distro guidelines how
to install those.

In `fedora` you can run:

```
sudo dnf install vagrant vagrant-libvirt VirtualBox libvirt
sudo usermod -a -G libvirt ${USER}
```

When using `fedora` ensure that `nfs` is enabled in `libvirt` firewall zone:

```
sudo systemctl --now enable virtnetworkd.service
sudo firewall-cmd --permanent --zone=libvirt --add-service=nfs
sudo firewall-cmd --reload
```

To test the playbook and configuration there is [Vagrantfile](Vagrantfile)
with two predefined configurations. One for `fedora` and one for `ubuntu`.
There are also couple of custom options to run local tests or to have
envs for manual testing.

```
vagrant [--local=no|yes] [--do-install=yes|no] <command> [fedora|ubuntu]

--local
   Run playbook from Github (no, default) or from local current
   directory (yes)

--do-install
   Install dependencies and run playbook (yes, default) or skip
   installation (no) and just start machine for manual testing

<command>
   vagrant commands such as up, destroy, ssh etc

fedora|ubuntu
   Linux distro to deploy, if none is selected both are created
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
