#!/usr/bin/env sh

########################################################################################################################
# Oh-my-zsh
########################################################################################################################

echo "Setting up oh-my-zsh..."
if [ ! -x $(command -v omz) ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh-my-zsh already installed. Skipping..."
fi

########################################################################################################################
# Powerlevel10k
########################################################################################################################

echo "Setting up Powerlevel10k..."
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k >/dev/null
else
    echo "Powerlevel10k already installed. Skipping..."
fi

exit 0