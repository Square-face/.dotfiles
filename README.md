# Square-face Dotfiles
A collection of dotfiles that I have manually configured for my need.
Feel free to copy any settings if they seem interesting

If cloning this repo it is recommended to place it in home

## ZSH

<details>
<summary>Installation</summary>
Install using the operating systems package manager

</details>

<details>
    <summary>Configuration</summary>

### Set as shell
run `chsh -s $(which zsh)`

### Symlink
`ln -s ~/.dotfiles/zshrc ~/.zshrc`

</details>


## ncspot

<details>
<summary>Installation</summary>

### Cargo
```
cargo install ncspot --features cover
```

</details>

<details>
    <summary>Configuration</summary>

### Symlink
`ln -s ./ncspot.toml ~/.config/ncspot/config.toml`

</details>

## Tmux

<details>
<summary>Installation</summary>
Installed using the operating systems package manager.

</details>

<details>
    <summary>Configuration</summary>

### Symlink
`ln -s ./tmux.conf ~/.config/tmux/tmux.conf`

### First time
Run `tmux` and hit the `<prefix>` followed by `I` (capital) to install all plugins and reload tmux 

</details>

## Starship

<details>
<summary>Installation</summary>
Installed using the operating systems package manager.

</details>

<details>
    <summary>Configuration</summary>

### Environment variable
add `export STARSHIP_CONFIG=~/.dotfiles/starship.toml` to your .zshrc/.bashrc file (set by default in `./zshrc`).

If necessary, replace the path to the actual path to `./starship.toml`

</details>
