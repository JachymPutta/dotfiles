# Personal Dev Config
This is a repository to set up my personal development environment it includes nice things like:
- [Nix](https://nixos.org/) as the package manager
- [NeoVim](https://www.neovim.io/) as the text editor
- [Yazi](https://www.yazi-rs.github.io/) terminal file manager
- [Zsh](https://www.zsh.org/) as the shell
- [Atuin](https:https://atuin.sh/) to synchronize shell history across multiple machines


## Install
1. Get Nix
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
2. Install Home manager
Instructions [here](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone)

Base installation (master branch):
```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

3. Run the setup script
    - On Linux: uncomment the `#homeDirectory = "/home/username";`
    - (First time)
    ```sh
    home-manager switch --flake .#jachym -L
    ```
    - (After the first time)
    ```sh
    update
    ```
    - On MacOS
    - (First time)
    ```sh
    nix run nix-darwin -- switch --flake ~/dotfiles
    ```
    - (After the first time)
    ```sh
    darwin
    ```
## Common issues
- `unknown-terminal ghostty-xterm` - terminfo needs to be updated follow [here](https://github.com/ghostty-org/ghostty?tab=readme-ov-file#terminfo)

  For ssh, run this on the host:
  ```sh
  infocmp -x | ssh YOUR-SERVER -- tic -x -
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


