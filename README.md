# 🔱 Maruti-Zsh

> **Maruti** (noun): Another name for Hanuman, the ancient Indian deity of the wind—celebrated for his unmatched speed, agility, and immense strength hidden within a modest form.

`maruti-zsh` is a high-performance, ultra-lightweight, and modular shell configuration engine built entirely on native Zsh internals. Born out of necessity to bring a modern, blazing-fast developer workflow to a repurposed 2010 Gateway server running Debian 13, this setup replaces heavy, opaque frameworks like Oh-My-Zsh with clean, human-readable shell scripts.

## 🌟 The Philosophy

Modern CLI tools have become bloated, adding seconds of latency to your terminal startup times. `maruti-zsh` returns to the roots of shell scripting: **speed, transparency, and modularity.** 

Every feature in this repository—from the custom keyboard widgets to the alias profiles—runs natively without external package dependencies. If you want a terminal that awakens instantly like the wind, you're in the right place.

## 🚀 Key Features At A Glance

*   **Zero-Framework Latency:** Instant terminal execution, optimized for aging server hardware and production environments.
*   **Intelligent Modular Sourcing:** A single-line recursive loader that safely maps your custom scripts across multiple nested subdirectories without risk of circular loops.
*   **The Sudo Toggle (`Alt+S`):** Instantly toggle `sudo` at the front of your active line buffer or pull the last command from history to elevate it.
*   **Smart Clear (`Ctrl+K`):** Clears the screen buffer and automatically renders a localized directory map (`ls -pG`), keeping your workspace immaculate.
*   **Inline Search Pipes (`Alt+G`):** Append an automated `| grep ` fragment to your cursor path on the fly.
