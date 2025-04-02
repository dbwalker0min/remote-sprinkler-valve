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

USER devuser
ENTRYPOINT [ "/bin/bash" ]