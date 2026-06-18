from pyinfra.context import host
from pyinfra.facts.server import Command
from pyinfra.operations import dnf, flatpak, server, systemd

# ==============================================================================
# Sunshine
# ==============================================================================

copr_list = host.get_fact(Command, "dnf copr list")
server.shell(
    name="Enable COPR lizardbyte/stable",
    commands=["yes | dnf copr enable lizardbyte/stable"],
    _sudo=True,
    _if=lambda: "lizardbyte/stable" not in copr_list,
)

dnf.packages(
    name="Install Sunshine",
    packages=["Sunshine"],
    latest=True,
    _sudo=True,
)

systemd.service(
    name="Enable `Sunshine` user service",
    service="app-dev.lizardbyte.app.Sunshine",
    running=True,
    enabled=True,
    user_mode=True,
)

flatpak.packages(
    name="Install Moonlight",
    packages="com.moonlight_stream.Moonlight",
)
