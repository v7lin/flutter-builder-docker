# --- download ---

FROM alpine:3.9 as download

ENV FLUTTER_CHANNEL=stable
ENV FLUTTER_VERSION=1.12.13+hotfix.5

RUN wget --output-document=flutter.tar.xz https://storage.googleapis.com/flutter_infra/releases/${FLUTTER_CHANNEL}/linux/flutter_linux_v${FLUTTER_VERSION}-${FLUTTER_CHANNEL}.tar.xz \
    && tar xf flutter.tar.xz -C /opt

# --- prod ---

FROM runmymind/docker-android-sdk as prod

MAINTAINER v7lin <v7lin@qq.com>

ENV PATH=$PATH:/opt/flutter/bin

COPY --from=download /opt/flutter /opt/flutter
