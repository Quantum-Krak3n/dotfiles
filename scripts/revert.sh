set -e # Exit on any errors
generation=$(nixos-rebuild list-generations | awk 'NR==1 { header=$0; next } 1' | fzf --header "$(nixos-rebuild list-generations | head -n1)" | awk '{print $1}')

if [ -z "$generation" ]; then
  echo -e "No generation selected"
  exit 1
fi

# if current generation is selected, do nothing
if [ "$(readlink /nix/var/nix/profiles/system)" = "system-$generation-link" ]; then
  echo -e "Selected generation is already active"
  exit 0
fi

sudo nix-env --switch-generation "$generation" -p /nix/var/nix/profiles/system
sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
