from pyinfra.context import host
from pyinfra.facts.files import File
from pyinfra.facts.server import Command, Home, User
from pyinfra.operations import cargo, dnf, flatpak, git, npm, server, systemd

username = host.get_fact(User)
home = host.get_fact(Home)

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
