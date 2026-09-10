from pyinfra.context import host
from pyinfra.facts.server import Command, User
from pyinfra.operations import cargo, dnf, flatpak, server

username = host.get_fact(User)

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
        "clang-devel",
        "elfutils",
        "elfutils-debuginfod",
        "fastfetch",
        "ffmpeg-free",
        "ffmpegthumbnailer",
        "fzf",
        "gcc",
        "gdb",
        "gdb-gdbserver",
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
        "tio",
        "ufw",
        "wireguard-tools",
        "wireshark-cli",
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
        "krita",
        "vlc",
        "wireshark",
    ],
    latest=True,
    _sudo=True,
)

dnf.packages(
    name="Install Zellij dependencies",
    packages=[
        "perl-core",
    ],
    latest=True,
    _sudo=True,
)

dnf.packages(
    name="Install yazi dependencies",
    packages=[
        "file",
        "ffmpeg-free",
        "ffmpegthubnailer",
        "7zip",
        "jq",
        "poppler",
        "fd-find",
        "ripgrep",
        "fzf",
        "zoxide",
        "resvg",
        "imagemagick",
        "wl-clipboard",
    ],
    latest=True,
    _sudo=True,
)

dnf.packages(
    name="Install Silicon dependencies",
    packages=[
        "cmake",
        "expat-devel",
        "fontconfig-devel",
        "libxcb-devel",
        "freetype-devel",
        "libxml2-devel",
        "harfbuzz",
    ],
    latest=True,
    _sudo=True,
)

dnf.packages(
    name="Install cargo-update dependencies",
    packages=[
        "libcurl-devel",
        "libgit2-devel",
        "libsecret",
        "libssh2-devel",
        "openssl-devel",
        "pkgconf",
    ],
    latest=True,
    _sudo=True,
)

cargo.packages(
    name="Install cargo packages",
    packages=[
        "bottom",
        "cargo-update",
        "eza",
        "silicon",
        "tlrc",
        "yazi-build",
        "zellij",
    ],
    latest=True,
)

server.shell(
    name="Update all cargo-installed packages",
    commands=[f"cargo install-update -a"],
    _sudo=True,
)

server.shell(
    name="Set defaul shell to zsh",
    commands=[f"chsh -s $(which zsh) {username}"],
    _sudo=True,
)

# ==============================================================================
# Flatpaks
# ==============================================================================

flatpak.packages(
    name="Install localsend",
    packages="org.localsend.localsend_app",
)

flatpak.packages(
    name="Install draw.io",
    packages="com.jgraph.drawio.desktop",
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
    commands=["go install github.com/jesseduffield/lazygit@latest"],
)

server.shell(
    name="Install lazydocker",
    commands=["go install github.com/jesseduffield/lazydocker@latest"],
)

# ==============================================================================
# Wireshark user group
# ==============================================================================

server.shell(
    name="Add current user to the wireshark group",
    commands=[
        "groupadd wireshark || true",
        f"usermod -aG wireshark {username}",
    ],
    _sudo=True,
)
