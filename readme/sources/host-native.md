# Stuff I install natively

Note that this is VERY host dependent.

- Some Hosts may come with stuff pre-installed e.g.
  - Bazzite -> preinstalls Steam, Ptyxis, Brew etc.
  - macOS -> preinstalls git
- Some Hosts may support more or less stuff via Nix
- On all Hosts it *could* be a direct download (installer or `/opt`), otherwise:
  - macOS -> App Store
  - Atomic Fedora -> `rpm-ostree`
  - Fedora -> `dnf` / Discover
  - Ubuntu -> `apt` / snaps

etc.

# System tools

- Python (+ pip + pipx)
  - Python and Nix is potentially weird and annoying, so sadly we don't have a nice declarative way to do this
  - Install Python3 the recommended native way
    - your OS may come with it!
  - Install pip the recommended native way
    - your OS may come with it
    - if in doubt `python -m ensure-pip --upgrade`
  - Install pipx the recommended native way
  - or consider sacking off all the above and just using [uv](https://docs.astral.sh/uv/)
- Docker
  - For Linux, often comes with distros, otherwise install it "the normal way"
  - For NixOS, install via Nix configuration
  - For macOS, install "the normal way"

# Command Line Tools

- Homebrew, on macOS

## Anaconda

Anaconda doesn't play nice with Nix.

Hopefully for typical Python dev Nix + Poetry works for me, possibly in per-project Flakes. But sometimes I need Anaconda.

Since Anaconda is itself an isolated userspace tool, it's not so bad. Install it natively.

Some advice:

- install it to `$HOME/opt/conda` rather than the default
  - this works with zsh aliases and stuff in these dotfiles, and doesn't care if you use Anaconda Distribution or Miniconda
- Don't add it to `$PATH` or otherwise do any Shell Initialization (e.g. `conda init`)
  - instead use the `conda-activate` zsh alias in these dotfiles to activate the `(base)` environment and then go from there.

### Miniconda gotchas

- Jupyter Notebooks
  - Miniconda doesn't install this by default like Anaconda Distribution. Just do `conda install jupyter`

# GUI Apps

- Browsers:
  - Edge for macOS.
    - For Linux: Flatpak
- VS Code (if not Flatpak, then native)
