#!/usr/bin/env bash

# This script allows you to easily and quickly generate and deploy your website
# using Hugo to your personal GitHub Pages repository. This script requires a
# certain configuration, run the `setup.sh` script to configure this. See
# https://hjdskes.github.io/blog/update-deploying-hugo-on-personal-github-pages/
# for more information.

# Set the English locale for the `date` command.
export LC_TIME=en_US.UTF-8

# The commit message.
MESSAGE="Site rebuild $(date)"

msg() {
    printf "\033[1;32m :: %s\n\033[0m" "$1"
}

if [[ $(git status -s) ]]; then
    msg "The working directory is dirty, please commit or stash any pending changes"
    exit 1;
fi

#msg "/************************/"
#msg "Removing the old website"
#msg "/************************/"
#pushd public
#rm -rf *
#popd

msg "/************************/"
msg "Building the website"
msg "/************************/"
hugo --quiet --theme=even 


msg "/************************/"
msg "Commit Changes"
msg "/************************/"
# Add changes to git.
pushd public
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

msg "/************************/"
msg "Pushing the updated \`public\` folder to the \`master\` branch"
msg "/************************/"
git push origin master
popd