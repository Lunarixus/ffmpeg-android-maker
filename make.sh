#!/bin/bash

FAM_ARGS="--android-api-level=31 "
FAM_ARGS+="-aom "
FAM_ARGS+="-dav1d "
FAM_ARGS+="-mp3lame "
FAM_ARGS+="-opus "
FAM_ARGS+="-webp "
FAM_ARGS+="-twolame "
FAM_ARGS+="-speex "
FAM_ARGS+="-vpx "
FAM_ARGS+="-freetype "
FAM_ARGS+="-fribidi "
FAM_ARGS+="-x264 "
FAM_ARGS+="-x265 "
#FAM_ARGS+="-bluray " #TODO: Fork libbluray and rename dec_init to support static builds
FAM_ARGS+="-xml2 "
FAM_ARGS+="-gnutls "
FAM_ARGS+="-zlib "

#*lib renames main() to ffmpeg() in both ffmpeg and ffprobe
case $1 in
  static)
    FAM_ARGS+="--enable-static "
    ;;
  staticlib)
    FAM_ARGS+="--enable-static --enable-library "
    ;;
  shared)
    FAM_ARGS+="--enable-shared "
    ;;
  sharedlib)
    FAM_ARGS+="--enable-shared --enable-library "
    ;;
  *)
    echo "Must make either static, staticlib, shared, or sharedlib."
    exit 1
esac

set -e
sudo docker build -t "joshuadoes/ffmpeg-android-maker:Dockerfile" .
sudo docker run --rm -v .:/mnt/ffmpeg-android-maker -e FAM_ARGS="${FAM_ARGS}" joshuadoes/ffmpeg-android-maker:Dockerfile
set +e
