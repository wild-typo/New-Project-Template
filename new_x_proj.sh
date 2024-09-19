#!/bin/bash

BASE_DIR=$(dirname "$0")
NEW_C_SCRIPT_PATH="$BASE_DIR/template/c/new_c_proj.sh"
NEW_ASSEMBLY_SCRIPT_PATH="$BASE_DIR/template/assembly/new_assembly_proj.sh"
# NEW_PYTHON_SCRIPT_PATH="$BASE_DIR/template/python/new_python_proj.sh"
# NEW_SWIFT_SCRIPT_PATH="$BASE_DIR/template/swift/new_swift_proj.sh"

# Function to display usage
usage() {
    echo "Usage: $0 <project_name> [directory] [-c] [-p] [-s] [-a]"
    echo "  project_name: Name of the project (mandatory)"
    echo "  directory: Directory to create the project (optional, defaults to current directory)"
    echo "  -c: Set up for C language"
    echo "  -p: Set up for Python language"
    echo "  -s: Set up for Swift language"
    echo "  -a: Set up for Assembly language"
    exit 1
}

# Ensure that at least the project name is provided
if [ $# -lt 1 ]; then
    usage
fi

# First argument is the project name
PROJECT_NAME=$1

# Second argument is the optional directory (defaults to current directory if not provided)
if [[ -n $2 && $2 != -* ]]; then
    DIRECTORY=$2
    shift 2
else
    DIRECTORY="."
    shift 1
fi

# Initialize language flags
C_FLAG=0
PYTHON_FLAG=0
SWIFT_FLAG=0
ASSEMBLY_FLAG=0

# Process the options
while getopts "cpsa" opt; do
    case $opt in
        c)
            C_FLAG=1
            ;;
        p)
           PYTHON_FLAG=1
            ;;
        s)
            SWIFT_FLAG=1
            ;;
        a)
            ASSEMBLY_FLAG=1
            ;;
        *)
            usage
            ;;
    esac
done

# Create the project directory
PROJECT_PATH="$DIRECTORY/$PROJECT_NAME"
mkdir -p "$PROJECT_PATH"
echo "Project '$PROJECT_NAME' created in directory '$DIRECTORY'"

# Setup for C language if -c option is provided
if [ $C_FLAG -eq 1 ]; then
    C_PROJECT_PATH="$PROJECT_PATH/c"
    mkdir -p "$C_PROJECT_PATH"
    $NEW_C_SCRIPT_PATH $PROJECT_NAME $C_PROJECT_PATH    
    echo "C project '$PROJECT_NAME' created in directory '$C_PROJECT_PATH'"
fi

# Setup for Python language if -p option is provided
if [ $PYTHON_FLAG -eq 1 ]; then
    PYTHON_PROJECT_PATH="$PROJECT_PATH/python"
    mkdir -p "$PYTHON_PROJECT_PATH"
    touch "$PYTHON_PROJECT_PATH/$PROJECT_NAME.py"
    echo "print('Hello world!')" > "$PYTHON_PROJECT_PATH/$PROJECT_NAME.py"
    echo "PYTHON project '$PROJECT_NAME' created in directory '$PYTHON_PROJECT_PATH'"
fi

# Setup for Swift language if -s option is provided
if [ $SWIFT_FLAG -eq 1 ]; then
    SWIFT_PROJECT_PATH="$PROJECT_PATH/swift"
    mkdir -p "$SWIFT_PROJECT_PATH"
    touch "$SWIFT_PROJECT_PATH/$PROJECT_NAME.swift"
    echo "print(\"Hello world!\")" > "$SWIFT_PROJECT_PATH/$PROJECT_NAME.swift"
    echo "SWIFT project '$PROJECT_NAME' created in directory '$SWIFT_PROJECT_PATH'"
fi

# Setup for Assembly language if -c option is provided
if [ $ASSEMBLY_FLAG -eq 1 ]; then
    ASSEMBLY_PROJECT_PATH="$PROJECT_PATH/assembly"
    mkdir -p "$ASSEMBLY_PROJECT_PATH"
    $NEW_ASSEMBLY_SCRIPT_PATH $PROJECT_NAME $ASSEMBLY_PROJECT_PATH    
    echo "Assembly project '$PROJECT_NAME' created in directory '$ASSEMBLY_PROJECT_PATH'"
fi


