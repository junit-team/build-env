FROM debian:stretch

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

ENV SDKMAN_DIR=/root/.sdkman

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl zip unzip git openssl ca-certificates locales \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/* \
    && curl -s "https://get.sdkman.io" | bash \
    && echo "sdkman_auto_answer=true" > $SDKMAN_DIR/etc/config \
    && echo "sdkman_auto_selfupdate=false" >> $SDKMAN_DIR/etc/config \
    && echo "sdkman_insecure_ssl=true" >> $SDKMAN_DIR/etc/config

ENV JDK8=$SDKMAN_DIR/candidates/java/8.0.222.hs-adpt
RUN bash -c ". $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 8.0.222.hs-adpt"

ENV JDK12=$SDKMAN_DIR/candidates/java/12.0.2-open
RUN bash -c ". $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 12.0.2-open"

ENV JDK13=$SDKMAN_DIR/candidates/java/13.ea.33-open
RUN bash -c ". $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 13.ea.33-open"

ENV JDK14=$SDKMAN_DIR/candidates/java/14.ea.11-open
RUN bash -c ". $SDKMAN_DIR/bin/sdkman-init.sh && sdk install java 14.ea.11-open"

# Set default JDK
ENV JAVA_HOME=$JDK12 PATH="$JDK12/bin:${PATH}"
RUN bash -c ". $SDKMAN_DIR/bin/sdkman-init.sh && sdk default java 12.0.2-open"

# Warm up Gradle caches
RUN cd /tmp \
    && git clone --depth 1 https://github.com/junit-team/junit5.git
RUN cd /tmp/junit5 \
    && ./gradlew build -x test \
    && cd .. \
    && rm -rf junit5

ENTRYPOINT bash
