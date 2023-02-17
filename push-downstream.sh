#!/bin/bash
set -euo pipefail

major_version="0"
minor_version="0"

echo "Commit message:"
read commit_message

echo "Patch version (eg. 5):"
read commit_version

git add -A
git commit -m "$commit_message"
git tag "v0.$minor_version.$commit_version"
git push

# handle downstream business
# 
# assumes that downstream repos already has upstream remote
# git remote add upstream git@github.com:boeegh/dotnet-run-base.git
base_dir=$PWD
for path in "../dotnet-run-6" "../dotnet-run-7"
do
  cd $path
  git fetch upstream
  git rebase upstream/main
  #echo "Entering manual mode. When you're ready to commit, type: exit"
  #bash
  #git add -A
  #git commit -m $commit_message
  #git tag "v0.$minor_version.$commit_version"
  #git push
  bash

  cd $base_dir
done


#gca "Extra example in readme.md, switch to forked model" && git tag v0.0.4 && git push --tags && gps --force