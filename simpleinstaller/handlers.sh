OK="\033[1;32mOK\033[0m";
FAILED="\033[1;31mFAILED\033[0m";

function show {
    text=$1
    echo -e "\033[1;37m>>> $text\033[0m"
}

function u_general {
    handler=$1
    command=$2
    msg=$3
    success=$4
    failure=$5

    show "Do you really want to run the following command? (y/n)\n\n\t$command\n"
    read -n 1 -r;
    echo;
    echo;
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        $handler "$command" "$msg" "$success" "$failure";
    else
        $failure;
        return 1;
    fi
    return 0;
}

function h {    # Common handler (try catch)
    command=$1  # Try to execute this command
    msg=$2      # Show this message prior to execution
    success=$3  # In case of success execute this command
    failure=$4  # In case of failure execute this command

    if [ -z "$msg" ]
    then
        show "Executing: $command";
    else
        show "$msg";
    fi

    echo;
    $command;
    error=$?;

    if [ $error -ne 0 ]; then
        echo -e "$FAILED: $command";
        $failure;
    else
        echo -e "$OK";
        $success;
    fi
    echo "";
    return $error;
}

function e {    # Essential handler (Exit in case of failure)
    command=$1  # Try to execute this command
    msg=$2      # Show this message prior to execution
    success=$3  # In case of success execute this command
    failure=$4  # In case of failure execute this command

    h "$command" "$msg" "$success" "$failure";
    error=$?;

    if [ $error -ne 0 ]; then
        exit 1;
    fi
}

function u {    # Ask the user if they wants to execute this command
    command=$1  # Try to execute this command
    msg=$2      # Show this message prior to execution
    success=$3  # In case of success execute this command
    failure=$4  # In case of failure execute this command

    u_general h $command $msg $success $failure
    return $?;
}

function eu {   # Ask the user if they wants to execute this command
                # and exit in case of failure
    command=$1  # Try to execute this command
    msg=$2      # Show this message prior to execution
    success=$3  # In case of success execute this command
    failure=$4  # In case of failure execute this command

    u_general e $command $msg $success $failure
    error=$?;
    if [ $error -ne 0 ]; then
        exit 1;
    fi
}

function ask_user { # Ask the user to execute success command
    question=$1;    # Show this question (yes or no question)
    success=$2;     # If user answers yes execute this command
    failure=$3;     # If user answers no execute this command

    show "$1 (y/n)\n\n";
    read -n 1 -r;
    echo;
    echo;
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        $success;
    else
        $failure;
        return 1;
    fi
    return 0;
}
