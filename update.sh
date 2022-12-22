#!/bin/bash
version=$(curl --silent "https://api.github.com/repos/Anuken/Mindustry/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
currentversion=$(cat currentversion)
echo "currentversion:$currentversion version:$version"
echo $version > currentversion
if [[ "$currentversion" == "$version" ]]; then
    exit
fi
sed -i 's/^ENV MINDUSTRY_VERSION.*$/ENV MINDUSTRY_VERSION '$version'/i' Dockerfile
date > timestamp
git config user.name github-actions
git config user.email github-actions@github.com
git add timestamp
git add currentversion
git commit -a -m "Auto Update to Mindustry "$version
git tag -f $version
git tag -f latest
git push
git push origin --tags -f
