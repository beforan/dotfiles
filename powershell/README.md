# PowerShell and PowerShell Core

To allow unelevated running of Windows Terminal for everyday use, I use posh as follows:

- PowerShell Core in Windows Terminal
  - with profile bits that Windows Terminal supports, like Powerline glyphs
- Regular PowerShell for elevated use
  - from the `WinKey + X` menu
  - simpler profile due to lack of font support / intended use

# Files

| File | Symlink path |
| - | - |
| `default.ps1` | `$profile` (PowerShell) |
| `core.ps1` | `$profile` (PowerShell Core) |

# Dependencies

## Both

- [DirColors](https://github.com/DHowett/DirColors)

## Core

- [Oh My Posh!](https://github.com/JanDeDobbeleer/oh-my-posh)
  - PoshGit

### Notes

Technically these depend on `PSReadLine` but that ships with PowerShell since `5.x`.