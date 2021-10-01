# PowerShell and PowerShell Core

To allow unelevated running of Windows Terminal for everyday use, I use posh as follows:

- PowerShell Core in Windows Terminal
  - with profile bits that Windows Terminal supports, like Powerline glyphs
- Regular PowerShell for elevated use
  - from the `WinKey + X` menu
  - simpler profile due to lack of font support / intended use

Since Windows 11 better integrates Windows Terminal, however, using PS Core in WT for elevated use is now viable, though having the default profile linked may still be useful in some scenarios.

# Files

| File | Symlink path |
| - | - |
| `default.ps1` | `$profile` (PowerShell) |
| `core.ps1` | `$profile` (PowerShell Core) |

# Dependencies

## Both

- [DirColors](https://github.com/DHowett/DirColors)
  - `Install-Module DirColors`

## Core

- [Oh My Posh!](https://ohmyposh.dev/docs/pwsh)
  - PoshGit - `Install-Module posh-git`
  - git (a local install, not embedded in a client like gitkraken)
    - `cinst git -y`
