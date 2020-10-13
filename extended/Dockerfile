FROM ghcr.io/junit-team/build

ARG ADDITIONAL_JDK_VERSION

RUN bash -c ". $SDKMAN_DIR/bin/sdkman-init.sh \
    && sdk install java $ADDITIONAL_JDK_VERSION \
    && sdk default java $DEFAULT_JDK_VERSION \
    && sdk flush archives \
    && sdk flush temp"

ENV ADDITIONAL_JDK=$SDKMAN_DIR/candidates/java/$ADDITIONAL_JDK_VERSION
