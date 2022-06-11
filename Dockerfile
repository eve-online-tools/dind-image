FROM docker:20.10.17-dind

ARG BUILDX_URL=https://github.com/docker/buildx/releases/download/v0.8.2/buildx-v0.8.2.darwin-amd64

RUN mkdir -p $HOME/.docker/cli-plugins && \
    wget -O $HOME/.docker/cli-plugins/docker-buildx $BUILDX_URL && \
    chmod a+x $HOME/.docker/cli-plugins/docker-buildx
