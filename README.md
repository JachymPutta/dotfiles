# Personal Dev Config
This is a repository to set up my personal development environment it includes nice things like:
- [Nix](https://nixos.org/) as the package manager
- [NeoVim](https://www.neovim.io/) as the text editor
- [Yazi](https://www.yazi-rs.github.io/) terminal file manager
- [Zsh](https://www.zsh.org/) as the shell
- [Oh My Zsh](https://ohmyz.sh/) as the Zsh configuration manager
- [Atuin](https:https://atuin.sh/) to synchronize shell history across multiple machines
- [Typst](https://typst.app/) for typesetting documents (LaTeX alternative)
- *Ghostty* as the terminal emulator (in closed beta right now 🤫 will have to be commmented out without access)


## Install
1. Get Nix
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
2. Run the setup script
    - On Linux: uncomment the `#homeDirectory = "/home/username";`
    ```sh
    update
    ```
    - On MacOS
    ```sh
    ./darwin.sh
    ```

## Project Structure
```plaintext
.
├── extras/
├── nix/
├── .gitignore
├── darwin.sh
├── flake.lock
├── flake.nix
└── home.nix
```
- `./nix` contains per-package configuration in nix
- `./extras` contains extra configuration files the programs might need
    - For example: `./extras/nvim` contains the configuration for NeoVim in lua


## Using this configuration
```
NOTE: This configuration is specific to my environment and will likely not work out of the box
```
If you want to use this configuration, you can fork this repository and make the following changes:
- Replace any occurences of:
    - My name (Jachym | Putta ) or any combination in:
        - `flake.nix`
        - `darwin.sh`
        - `home.nix`
        - `./nix/darwin.nix`
        - `./nix/git.nix`
        - `./nix/zsh.nix`
    - My machine name in `./darwin.sh` and `./flake.nix`
    - My email in `./nix/git.nix`
- (Optional) If you don't have access to Ghostty, comment out the `ghostty` package in `./flake.nix` and `./home.nix`
- Adapt the keybindings in `./extras/nvim/core/mappings.lua` to your liking


