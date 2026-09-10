from pyinfra.operations import flatpak

flatpak.packages(
    name="Install Tidal",
    packages="com.mastermindzh.tidal-hifi",
)

flatpak.packages(
    name="Install Sioyek",
    packages="com.github.ahrm.sioyek",
)

flatpak.packages(
    name="Install Microsoft Teams",
    packages="com.github.IsmaelMartinez.teams_for_linux",
)

flatpak.packages(
    name="Install Signal",
    packages="org.signal.Signal",
)
