# Matt's Dotfiles

## REMEMBER TO GIT ADD NEW FILES

```shell
cd dotfiles
nix flake update
nixos-rebuild switch --sudo --flake ./#hostname # Hostname can be blank to use current one
```