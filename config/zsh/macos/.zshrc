# Launch Programs
fastfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

################################################################################
# Aliases
################################################################################
alias ls="ls --color=auto"
alias la="ls -a --color=auto"
alias less="less -R"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias a="zellij attach --create main"
alias z="zellij options --serialize-pane-viewport false --session-serialization false"
alias o="custom-open"
alias imgcat="wezterm imgcat"
alias rm="trash"
alias sshp="ssh -L 8080:localhost:8080 -L 11434:localhost:11434 -L 8888:localhost:8888"

alias jekyll="bundle exec jekyll serve --livereload"
alias leptosfmt="leptosfmt -m 120 src/**/*.rs"
alias tserve="trunk serve --open"
alias typstw="typst watch --root ~ --open sioyek"
alias typstc="typst compile --root ~"
alias pytypstw="python -m typst_pyimage -w -a \"--root ~ --open sioyek\""

alias format="python /Users/etiennecollin/github/gist/file_system_formatter.py"
alias office2pdf="/Users/etiennecollin/github/gist/office_to_pdf.sh"
alias uni="cd ~/Desktop/university/semester-4/"

################################################################################
# Plugins and completions
################################################################################
# Download Zinit, if it's not there yet
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ ! -f ~/.p10k.zsh ] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

################################################################################
# Custom GPG functions
################################################################################
function secret { # list preferred id last
	output="$(dirname ${1})/$(basename ${1}).$(date +%F).asc"
	recipients=${2:-collin.etienne.contact@gmail.com}

	gpg --encrypt --armor --output ${output} -r "${recipients}" "${1}" &&
		echo "$(basename "${1}") -> $(basename "${1}").$(date +%F).asc"
}

function secret-sign { # list preferred id last
	output="$(dirname ${1})/$(basename ${1}).$(date +%F).asc"
	recipients=${2:-collin.etienne.contact@gmail.com}

	gpg --sign --encrypt --armor --output ${output} -r "${recipients}" "${1}" &&
		echo "$(basename "${1}") -> $(basename "${1}").$(date +%F).asc"
}

function reveal {
	output=$(echo "${1}" | rev | cut -c16- | rev)

	gpg --decrypt --output ${output} "${1}" &&
		echo "$(basename "${1}") -> $(basename "${output}")"
}

