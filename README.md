# Matt's Dot Files

```shell
cd dotfiles
nix flake update # Update (every week or 2)
# REMEMBER TO GIT ADD NEW FILES
nixos-rebuild switch --sudo --flake . # Rebuild. Use `--flake ./#hostname` to specify a hostname
nh clean all # or `sudo nix-collect-garbage --delete-older-than 1d` to delete old system generations, and their store entries (only do this when you're certain your new generation is stable)
```

## Other Useful Commands

```bash
# Quickly find and try out a package
nix-search QUERY
nix-shell -p NEW_PACKAGE

# Experiment with Nix expressions (Tab completion is your friend)
nix repl ~/dotfiles

# Interactively change to another generation without rebooting
~/dotfiles/scripts/revert.sh

# Clean up docker residual
docker system prune --volumes --all

# Update firmwares
fwupdmgr refresh --force && fwupdmgr get-updates && fwupdmgr update

# Remote control android (no need for an app)
scrcpy --new-display=2560x1600/240 --stay-awake --keep-active --no-vd-destroy-content --keyboard=uhid --start-app=com.termux.nix

# Only needed after fresh install, automatically done on rebuild with `nix.settings.auto-optimise-store = true`
nix-store --optimise

# If you run out of space in `/boot`
r -c # Remove old generations
sudo rm -rf /boot/kernels # Clear space
r # Regenerate deleted kernels that are still needed
```

## Resources

[NixOS Package Search](https://search.nixos.org/packages?channel=unstable)
[Nüschtos Options Search](https://search.n%C3%BCschtos.de)
[Noogle Nix Function Search](https://noogle.dev/)
[JSON to Nix](https://json-to-nix.pages.dev/)
