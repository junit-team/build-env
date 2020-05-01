FROM debian:buster

ENTRYPOINT bash

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

ENV SDKMAN_DIR=/root/.sdkman

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl zip unzip git graphviz openssl ca-certificates locales \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/* \
    && curl -s "https://get.sdkman.io" | bash \
    && echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config \
    && echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_insecure_ssl=true" >> $SDKMAN_DIR/etc/config

ARG JDK8_VERSION=8.0.252.hs-adpt
ARG DEFAULT_JDK_VERSION=11.0.7.hs-adpt

RUN bash -c ". $SDKMAN_DIR/bin/sdkman-init.sh \
    && sdk install java $JDK8_VERSION \
    && sdk install java $DEFAULT_JDK_VERSION \
    && sdk flush archives \
    && sdk flush temp"

ENV JDK8=$SDKMAN_DIR/candidates/java/$JDK8_VERSION \
    JAVA_HOME=$SDKMAN_DIR/candidates/java/$DEFAULT_JDK_VERSION \
    PATH="$JAVA_HOME/bin:${PATH}"
