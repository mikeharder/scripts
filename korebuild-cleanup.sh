#!/bin/sh

# echo on
set -x

git clean -xdf
rm -rf ~/.dotnet ~/.nuget ~/.local/share/NuGet
