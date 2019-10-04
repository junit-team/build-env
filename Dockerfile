FROM debian:buster

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

RUN bash -c ". $SDKMAN_DIR/bin/sdkman-init.sh \
    && sdk install java 8.0.222.hs-adpt \
    && sdk install java 12.0.2-open \
    && sdk install java 13.0.0-open \
    && sdk install java 14.ea.15-open \
    && sdk flush archives \
    && sdk flush temp"

ENV JDK8=$SDKMAN_DIR/candidates/java/8.0.222.hs-adpt \
    JDK12=$SDKMAN_DIR/candidates/java/12.0.2-open \
    JDK13=$SDKMAN_DIR/candidates/java/13.0.0-open \
    JDK14=$SDKMAN_DIR/candidates/java/14.ea.15-open

ENV JAVA_HOME=$JDK12 \
    PATH="$JDK12/bin:${PATH}"

# Warm up Gradle caches
RUN cd /tmp \
    && git clone --depth 1 https://github.com/junit-team/junit5.git \
    && cd /tmp/junit5 \
    && ./gradlew build -x test \
    && cd .. \
    && rm -rf junit5

ENTRYPOINT bash
