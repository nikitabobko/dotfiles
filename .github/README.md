# Bobko Linux & macOS .dotfiles

The repo contains my configs for the CLI and some GUI apps. It's mostly CLI oriented environment

## Highlights

### ⭐ VIM as a default $EDITOR

I always thought that VIM is some sort of ancient software that people still use for some reason, but one day I read "Practical
VIM", and it changed everything. VIM is awesome. IMO, the best way to explore VIM by reading "Practical Vim" by Drew Neil.

- VIM isn't just a editor, it's entirely different paradigm. It's a concept that allows a more efficient text manipulations. If
  you do programming or a lot of writing, then VIM is a must learn
- VIM is so popular that its "hotkeys" are the only hotkeys you find supported in majority of software. You can stop learning a
  set of hotkeys for each software, and apply your knowledge of VIM hotkeys for:
  - [browsers](https://github.com/philc/vimium)
  - Other text editors and IDEs [IntelliJ IDEA](https://github.com/JetBrains/ideavim),
    [VS Code](https://github.com/vscode-neovim/vscode-neovim), [Xcode](https://developer.apple.com/forums/thread/681968) (Though
    XCode supports a limited set of keys), [Obsidian](https://obsidian.md/), etc
  - VIM mode for macOS - https://kindavim.app/ (Though I didn't try it)
- VIM "hotkeys" are OS independent. The only modifier that VIM uses is CTRL, which is hopefully is on the same place on the
  keyboard (bottom left corner) on all computer OS'es. All other operations are performed using only QWERTY, which is obviously
  the same on all OS'es. (Yes, macOS, I'm looking at you with your custom CMD and OPT modifiers)

### ⭐ grep shortcut for 90% of use cases

[`gp`](../.bin/gp) - Basically, it's a `grep --fixed-string --ignore-case` alias. But there are small tweaks.

- If you pipe something into `gp`, then it searched in stdin. Otherwise, it searches in text files in current dir recursively
- Searches for the plain text match, not regex (because it's what's needed in 90%)
- Ignores case by default (because it's what's needed in 90%)
- No need to put quotes around the search query. `gp search query` and `gp "search query"` are equivalent
- Uses `-n` to print line number by default. It's needed to make it possible to use `gp` in vim quickfix list

`gp` isn't a replacement for `grep` or [`rg`](https://github.com/BurntSushi/ripgrep). `gp` is a shortcut for `grep` functionality
which is needed in 90% you use `grep`. For more complicated search queries I still use plain old `grep`.

**Name explanation:** Original `grep` stands for vim `:global/regex/print` command. If you drop the middle "**RE**gex" part and
use plain text match then you will get `gp`.

### ⭐ Better clipboard CLI tool

[`cb`](../.bin/cb) - Stands for "**C**lip**B**oard"

- If you pipe something into `cb`, then it copies stdin into clipboard. If it's used without args and without stdin, it prints
  the current clipboard content.
- If the argument is passed then `cb` interprets it as a relative path, and copies its normalized path to the clipboard (because
  CLI is my main environment, and I often need to copy path from CLI into some GUI app)
- Linux and macOS are supported

### ⭐ dotfiles version control with pure git. No symlinks involved

[`d`](../.bin/d) - "d" because "**D**otfiles". `d` is just an alias for `git -c status.showUntrackedFiles=no
--git-dir=$HOME/.dotfiles --work-tree=$HOME "$@"`

