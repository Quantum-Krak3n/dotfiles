# Matt's Dotfiles

## Rebuilding

```shell
cd dotfiles
nix flake update # Update (every week or 2)
# REMEMBER TO GIT ADD NEW FILES
nixos-rebuild switch --sudo --flake ./#hostname # Rebuild. Hostname can be blank to use current one
sudo nix-collect-garbage --delete-older-than 1d # Delete old system generations, and their store entries (only do this when you're certain your new generation is stable)

nix-store --optimise # Only needed after fresh install, automatically done on rebuild with `nix.settings.auto-optimise-store = true`
```

## Resources

[Options Search](https://search.nüschtos.de/)
[Package Search](https://search.nixos.org/packages)

To quickly try a package: `nix-shell -p NEW_PACKAGE`
