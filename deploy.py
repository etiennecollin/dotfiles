from pyinfra.context import host
from pyinfra.facts.files import File
from pyinfra.facts.server import Command, Home, User
from pyinfra.operations import cargo, dnf, flatpak, git, npm, server, systemd

username = host.get_fact(User)
home = host.get_fact(Home)

# ==============================================================================
# System dependencies
# ==============================================================================

dnf.packages(
    name="Update and clean packages",
    update=True,
    clean=True,
    _sudo=True,
)

server.shell(
    name="Install development tools group",
    commands=["dnf -y group install development-tools virtualization"],
    _sudo=True,
)

dnf.packages(
    name="Install system dependencies",
    packages=[
        "7zip",
        "bat",
        "btop",
        "cmake",
        "elfutils",
        "elfutils-debuginfod",
        "fastfetch",
        "ffmpeg-free",
        "ffmpegthumbnailer",
        "fzf",
        "gcc",
        "gdb",
        "gdb-gdbserver",
        "gh",
        "git-delta",
        "git-lfs",
        "golang-bin",
        "iperf3",
        "jq",
        "just",
        "nmap",
        "oh-my-posh",
        "openssh",
        "openssh-clients",
        "openssh-server",
        "openssl",
        "pandoc",
        "rclone",
        "rsync",
        "sed",
        "socat",
        "strace",
        "tcpdump",
        "ufw",
        "wireguard-tools",
        "zip",
        "zoxide",
        "zsh",
    ],
    latest=True,
    _sudo=True,
)

dnf.packages(
    name="Install GUI software",
    packages=[
        "celluloid",
        "chromium",
        "easyeffects",
        "vlc",
        "wireshark",
    ],
    latest=True,
    _sudo=True,
)

dnf.packages(
    name="Install Zellij dependencies",
    packages=[
        "perl-IPC-Cmd",
        "perl-FindBin",
    ],
    latest=True,
    _sudo=True,
)

cargo.packages(
    name="Install cargo packages",
    packages=["bottom", "tlrc", "yazi-build", "eza", "cargo-update", "zellij"],
    latest=True,
)

server.shell(
    name="Set defaul shell to zsh",
    commands=[f"chsh -s $(which zsh) {username}"],
    _sudo=True,
)

# ==============================================================================
# Docker
# ==============================================================================

dnf.packages(
    name="Uninstall old Docker packages",
    packages=[
        "docker",
        "docker-client",
        "docker-client-latest",
        "docker-common",
        "docker-latest",
        "docker-latest-logrotate",
        "docker-logrotate",
        "docker-selinux",
        "docker-engine-selinux",
        "docker-engine",
    ],
    present=False,
    _sudo=True,
)

dnf.repo(
    name="Install Docker rpm repository",
    src="https://download.docker.com/linux/fedora/docker-ce.repo",
    _sudo=True,
)

dnf.packages(
    name="Install Docker packages",
    packages=[
        "docker-ce",
        "docker-ce-cli",
        "containerd.io",
        "docker-buildx-plugin",
        "docker-compose-plugin",
    ],
    latest=True,
    _sudo=True,
)

systemd.service(
    name="Enable `docker` service",
    service="docker",
    running=True,
    enabled=True,
    _sudo=True,
)

systemd.service(
    name="Enable `containerd` service",
    service="containerd",
    running=True,
    enabled=True,
    _sudo=True,
)

server.shell(
    name="Add current user to the docker group",
    commands=[
        "groupadd docker || true",
        f"usermod -aG docker {username}",
        f'chown "{username}":"{username}" /home/{username}/.docker -R || true',
        f'chmod g+rwx "{home}/.docker" -R || true',
    ],
    _sudo=True,
)

# ==============================================================================
# Hashicorp Vault
# ==============================================================================

hashicorp_repo_exists = host.get_fact(File, "/etc/yum.repos.d/hashicorp.repo")

server.shell(
    name="Install Hashicorp Vault repo via URL",
    commands=[
        "wget -O- https://rpm.releases.hashicorp.com/fedora/hashicorp.repo | tee /etc/yum.repos.d/hashicorp.repo"
    ],
    _sudo=True,
    _if=lambda: hashicorp_repo_exists is not None and hashicorp_repo_exists != False,
)

dnf.packages(
    name="Install Hashicorp Vault",
    packages=["vault"],
    latest=True,
    _sudo=True,
)

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
    packages=["tree-sitter-cli", "ast-grep", "ripgrep_all"],
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

# ==============================================================================
# Flatpaks
# ==============================================================================

flatpak.packages(
    name="Install localsend",
    packages="org.localsend.localsend_app",
)

flatpak.packages(
    name="Install Tidal",
    packages="com.mastermindzh.tidal-hifi",
)

flatpak.packages(
    name="Install Microsoft Teams",
    packages="com.github.IsmaelMartinez.teams_for_linux",
)

flatpak.packages(
    name="Install Sioyek",
    packages="com.github.ahrm.sioyek",
)

flatpak.packages(
    name="Install Zen Browser",
    packages="app.zen_browser.zen",
)

# ==============================================================================
# Ghostty
# ==============================================================================

copr_list = host.get_fact(Command, "dnf copr list")
server.shell(
    name="Enable COPR scottames/ghostty",
    commands=["yes | dnf copr enable scottames/ghostty"],
    _sudo=True,
    _if=lambda: "scottames/ghostty" not in copr_list,
)

dnf.packages(
    name="Install ghostty",
    packages=["ghostty"],
    latest=True,
    _sudo=True,
)

# ==============================================================================
# Go packages
# ==============================================================================

server.shell(
    name="Install lazygit",
    commands=[
        "go install github.com/jesseduffield/lazygit@latest",
    ],
)

server.shell(
    name="Install lazydocker",
    commands=[
        "go install github.com/jesseduffield/lazydocker@latest",
    ],
)
