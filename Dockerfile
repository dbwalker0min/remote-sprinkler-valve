FROM ghcr.io/zephyrproject-rtos/zephyr-build@sha256:df2a30362a665ff71bb7be82b4c61c3674273abedbaa64621d8bfd18b3076882

USER root

SHELL ["/bin/bash", "-c"]

RUN apt-get update -y &&			\
    apt-get install -y tree

RUN usermod --shell /bin/bash user

ENV ZEPHYR_BASE=/workspaces/remote-sprinkler-valve/zephyr
