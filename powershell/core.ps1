# optionally override the window title so it's not the full path to powershell.exe
# can make tabbed terminal UX nicer (Hyper, WindowsTerminal etc...)
[console]::title = "posh"

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# optionally set this to the username on your local machine
# to hide the user@host prompt for that username
$DefaultUser = "uczjc"

Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox

Import-Module DirColors