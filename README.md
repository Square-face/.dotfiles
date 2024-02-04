# Square-face Dotfiles
A collection of dotfiles that I have manually configured for my need.
Feel free to copy any settings if they seem interesting

If cloning this repo it is recommended to place it in home






## Rust
<details>
<summary>Installation</summary>
Rustup install script `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

</details>

<details>
    <summary>Dependencies</summary>
Some linux distros don't come preinstalled with all the required dependencies.
Here are some distros and the command required to install them

### Fedora
`sudo dnf install gcc`

</details>
Install good tools: `cargo install starship exa bat --locked`





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





## Kitty
<details>
<summary>Installation</summary>
Install using the operating systems package manager

</details>

<details>
    <summary>Dependencies</summary>

### Fonts
- Fira Code Nerd Font
    - Installed like any other system font

<details>
    <summary>Configuration</summary>

### Symlink
`ln -s ~/.dotfiles/kitty.conf ~/.config/kitty/kitty.conf`

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

### Post install
Run `tmux` and hit the `<prefix>` followed by `I` (capital) to install all plugins and reload tmux 

</details>





## Hyprland

<details>
<summary>Installation</summary>
Installed using the operating systems package manager.

</details>

<details>
    <summary>Configuration</summary>

### Symlink
`ln -s ~/.dotfiles/hyprland.conf ~/.config/hypr/hyprland.conf`

### Select Hyprland when logging in

</details>

