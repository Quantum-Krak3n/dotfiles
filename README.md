# Matt's Dotfiles

## Rebuilding

```shell
cd dotfiles
nix flake update # Update (every week or 2)
# REMEMBER TO GIT ADD NEW FILES
nixos-rebuild switch --sudo --flake ./#hostname # Rebuild. Hostname can be blank to use current one
```

## Resources

[Options Search](https://search.nüschtos.de/)
[Package Search](https://search.nixos.org/packages)

To quickly try a package: `nix-shell -p NEW_PACKAGE`
