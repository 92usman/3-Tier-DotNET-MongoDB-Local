#!/bin/bash
# This tells Linux to run the script using the Bash shell.

git clone https://github.com/92usman/3-Tier-DotNET-MongoDB-Local.git
# Clones your .NET + MongoDB project from GitHub into your home directory.

sudo apt-get update && \
# Updates Ubuntu’s package list so it knows the latest versions.

sudo apt-get install -y dotnet-sdk-8.0
# Installs the .NET 8 SDK (needed to build and run .NET applications).

sudo apt-get update && \
# Updates package list again (safe but optional).

sudo apt-get install -y aspnetcore-runtime-8.0
# Installs the ASP.NET Core Runtime 8 (needed to run web APIs).

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
# Downloads the MongoDB 7.0 GPG key securely.

sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
--dearmor
# Converts the downloaded key into a format Ubuntu can use and stores it.

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
# Adds the official MongoDB 7.0 repository to your system so Ubuntu can install MongoDB.

sudo apt update
# Refreshes package list again to include the new MongoDB repo.

sudo apt install -y mongodb-org
# Installs MongoDB 7.0 (server + tools).

sudo systemctl enable mongod
# Makes MongoDB start automatically every time the machine boots.

sudo systemctl start mongod
# Starts the MongoDB database service right now.

cd 3-Tier-DotNET-MongoDB-Local
# Moves into your cloned project folder.

# FIX FOR HTTPS WARNING:
# ASP.NET Core tries to redirect HTTP → HTTPS but no HTTPS port is configured.
# This disables HTTPS redirection so the app runs cleanly on HTTP.
sed -i 's/app.UseHttpsRedirection();//g' Program.cs

dotnet build
# Builds the .NET project (compiles the code).

dotnet run
# Runs the .NET backend server (starts the web API).
