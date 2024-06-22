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
		echo "Starting removal"
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

function e {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd "$cwd"
	fi
	rm -f -- "$tmp"
}
