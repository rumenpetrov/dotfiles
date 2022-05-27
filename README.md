# OS bootstrap
Automation shell scripts.

### Setup
 - Clone the repo in you "Home" directory.
 - Navigate to os-bootstrap folder.
 - Make sure the script have sufficient permissions.
 - Run the script.
```sh
$ cd os-bootstrap/
$ chmod -x run.sh
$ ./run.sh
```

#### Tasks
- Backup dot files and replace them with symlinks to the custom files.
- Updates GNOME settings(dconf).
- Configures git.
- Setup window manager.
