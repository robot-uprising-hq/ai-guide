#!/bin/bash

trap "exit 1" TERM
export TOP_PID=$$

# Ask user for yes/no with question. q-character exits the script.
# First parameter $1 is the name of repo to setup
function ask_user() {
    echo >&2
    echo >&2
    read -p "Do you want to setup $1 [y/N]?   [q to exit]" response
    if [[ "$response" =~ ^([qQ])$ ]]
    then
        echo "==== Exiting ====" >&2
        kill -s TERM $TOP_PID
    fi
    echo $response
}


# Clone a github repo. First try with SSH if you have the sshkey setup
# in github. Else clone via HTTPS.
# First parameter $1 is the name to print to user
# Second parameter $2 is the repo's path without the protocol prefix
function clone_git_repo() {
    {
        echo "==== Cloning $1 via ssh ===="
        git clone git@github.com:$2
    } || {
        echo "==== Could not clone via ssh ===="
        echo "==== Cloning $1 via https ===="
        git clone https://github.com/$2
    }
    echo "==== $1 cloned ===="
}


# Install Python requirements from requirements.txt with pip
# First parameter $1 is the folder to cd into.
function make_pip_install() {
    echo
    echo "==== Creating Pyhton virtual environment and installing python requirements... ===="
    echo
    cd $1
    virtualenv venv && source venv/bin/activate && pip3 install wheel setuptools && pip3 install -r requirements.txt && deactivate
    cd ..
}


# ===
# === TELL ABOUT DEPENDENCIES ===
# ===
echo
echo "Make sure you have installed all requirements:"
echo "- git           // used to pull the repositories (install with 'sudo apt install git')"
echo "- python3       // ml-agents requires Python (3.6.1 or higher)"
echo "- pip3          // used to install python requirements (install with 'sudo apt install python3-pip')"
echo "- virtualenv    // used to contain python packages (install with 'sudo pip3 install virtualenv')"
echo


mkdir robot-uprising
cd robot-uprising


# ===
# === DOWNLOAD AND INSTALL AI SIMULATOR ===
# ===
response=$(ask_user "AI Simulator")
if [[ $response =~ ^([yY])$ ]]
then
    clone_git_repo "AI simulator" "robot-uprising-hq/ai-simulator.git"
    make_pip_install "ai-simulator"
fi

# ===
# === DOWNLOAD AI REMOTE BRAIN ===
# ===
response=$(ask_user "AI Remote Brain")
if [[ $response =~ ^([yY])$ ]]
then
    clone_git_repo "AI Remote Brain" "robot-uprising-hq/ai-remote-brain.git"
fi

# ===
# === DOWNLOAD AI BACKEND CONNECTOR ===
# ===
response=$(ask_user "AI Backend Connector")
if [[ $response =~ ^([yY])$ ]]
then
    clone_git_repo "AI Backend Connector" "robot-uprising-hq/ai-backend-connector.git"
    make_pip_install "ai-backend-connector"
fi

# ===
# === DOWNLOAD AI ROBOT ===
# ===
response=$(ask_user "AI Robot")
if [[ $response =~ ^([yY])$ ]]
then
    clone_git_repo "AI Robot" "robot-uprising-hq/ai-robot.git"
fi

# ===
# === DOWNLOAD AI VIDEO STREAMER ===
# ===
response=$(ask_user "AI Video Streamer")
if [[ $response =~ ^([yY])$ ]]
then
    clone_git_repo "AI Video Streamer" "robot-uprising-hq/ai-video-streamer.git"
    make_pip_install "ai-video-streamer"
fi


# ===
# === DOWNLOAD AI PROTO ===
# ===
response=$(ask_user "AI Proto")
if [[ $response =~ ^([yY])$ ]]
then
    clone_git_repo "AI Proto" "robot-uprising-hq/ai-proto.git"
    make_pip_install "ai-proto"
fi


# ===
# === DOWNLOAD AI GUIDE ===
# ===
response=$(ask_user "AI Guide")
if [[ $response =~ ^([yY])$ ]]
then
    clone_git_repo "AI Guide" "robot-uprising-hq/ai-guide.git"
fi

echo
echo "==== Project installed ===="
echo
