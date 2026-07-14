# dotfiles

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io/). Works on macOS, Linux, and Windows.

## What's included

- `bash` / `zsh` — shell config
- `git` — global config, ignore rules, attributes
- `vim` — editor config
- `nvim` (LazyVim-based) — deployed to `~/.config/nvim`
- `tmux` — terminal multiplexer config
- `gdb` — debugger config
- `editorconfig` — cross-editor formatting defaults
- `autohotkey` (Windows only) — remaps to make Windows keyboard shortcuts feel closer to macOS

## Quick start on a new machine

### macOS / Linux

Clone the repo into chezmoi's default source directory and run the install script:

```sh
git clone https://github.com/<your-github-username>/dotfiles.git ~/.local/share/chezmoi
cd ~/.local/share/chezmoi
./install.sh
```

`install.sh` installs chezmoi if it isn't already present, then applies every dotfile to your home directory. Because the repo lives at chezmoi's default source path, no `--source` flag or extra config is needed — `chezmoi update`, `chezmoi diff`, `chezmoi cd`, etc. all work out of the box afterward.

### Windows

Clone the repo into chezmoi's default source directory and run the install script from PowerShell:

```powershell
git clone https://github.com/<your-github-username>/dotfiles.git $HOME\.local\share\chezmoi
cd $HOME\.local\share\chezmoi
.\install.ps1
```

`install.ps1` installs chezmoi via winget if needed, then applies the dotfiles the same way. On first apply, a `run_onchange_before_` script installs AutoHotkey (via winget) if it isn't already present, and a `run_onchange_after_` script registers the keyboard-shortcut script to launch at login.

## Day-to-day usage

| Task | Command |
|---|---|
| Edit a dotfile and open it in `$EDITOR` | `chezmoi edit ~/.zshrc` |
| See what would change before applying | `chezmoi diff` |
| Apply pending changes to your home directory | `chezmoi apply` |
| Pull latest changes from git and apply them | `chezmoi update` |
| Add a new file to be managed | `chezmoi add ~/.some_config` |
| Add an entire directory | `chezmoi add -r ~/.config/some_tool` |
| Open the source directory in your shell | `chezmoi cd` |
| Re-import changes made directly to a deployed file | `chezmoi re-add` |

**Recommended workflow when editing:** use `chezmoi edit --apply <file>` to edit and immediately apply in one step, or just edit the deployed file directly and run `chezmoi re-add` afterward to sync the change back into the source directory before committing.

## Repo layout

This repo uses [`.chezmoiroot`](https://www.chezmoi.io/reference/configuration-file/#root) to keep non-dotfile content (this README, install scripts, Windows-only tools) separate from the actual dotfiles, which live under `home/`:

```
dotfiles/
├── .chezmoiroot          → points chezmoi at "home"
├── README.md
├── windows/
│   └── mac_shortcuts.ahk source, notes, etc.
└── home/                 ← chezmoi's source root, mirrors $HOME
    ├── .chezmoiversion   → minimum required chezmoi version
    ├── .chezmoiignore    → OS-specific exclusions
    ├── .chezmoiscripts/  → install/setup scripts
    ├── dot_bashrc
    ├── dot_zshrc
    ├── dot_gitconfig
    ├── dot_vimrc
    ├── dot_tmux.conf
    ├── dot_gdbinit
    ├── dot_editorconfig
    └── dot_config/
        ├── nvim/         → deployed to ~/.config/nvim
        └── autohotkey/   → Windows only, see .chezmoiignore
```

Naming conventions used throughout:

| Source prefix | Effect |
|---|---|
| `dot_` | Becomes `.` in the deployed path |
| `private_` | Deployed with restrictive permissions (mode 0600) |
| `executable_` | Deployed with the executable bit set |
| `run_once_` | Script runs once, first time it's encountered |
| `run_onchange_` | Script re-runs whenever its own content changes |
| `_before` / `_after` (in script names) | Controls whether a script runs before or after files are applied |

## Requirements

This repo pins a minimum chezmoi version via [`.chezmoiversion`](https://www.chezmoi.io/reference/source-state-attributes/#the-chezmoiversion-file). If your installed chezmoi is older than the pinned version, commands like `chezmoi apply` will refuse to run and tell you to upgrade, rather than failing on an unrecognized attribute or template function. `install.sh`/`install.ps1` install the latest chezmoi on a fresh machine, so this mainly guards against a pre-existing, outdated chezmoi already on `$PATH`.

## Templating

Some files use Go templating (`.tmpl` suffix) to vary by machine, keyed off built-in variables like `.chezmoi.os` (`darwin` / `linux` / `windows`) and `.chezmoi.arch`. See [chezmoi's template docs](https://www.chezmoi.io/user-guide/templating/) for the full syntax.

## Making changes

```sh
chezmoi cd              # jump into the source directory
# edit files as needed
git add -A
git commit -m "Update config"
git push
```

Then on any other machine:

```sh
chezmoi update
```

pulls the latest commit and applies it.
