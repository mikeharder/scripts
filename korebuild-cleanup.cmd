dotnet nuget locals all -clear
rmdir /s /q %localappdata%\Microsoft\dotnet
rmdir /s /q %userprofile%\.dotnet
git clean -xdf
