# dotfiles

These are my dotfiles.

Some of them aren't proper dotfiles but are otherwise settings files I want to keep centrally.

Some of them have dependencies (beyond the app itself), and some day I'll probably have install scripts to setup a new machine from scratch with both dependencies and settings.

Each App folder should contain its own `README` covering the files included, dependencies and any Symlinking info (e.g. paths)

# Index

| Directory | App |
| - | - |
| `vscode/` | Visual Studio Code |
| `wt/` | Windows Terminal |

# Symlinking

While not necessary, it's nice to clone this repo and then symlink the dotfiles to their expected paths.

This is good because any updates to the files can be committed and pushed, rather than having to keep the repo in sync with the app's local version.

This may not work for all apps, but that should be noted in their `README`'s.

In future install scripts should handle symlinking.

## Windows (NTFS)

Prior to Windows 10, symlinking on NT6 requires admin (elevated) privileges.

On Windows 10 enabling [Developer mode](https://docs.microsoft.com/en-us/windows/uwp/get-started/enable-your-device-for-development) alleviates this requirement.

cmd: `mklink <link path> <source path>`
posh: `ni $link -it SymbolicLink -v $source`