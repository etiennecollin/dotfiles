alias o="custom-open"
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
