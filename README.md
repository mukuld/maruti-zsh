# 🔱 Maruti-Zsh

> **Maruti** (noun): Another name for Hanuman, the ancient Indian deity of the wind—celebrated for his unmatched speed, agility, and immense strength hidden within a modest form.

`maruti-zsh` is a high-performance, ultra-lightweight, and modular shell configuration engine built entirely on native Zsh internals. Born out of necessity to bring a modern, blazing-fast developer workflow to a repurposed 2010 Gateway server running Debian 13, this setup replaces heavy, opaque frameworks like Oh-My-Zsh with clean, human-readable shell scripts.

## 🌟 The Philosophy

Modern CLI tools have become bloated, adding seconds of latency to your terminal startup times. `maruti-zsh` returns to the roots of shell scripting: **speed, transparency, and modularity.**

## 📋 Prerequisites

Before running the installation script, ensure you have the following components installed on your machine:

1. **Zsh** (Required)
   * Debian/Ubuntu: `sudo apt install zsh`
   * Fedora/RHEL: `sudo dnf install zsh`
   * Arch Linux: `sudo pacman -S zsh`
   * macOS: Included natively (or `brew install zsh`)

2. **Git** (Required for cloning plugins and dependencies)

3. **Powerlevel10k** (Handled automatically by the installer)
   The install script will clone [Powerlevel10k](https://github.com/romkatv/powerlevel10k) into `~/powerlevel10k` if it isn't already present. After installation, run `p10k configure` to set up your prompt style, or place your existing `~/.p10k.zsh` file before sourcing `~/.zshrc`.

4. **Nerd Fonts** (Recommended)
   Powerlevel10k renders best with a Nerd Font. The installer ships with **FiraCode Nerd Font** and **MesloLGS NF** and will install them automatically to the appropriate font directory for your OS. Configure your terminal emulator to use one of these fonts after installation.

The following plugins are also cloned automatically by the installer — no manual steps required:

* [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) — Fish-style inline command suggestions
* [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) — Real-time syntax coloring as you type

## 🚀 Key Features At A Glance

* **Zero-Framework Latency:** Instant terminal execution, optimized for aging server hardware and production environments.
* **Intelligent Modular Sourcing:** A single-line glob loader that safely sources all `.zsh` scripts from `~/.maruti-zsh/.zsh/`, keeping your configuration organized and easy to extend.
* **OS-Aware Behavior:** Automatically adapts `ls` color flags and font installation paths for macOS and Linux.
* **The Sudo Toggle (`Alt+S`):** Instantly toggle `sudo` at the front of your active command line, or pull the last command from history to elevate it.
* **Smart Clear (`Ctrl+K`):** Clears the screen buffer and automatically renders a directory listing, keeping your workspace oriented. Uses `-G` on macOS and `--color=auto` on Linux.
* **Inline Search Pipes (`Alt+G`):** Append `| grep ` to your current command on the fly.
* **Edit in `$EDITOR` (`Ctrl+O`):** Open the current command buffer in your full editor when a one-liner gets unwieldy.

## ⌨️ Keybinding Reference

### Navigation

| Binding | Action |
|---|---|
| `Alt + ←` | Move backward one word |
| `Alt + →` | Move forward one word |
| `Ctrl+A` | Jump to beginning of line |
| `Ctrl+E` | Jump to end of line |
| `↑` / `↓` | History search by prefix (type a partial command first) |
| `Alt+.` | Insert last argument from previous command |

### Editing

| Binding | Action |
|---|---|
| `Ctrl+Backspace` | Delete previous word |
| `Ctrl+Delete` | Delete next word |
| `Ctrl+U` | Clear entire command buffer |
| `Ctrl+L` | Kill from cursor to end of line |
| `Alt+S` | Toggle `sudo` at the start of the current line |
| `Alt+G` | Append `\| grep ` to the current command |

### System & Tools

| Binding | Action |
|---|---|
| `Ctrl+K` | Clear screen + show directory listing |
| `Ctrl+O` | Open current command in `$EDITOR` |
| `Ctrl+X N` | Jump to `/etc/nginx/sites-available/` |
| `Ctrl+X W` | Jump to `/var/www/html/` |

## 📁 Project Structure

```
maruti-zsh/
├── .zsh/
│   ├── key-bindings.zsh   # Custom ZLE widgets and keybindings
│   ├── zsh-aliases.zsh    # Alias definitions
│   └── zsh-history.zsh    # History configuration and options
├── fonts/                 # Bundled Nerd Fonts (FiraCode, MesloLGS NF)
├── install.sh             # Automated installer
├── uninstall.sh           # Clean removal script
└── zshrc                  # Base Zsh configuration
```

## 🛠 Installation

```bash
git clone https://github.com/mukuld/maruti-zsh.git
cd maruti-zsh
chmod +x install.sh
./install.sh
```

Then either restart your terminal or run:

```bash
source ~/.zshrc
```

## 🧹 Uninstallation

```bash
cd maruti-zsh
chmod +x uninstall.sh
./uninstall.sh
```

## ➕ Extending Maruti-Zsh

The modular loader sources every `.zsh` file inside `~/.maruti-zsh/.zsh/` automatically. To add your own customizations, simply drop a new `.zsh` file in that directory:

```bash
# Example: add your own aliases
nano ~/.maruti-zsh/.zsh/my-aliases.zsh
```

No edits to `zshrc` required — the file will be picked up on the next shell start.

## 📄 License

MIT — see [LICENSE](LICENSE) for details.