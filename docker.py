from pyinfra.context import host
from pyinfra.facts.server import Home, User
from pyinfra.operations import dnf, server, systemd

username = host.get_fact(User)
home = host.get_fact(Home)

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
