#!/bin/bash

# Create a WSL socket for the openSSH agent. This allows using the SSH credentials
# from Windows in WSL and Docker if the stream given by /tmp/ssh-agent.sock is mounted.
# Note that this will also use 1Password managed credentials.
export SSH_AUTH_SOCK=/tmp/ssh-agent.sock

if [ ! -e "$SSH_AUTH_SOCK" ]; then
        exec socat \
                UNIX-LISTEN:${SSH_AUTH_SOCK},umask=007,fork \
                EXEC:'npiperelay.exe -ep -s //./pipe/openssh-ssh-agent',nofork &
fi
