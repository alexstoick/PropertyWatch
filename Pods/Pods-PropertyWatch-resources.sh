#!/bin/sh
set -e

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    *.xcassets)
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme/slider-default_trackBackground@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/1-slider-default7-handle.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/1-slider-default7-handle@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/2-slider-default7-handle.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/2-slider-default7-handle@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/3-slider-default7-handle.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/3-slider-default7-handle@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/dsa.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default-handle-highlighted.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default-handle-highlighted@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default-handle.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default-handle@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default-track.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default-track@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default-trackBackground.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default-trackCrossedOver.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default-trackCrossedOver@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default7-handle.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default7-handle@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default7-track.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default7-track@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default7-trackBackground.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default7-trackBackground@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default7-trackCrossedOver.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default7-trackCrossedOver@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-default7.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-metal-handle-highlighted.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-metal-handle-highlighted@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-metal-handle.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-metal-handle@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-metal-track.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-metal-track@2x.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-metal-trackBackground.png"
install_resource "NMRangeSlider/NMRangeSlider/DefaultTheme7/slider-metal-trackBackground@2x.png"
install_resource "ProgressHUD/ProgressHUD/ProgressHUD.bundle"

rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ `xcrun --find actool` ] && [ `find . -name '*.xcassets' | wc -l` -ne 0 ]
then
  case "${TARGETED_DEVICE_FAMILY}" in 
    1,2)
      TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
      ;;
    1)
      TARGET_DEVICE_ARGS="--target-device iphone"
      ;;
    2)
      TARGET_DEVICE_ARGS="--target-device ipad"
      ;;
    *)
      TARGET_DEVICE_ARGS="--target-device mac"
      ;;  
  esac 
  find "${PWD}" -name "*.xcassets" -print0 | xargs -0 actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${IPHONEOS_DEPLOYMENT_TARGET}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
