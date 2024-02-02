# Square-face Dotfiles
A collection of dotfiles that I have manually configured for my need.
Feel free to copy any settings if they seem interesting

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

### File
./ncspot.toml

### Symlink
`ln -s ./ncspot.toml ~/.config/ncspot/config.toml`

</details>

## Tmux

<details>
<summary>Installation</summary>
Installed using the operatings systems package manager.

</details>

<details>
    <summary>Configuration</summary>

### File
./tmux.conf

### Symlink
`ln -s ./tmux.conf ~/.config/tmux/tmux.conf`

### First time
Run `tmux` and hit the `<prefix>` followed by `I` (capital) to install all plugins and reload tmux 

</details>