function create-env {
	# Check that number of arguments is 1
	if [ $# -ne 2 ]; then
		echo "Please input the name of your environment and the python version to use as the arguments."
		return 1
	fi

	# Store the name as a variable
	name=$1
	py_version=$2

	echo "Creating environment the environment \"$name\" will overwrite any other environment with the same name"
	echo "Are you sure you want to create the environment \"$name\" (y/n)?"
	read choice
	if [ "$choice" = "y" ]; then
		echo "Starting creation"
	elif [ "$choice" = "n" ]; then
		echo "Aborting"
		return 0
	else
		echo "Invalid selection"
		return 1
	fi

	# Create the environment
	conda create -q -y -n $name python=$py_version pip ipykernel &>/dev/null &&
		echo "Created environment \"$name\"" || {
		echo "Environment creation failed"
		return 1
	}

	# Activate the environment
	conda activate $name &>/dev/null &&
		echo "Activated environment \"$name\"" || {
		echo "Environment activation failed"
		return 1
	}

	# Create the ipykernel
	python -m ipykernel install --user --name $name &>/dev/null &&
		echo "Created ipykernel \"$name\"" || {
		echo "ipykernel creation failed"
		return 1
	}
}

function remove-env {
	# Check that number of arguments is 1
	if [ $# -ne 1 ]; then
		echo "Please input the name of your environment as the argument."
		return 1
	fi

	# Store the name as a variable
	name=$1

	echo "Are you sure you want to delete this environment (y/n)?"
	read choice
	if [ "$choice" = "y" ]; then
		echo "Starting removeal"
	elif [ "$choice" = "n" ]; then
		echo "Aborting"
		return 0
	else
		echo "Invalid selection"
		return 1
	fi

	# Uninstall the ipykernel
	jupyter kernelspec uninstall -y $name &>/dev/null &&
		echo "Remove ipykernel \"$name\"" || {
		echo "ipykernel \"$name\" deletion failed"
		return 1
	}

	# Remove the environment
	conda remove -q -y -n $name --all &>/dev/null &&
		echo "Removed environment \"$name\"" || {
		echo "Environment removal failed"
		return 1
	}
}

function rcd {
	# Check that number of arguments ie 1
	if [ $# -ne 1 ]; then
		echo "Please input the path to a directory as the argument."
		return 1
	fi

	# Store the given path as a variable
	dirpath=$1

	# Check that the path is a directory
	if [ ! -d $dirpath ]; then
		echo "Please input the path to a directory as the argument."
		return 1
	fi

	# While $dirpath contains a single item...
	while [ $(ls $dirpath | wc -l) -eq 1 ]; do
		# If the item in the directory is also a directory
		if [ -d "$dirpath/$(ls $dirpath)" ]; then
			# Add it to the path to cd into
			dirpath=$dirpath/$(ls $dirpath)
		else
			break
		fi
	done

	# cd into the directories
	cd $dirpath
}

function custom-open {
	input_paths="$@"

	# Check that number of arguments is 1
	if [ -z "$input_paths" ]; then
		open .
		return 1
	fi

	# Open each path
	for input_path in $input_paths; do
		# Get the basename and extension of the file
		full_name="$(basename $input_path)"
		extension="${full_name##*.}"

		# Check that the path exists
		if [ ! -e "$input_path" ]; then
			echo "$full_name does not exist"
			continue
		fi

		if [ "$extension" = "pdf" ] && [ $(command -v "sioyek") ] &>/dev/null; then
			sioyek "$input_path" &>/dev/null &
		else
			open "$input_path"
		fi
	done

}

function wdiff {
	input=$1
	output=$2

	# Check that the paths is a file
	if [ ! -f $input ]; then
		echo "Please input the path to a file as the first argument."
		return 1
	elif [ ! -f $output ]; then
		echo "Please input the path to a file as the second argument."
		return 1
	fi

	git diff -U$(wc -l $input | awk "{print $1}") --word-diff --no-index --no-prefix --color -- $input $output | grep -v ^@@ | less -R

}

function cleaks {
	# Get arguments
	files="$@"

	# Check that there are arguments
	if [ -z "$files" ]; then
		echo "Please input the .c files as arguments."
		echo "The first argument should be the main file."
		return 1
	fi

	# Verify that all the arguments are files with a .c extension
	for file in $files; do
		if [ ! -f "$file" ] || [ "${file##*.}" != "c" ]; then
			echo "Please only input existing files with a .c extension."
			return 1
		fi
	done

	# Create the output directory if it does not exist
	mkdir -p analysis

	# Get the basename of the first file
	filename="$(basename $1)"
	filename="${filename%.*}"

	# Compile the .c files
	clang -Wall -O0 -g -o "analysis/$filename" $files &>analysis/leaks_output.txt
	cd analysis

	# Make the process debuggable
	# Check if the tmp.entitlements file exists
	if [ ! -f "tmp.entitlements" ]; then
		/usr/libexec/PlistBuddy -c "Add :com.apple.security.get-task-allow bool true" tmp.entitlements &>/dev/null
	fi
	codesign -s - --entitlements tmp.entitlements -f "$filename" &>/dev/null

	# Start malloc logging
	export MallocStackLogging=1
	export MallocScribble=1

	# Run leaks on the executable
	leaks -quiet -groupByType -conservative -atExit -- "./$filename" &>>leaks_output.txt

	# Stop malloc logging
	unset MallocStackLogging
	unset MallocScribble

	# Print the output
	cd ..
	echo "Leaks output -> analysis/leaks_output.txt"
}

function canalysis {
	########################
	# To be used with a Docker image
	# Dockerfile contents:
	#     FROM alpine:latest
	#     RUN apk add clang valgrind compiler-rt llvm17
	#
	# Create the image:
	#     docker build -t "canalysis" .
	#
	# To delete the image:
	#     docker rmi -f canalysis
	########################

	# Get arguments
	files="$@"

	# Check that there are arguments
	if [ -z "$files" ]; then
		echo "Please input the .c files as arguments."
		echo "The first argument should be the main file."
		return 1
	fi

	# Verify that all the arguments are files with a .c extension
	for file in $files; do
		if [ ! -f "$file" ] || [ "${file##*.}" != "c" ]; then
			echo "Please only input existing files with a .c extension."
			return 1
		fi
	done

	# Verify that the Docker daemon is running
	if [ ! "$(docker stats --no-stream 2>/dev/null)" ]; then
		echo "Please start the Docker daemon. Either run the Docker application or start it manually."
		return 1
	fi

	# Verify that the Docker image exists
	if [ "$(docker image inspect -f {{.Os}} canalysis)" != "linux" ]; then
		echo "Docker image does not exist."
		echo "Please create it with the following command:"
		echo "> echo \"FROM alpine:latest\\\nRUN apk add clang valgrind compiler-rt llvm17\\\n\" > Dockerfile"
		echo "Then build it with:"
		echo "> docker build -t \"canalysis\" ."
		echo "And, if you need to, delete it with:"
		echo "> docker rmi -f canalysis"
		return 1
	fi

	# Create the output directory if it does not exist
	mkdir -p analysis

	# Get the basename of the first file
	filename="$(basename $1)"
	filename="${filename%.*}"

	# Command to attach to the Docker image
	docker_command="docker run -it -v $PWD:/tmp -w /tmp canalysis"

	########################
	# Analyse with the sanitizer
	########################
	# Command to compile the .c files
	compile_command="clang -Wall -O0 -g -fsanitize=address -fno-optimize-sibling-calls -fno-omit-frame-pointer -o analysis/$filename $files"
	# Command to convert the addresses to symbols
	symbolize_command="export ASAN_SYMBOLIZER_PATH=\$(which llvm-symbolizer); llvm-symbolizer ./$filename &>/dev/null"

	# Combine the commands and execute them
	full_command="/bin/sh -c \"\$compile_command; cd analysis; \$symbolize_command; ./$filename\""
	eval $docker_command $full_command &>analysis/sanitizer_output.txt

	# Print the output
	echo "Sanitizer output -> analysis/sanitizer_output.txt"

	########################
	# Analyse with valgrind
	########################
	# Command to compile the .c files
	compile_command="clang -Wall -O0 -g -o analysis/$filename $files"
	# Command to run valgrind on the executable
	valgrind_command="valgrind -s --leak-check=full --leak-resolution=med --track-origins=yes --track-fds=yes --trace-children=yes --show-leak-kinds=all --vgdb=no ./$filename"

	# Combine the commands and execute them
	full_command="/bin/sh -c \"\$compile_command; cd analysis; \$valgrind_command\""
	eval $docker_command $full_command &>analysis/valgrind_output.txt

	# Print the output
	echo "Valgrind output -> analysis/valgrind_output.txt"
}

