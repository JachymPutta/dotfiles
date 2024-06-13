sudo nix build  --extra-experimental-features flakes --extra-experimental-features nix-command .#darwinConfigurations.Jachyms-MacBook-Pro.system --show-trace -L || exit 1 # --show-trace
sudo ./result/activate || exit 1
