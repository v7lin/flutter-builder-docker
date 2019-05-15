# --- download ---

FROM alpine:3.9 as download

ENV ANDROID_SDK_TOOLS=4333796

RUN apk update; \
    apk add --no-cache zip; \
    rm -rf /var/cache/apk/*

RUN wget --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip \
    && unzip android-sdk.zip -d /opt/android-sdk-linux

ENV FLUTTER_CHANNEL=stable
ENV FLUTTER_VERSION=1.5.4-hotfix.2-${FLUTTER_CHANNEL}

RUN wget --output-document=flutter.tar.xz https://storage.googleapis.com/flutter_infra/releases/${FLUTTER_CHANNEL}/linux/flutter_linux_v${FLUTTER_VERSION}.tar.xz \
    && tar xf flutter.tar.xz -C /opt

# --- prod ---

FROM openjdk:8-jdk-alpine as prod

MAINTAINER v7lin <v7lin@qq.com>

ENV GLIBC_VERSION="2.28-r0"

# Install Required Tools
RUN apk -U update \
    && apk -U add \
    bash \
    ca-certificates \
    curl \
    expect \
    git \
    make \
    libstdc++ \
    libgcc \
    su-exec \
    ncurses \
    unzip \
    wget \
    zlib \
    && wget https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -O /etc/apk/keys/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk -O /tmp/glibc.apk \
	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk -O /tmp/glibc-bin.apk \
	&& apk add /tmp/glibc.apk /tmp/glibc-bin.apk \
	&& rm -rf /tmp/* \
	&& rm -rf /var/cache/apk/*

ENV ANDROID_COMPILE_SDK=28
ENV ANDROID_BUILD_TOOLS=28.0.3
ENV ANDROID_EMULATOR_VERSION=28
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV PATH=$PATH:${ANDROID_HOME}/tools
ENV PATH=$PATH:${ANDROID_HOME}/platform-tools
ENV PATH=$PATH:/opt/flutter/bin

COPY --from=download /opt/android-sdk-linux ${ANDROID_HOME}
COPY --from=download /opt/flutter /opt/flutter

RUN mkdir /root/.android && touch /root/.android/repositories.cfg \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "platform-tools" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "platforms;android-27" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "platforms;android-28" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "build-tools;27.0.3" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "build-tools;28.0.3" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;android;gapid;1" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;android;gapid;3" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;android;m2repository" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;google;auto" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;google;google_play_services" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;google;instantapps" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;google;m2repository" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;google;market_apk_expansion" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;google;market_licensing" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;google;simulators" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;google;webdriver" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "cmake;3.6.4111459" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "cmake;3.10.2.4988404" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "ndk-bundle" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "lldb;3.1" \
    && echo "y" | ${ANDROID_HOME}/tools/bin/sdkmanager "emulator" \
    && yes | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses || echo "Failed" \

#RUN dnf update -y \
#    && dnf install -y wget tar unzip ruby ruby-devel make autoconf automake redhat-rpm-config lcov\
#           gcc gcc-c++ libstdc++.i686 java-1.8.0-openjdk-devel xz git mesa-libGL mesa-libGLU\
#    && dnf clean all
#
#RUN dnf update -y \
#    && dnf install -y pulseaudio-libs mesa-libGL  mesa-libGLES mesa-libEGL \
#    && dnf clean all
