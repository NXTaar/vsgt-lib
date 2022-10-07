#!/bin/bash
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit ; pwd -P )

cd "$parent_path" || exit

source ./brew-packages.sh

which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/sagatovskii/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/sagatovskii/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    brew update
fi

brew install $brewPackages