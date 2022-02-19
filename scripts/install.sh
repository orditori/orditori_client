#/bin/bash

bundletool build-apks --bundle=build/app/outputs/bundle/release/app-release.aab --output=./orditori.apks && \
bundletool install-apks --apks=./orditori.apks
