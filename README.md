# flutter-builder-docker

[![Build Status](https://cloud.drone.io/api/badges/v7lin/flutter-builder-docker/status.svg)](https://cloud.drone.io/v7lin/flutter-builder-docker)
[![Docker Pulls](https://img.shields.io/docker/pulls/v7lin/flutter.svg)](https://hub.docker.com/r/v7lin/flutter)

## usage

### drone
````
kind: pipeline
name: default

steps:
- name: prepare
  image: v7lin/flutter:1.2.1-stable
  volumes:
  - name: pub-cache
    path: /opt/flutter/.pub-cache
  commands:
  - flutter packages get

- name: analyze
  image: v7lin/flutter:1.2.1-stable
  volumes:
  - name: pub-cache
    path: /opt/flutter/.pub-cache
  commands:
  - flutter analyze

- name: test
  image: v7lin/flutter:1.2.1-stable
  volumes:
  - name: pub-cache
    path: /opt/flutter/.pub-cache
  commands:
  - flutter test

- name: publish-check
  image: v7lin/flutter:1.2.1-stable
  volumes:
  - name: pub-cache
    path: /opt/flutter/.pub-cache
  commands:
  - flutter packages pub publish --dry-run

volumes:
- name: pub-cache
  temp: {}
````