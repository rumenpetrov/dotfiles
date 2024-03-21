# dotfiles
My dot files and OS bootstrap automation scripts.

### Setup
* Clone the repository in your "Home" directory.
* Navigate to the "dotfiles/" folder.
* Make sure the script have sufficient permissions.
* Run the "start" script which is a wizard and combines all the defined tasks.

```sh
$ cd dotfiles/
$ chmod u+x start.sh
$ ./start.sh
```

### Folder structure

```text
├── files/ # The resources for all the tasks
├── scripts/ # Random standalone scripts
└── tasks/ # The scripts which are part of the main one
```

#### Tasks
* Backup dot files and replace them with symlinks to the custom files.
* Updates GNOME settings(dconf).
* Configures git.
* Setup tiling window manager (Sway).
