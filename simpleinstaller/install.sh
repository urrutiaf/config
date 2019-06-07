#!/bin/bash
LOGFILE="logfile";

source ./handlers.sh &&
source ./packages.sh &&
source ./pacman.sh;
if [ $? -ne 0 ]; then
    exit 1;
fi

function run_all_scripts {
    for script in ./scripts/*.sh; do
        u "$script";
    done
}

function main {
    ask_user "Install apt packages?" "install_apt_packages";

    ask_user "Install pip packages?" "install_pip_packages";

    ask_user "Run all scripts?" "run_all_scripts";
}

main 1>&1 2>&1 | tee $LOGFILE;
cat $LOGFILE | grep "FAILED" &> /dev/null;

if [ $? -ne 0 ]; then
    echo -e "$OK";
else
    echo -e "Failures were found:";
    echo "See $LOGFILE for more information";
fi
