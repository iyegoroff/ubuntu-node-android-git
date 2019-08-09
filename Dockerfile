FROM ubuntu:bionic

RUN apt-get -yqq update && \
    apt-get -yqq --no-install-recommends install \
    apt-transport-https \
    unzip \
    curl \
    usbutils \
    git \
    openjdk-8-jdk \
    lib32stdc++6 \
    lib32z1

RUN curl -o nodejs.deb https://deb.nodesource.com/node_10.x/pool/main/n/nodejs/nodejs_10.16.2-1nodesource1_amd64.deb && \
    apt-get -yqq install ./nodejs.deb --no-install-recommends && \
    apt-get -yqq autoremove && \
    apt-get -yqq clean && \
    rm nodejs.deb && \
    rm -rf /var/lib/apt/lists/* /var/cache/* /tmp/* /var/tmp/*

RUN mkdir -p /usr/local/android-sdk-linux && \
    curl -sL https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -o tools.zip && \
    unzip tools.zip -d /usr/local/android-sdk-linux && \
    rm tools.zip

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools" "platforms;android-29" "build-tools;29.0.2" "extras;android;m2repository" "extras;google;m2repository"
