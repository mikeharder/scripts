git clean -xdf
rmdir /s /q %localappdata%\Microsoft\dotnet
rmdir /s /q %userprofile%\.dotnet
nuget locals all -clear
