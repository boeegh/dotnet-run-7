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
if [ -n "$commit_version" ]; then
  git tag "v0.$minor_version.$commit_version"
  git push --tags
fi
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
  # git rebase upstream/main || (echo "Entering manual mode. When you're ready to commit, type: exit" && bash)
  git merge upstream/main || (echo "Entering manual mode in $PWD. When you're ready to commit, type: exit" && bash && echo "Returned from manual mode. Proceeding with commit and push.")

  # git add -A || echo "Nothing to add in $PWD?"
  git commit -m $commit_message || echo "Nothing to commit in $PWD?"
  if [ -n "$commit_version" ]; then
    git tag "v0.$minor_version.$commit_version" || echo "Unable to add tag."
    git push --tags || echo "Unable to push tags."
  fi
  git push
#  git push --force

  cd $base_dir
done
