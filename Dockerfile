FROM ghcr.io/zephyrproject-rtos/zephyr-build:latest

USER root

RUN apt-get update -y &&			\
    apt-get install -y tree

SHELL ["/bin/bash", "-c"]

ARG USER_ID=1100
ARG GROUP_ID=1100

RUN groupadd -g $GROUP_ID devgroup && 				\
    useradd -m -u $USER_ID -g devgroup devuser && 	\
    usermod -s /bin/bash devuser
	
RUN echo "devuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/devuser && \
	chmod 440 /etc/sudoers.d/devuser

# Download the VSCode Server for the container
RUN wget -q https://update.code.visualstudio.com/latest/server-linux-x64/stable -O vscode-server.tar.gz && \
    mkdir -p /vscode-server && \
    tar -xzf vscode-server.tar.gz -C /vscode-server && \
    rm vscode-server.tar.gz

RUN tree /vscode-server/vscode-server-linux-x64

# Install the Docker extension
RUN /vscode-server/vscode-server-linux-x64/bin/remote-cli/code --install-extension ms-azuretools.vscode-docker

USER devuser
ENTRYPOINT [ "/bin/bash" ]