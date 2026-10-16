{ ... }:

{
  imports = [ ];

  programs.bash = {
    shellAliases = {
      ls = "ls -Fh --color=auto";
      ll = "ls -l";
      la = "ls -lA";
      l = "ls -C";

      g = "git";

      # -r            Recurse into directories
      # -l            Copy simlinks as simlinks
      # -gopE         Preserve group, owner, permissions, executability
      # -P            Keep partialy transferred files, and show progress
      # -h            Human readable numbers
      # --mkpath      Create all missing path components to destination
      # --info        What to log:
      #   PROGRESS2   Total ongoing transfer progress
      #   STATS3      Statistics at the end of the run
      #   SKIP2       Skipped files as they are skipped
      rsync = "rsync -rlgopEPh --mkpath --info=PROGRESS2,STATS3";
      # -e  Do not use a remote shell program (for local copy)
      # -b  Make backups in --backup-dir
      rcp = ''rsync -e /dev/null -b --backup-dir="/tmp/rsync-$USERNAME"'';

      df = "df -xtmpfs -xefivarfs -xdevtmpfs -hT";
      du = "du -h --summarize";
      nix-shell = "nix-shell --log-format bar-with-logs";
      grep = "grep --color=auto";
      mkdir = "mkdir -p"; # Make parents
    };
  };
}
