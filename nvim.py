from pyinfra.operations import cargo, dnf, npm

# ==============================================================================
# Neovim
# ==============================================================================

dnf.packages(
    name="Install neovim system dependencies",
    packages=[
        "ImageMagick",
        "chafa",
        "curl",
        "fd-find",
        "git",
        "grep",
        "gzip",
        "luarocks",
        "make",
        "nodejs",
        "python3-neovim",
        "ripgrep",
        "tar",
        "tree-sitter-cli",
        "unzip",
        "wget",
    ],
    latest=True,
    _sudo=True,
)

cargo.packages(
    name="Install neovim cargo dependencies",
    packages=[
        "ast-grep",
        "ripgrep_all",
        "tree-sitter-cli",
    ],
    latest=True,
)

npm.packages(
    name="Install neovim node dependencies",
    packages=["@mermaid-js/mermaid-cli", "neovim"],
    latest=True,
    _sudo=True,
)

dnf.packages(
    name="Install neovim",
    packages=["neovim"],
    latest=True,
    _sudo=True,
)

# git.repo(
#     name="Clone neovim config",
#     src="https://github.com/etiennecollin/nvim",
#     dest=f"{home}/.config/nvim",
# )
