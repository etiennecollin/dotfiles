# Requirements

## Packages

### Arch Linux

-   `yay -Syu ripgrep zathura xdotool`

> `ripgrep` is required for telescope word finding

> `zathura` and `xdotools` are required by `vimtex`

### macOS

-   `brew install ripgrep skim`

> `ripgrep` is required for telescope word finding.

> `skim` is required by `vimtex` for tex file preview.

## Python

-   conda/pip install neovim

# Setup

-   Go to packer's github page to check installation process:

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

-   Run inside of nvim `:PackerSync`
