# termenv

Configuration of terminal enviroment with ansible playbook.

The configuration contains very basic setup with:
- [`zsh`](https://zsh.sourceforge.io/)
- [`PoverLevel10k`](https://github.com/romkatv/powerlevel10k)
- [`zsh-dircolors-solarized`](https://github.com/joel-porquet/zsh-dircolors-solarized)
- [`tmux`](https://github.com/tmux/tmux) with Powerline theme.

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
