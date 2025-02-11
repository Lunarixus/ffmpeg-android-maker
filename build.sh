#!/bin/bash

INST=/var/www/html/android/ffmpeg
USR=www-data
GRP=www-data

FAM_ARGS=(--android-api-level=31)
FAM_ARGS+=(-aom)
FAM_ARGS+=(-dav1d)
FAM_ARGS+=(-mp3lame)
FAM_ARGS+=(-opus)
FAM_ARGS+=(-vorbis)
FAM_ARGS+=(-webp)
FAM_ARGS+=(-wavpack)
FAM_ARGS+=(-twolame)
FAM_ARGS+=(-speex)
FAM_ARGS+=(-vpx)
FAM_ARGS+=(-freetype)
FAM_ARGS+=(-fribidi)
FAM_ARGS+=(-x264)
FAM_ARGS+=(-x265)
FAM_ARGS+=(-bluray)
FAM_ARGS+=(-xml2)
FAM_ARGS+=(-gnutls)
FAM_ARGS+=(-zlib)

set -e

sudo docker pull javernaut/ffmpeg-android-maker
sudo docker run --rm -v .:/mnt/ffmpeg-android-maker -e FAM_ARGS="${FAM_ARGS}" javernaut/ffmpeg-android-maker

set +e

sudo rm -rf $INST
for arch in arm64-v8a armeabi-v7a x86 x86_64; do
  sudo mkdir -p $INST/$arch/bin
  sudo mkdir -p $INST/$arch/lib
  sudo cp build/ffmpeg/$arch/bin/* $INST/$arch/bin/
  sudo cp build/ffmpeg/$arch/lib/* $INST/$arch/lib/
done
sudo chown -R $USR:$GRP $INST
