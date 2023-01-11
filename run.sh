#!/bin/bash
PACKAGER_BIN="./packager"

CONTENT_ID="contentId"
KEY_ID="6d76f25cb17f5e16b8eaef6bbf582d8e"
KEY="cb541084c99731aef4fff74500c12ead"
IV="33445566778899001122334455667788"

function cenc() {
    ${PACKAGER_BIN} \
        in=h264_1080p_5000_60fps.mp4,stream=video,output=h264_1080p.mp4,drm_label=HD \
        --enable_raw_key_encryption \
        --keys label=HD:key_id=${KEY_ID}:key=${KEY} \
        --protection_systems Widevine,PlayReady \
        --mpd_output h264.mpd \
        --hls_master_playlist_output h264_master.m3u8
}

function cenc_cbcs() {
    ${PACKAGER_BIN} \
        in=h264_1080p_5000_60fps.mp4,stream=video,output=h264_1080p.mp4,drm_label=HD \
        --enable_raw_key_encryption \
        --protection_scheme cbcs \
        --keys label=HD:key_id=${KEY_ID}:key=${KEY}:iv=${IV} \
        --protection_systems Fairplay,Widevine,PlayReady \
        --mpd_output h264.mpd \
        --hls_key_uri skd://${CONTENT_ID} \
        --hls_master_playlist_output h264_master.m3u8
}

function fairplay() {
    ${PACKAGER_BIN} \
        in=h264_1080p_5000_60fps.mp4,stream=video,output=h264_1080p.mp4,drm_label=HD \
        --protection_scheme cbcs \
        --enable_raw_key_encryption \
        --keys label=HD:key_id=${KEY_ID}:key=${KEY}:iv=${IV} \
        --protection_systems FairPlay \
        --hls_master_playlist_output h264_master.m3u8 \
        --hls_key_uri skd://${CONTENT_ID}
}

function playready() {
    ${PACKAGER_BIN} \
        in=h264_1080p_5000_60fps.mp4,stream=video,output=h264_1080p.mp4,drm_label=HD \
        --enable_raw_key_encryption \
        --keys label=HD:key_id=${KEY_ID}:key=${KEY} \
        --protection_systems PlayReady \
        --mpd_output h264.mpd
}

function widevine() {
    ${PACKAGER_BIN} \
        in=h264_1080p_5000_60fps.mp4,stream=video,output=h264_1080p.mp4,drm_label=HD \
        --enable_raw_key_encryption \
        --keys label=HD:key_id=${KEY_ID}:key=${KEY} \
        --protection_systems Widevine \
        --mpd_output h264.mpd
}

function widevine_hls() {
    ${PACKAGER_BIN} \
        in=h264_1080p_5000_60fps.mp4,stream=video,output=h264_1080p.mp4,drm_label=HD \
        --enable_raw_key_encryption \
        --keys label=HD:key_id=${KEY_ID}:key=${KEY} \
        --protection_systems Widevine \
        --hls_master_playlist_output h264_master.m3u8
}

case $1 in

"cenc")
    cenc
    ;;

"cenc_cbcs")
    cenc_cbcs
    ;;

"fairplay")
    fairplay
    ;;

"playready")
    cenc
    ;;

"widevine")
    widevine
    ;;

"widevine_hls")
    widevine_hls
    ;;

*)
    echo ""
    ;;
esac
