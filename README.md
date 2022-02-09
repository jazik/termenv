# termenv

Configuration of terminal enviroment with ansible playbook.

The configuration contains very basic setup with `zsh`, `PoverLevel10k`,
`zsh-dircolors-solarized` and `tmux` with Powerline theme.

# Prerequisites

## Fedora

```
sudo dnf install git ansible
```

## Ubuntu

```
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
