A Vim-like navigation script for AutoHotKey_L
====

Written by: Jongbin Jung (olorin86 at gmail dot com)

Created on December 15, 2012

# Introduction
Activate Vi Mode (Normal Mode) by double-tapping the Esc key.
Deactivate Vi Mode by pressing Esc key again.

Simple navigations (hjkl, wb) can be acheived using a Space + key combo.

# Commands
## regular movements
- hjkl: cursor movements
- w: move to next word
- b: move to previous word

- 0: go to beginning of line
- -: go to end of line (this is just how I use it personally in VIM)
- $: go to end of line (for general compatibility... :D)

# editting commands
- y: Copy
- d: Cut
- p: Paste
- u: undo (Ctrl+z)
    
... and more to come! ;)

# Change Logs
## 08/17/2014
- Changed ad-hoc navigation modifier to Space
- ad-hoc navigation works with all modifiers
- Changed hotkey for Vi-mode to double Esc (instead of Shift)
