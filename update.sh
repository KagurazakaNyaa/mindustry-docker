#!/bin/bash
version=$(curl --silent -H "Authorization: Bearer ${GITHUB_TOKEN}" "https://api.github.com/repos/Anuken/Mindustry/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
currentversion=$(cat currentversion)
echo "currentversion:$currentversion version:$version"
echo $version > currentversion
if [[ "$currentversion" == "$version" ]]; then
    exit
fi
sed -i 's/^ENV MINDUSTRY_VERSION.*$/ENV MINDUSTRY_VERSION '$version'/i' Dockerfile
date > timestamp
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add timestamp
git add currentversion
git commit -a -m "Auto Update to Mindustry "$version
git tag -f $version
git tag -f latest
git push
git push origin --tags -f
