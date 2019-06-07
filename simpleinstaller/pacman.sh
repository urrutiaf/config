source ./handlers.sh && source ./packages.sh;
if [ $? -ne 0 ]; then
    exit 1;
fi

function check_if_apt_installed {
    program=$1
    sudo apt install -s "$program" | grep "already";
    return $?;
}

function install_apt_package {
    program=$1
    function install {
        check_if_apt_installed "$program" &> /dev/null;
        if [ $? -ne 0 ]; then
            yes | sudo apt install "$program";
        fi
    }
    h "install" "Installing $program.";
}

function install_apt_packages {
    e "sudo apt update";
    for program in "${APT_PACKAGES[@]}"; do
        install_apt_package "$program"
    done
}

function install_apt_additional_packages {
    for program in "${!APT_ADDITIONAL_PACKAGES[@]}"; do
        repo=${APT_ADDITIONAL_PACKAGES[$program]}
        function install {
            check_if_apt_installed "$program" &> /dev/null;
            if [ $? -ne 0 ]; then
               yes | sudo add-apt-repository $repo &&
               yes | sudo apt update &&
               yes | sudo apt install $program;
            fi
        }

        h "install" "Installing $program.";
    done
}

function check_if_pip_installed {
    program=$1;
    python3 -c "import $program";
}

function install_pip_package {
    program=$1
    function install {
        check_if_pip_installed "$program" &> /dev/null;
        if [ $? -ne 0 ]; then
            yes | pip3 install -U $program;
        fi
    }
    h "install" "Installing $program.";
}


function install_pip_packages {
    for program in "${PIP_PACKAGES[@]}"; do
        install_pip_package "$program"
    done
}

