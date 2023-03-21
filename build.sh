#!/bin/bash -e
echo "Deneme Folder : " $(cd $(dirname ${0}); pwd)


# build.sh dosyasını ekleyerek tam dizin oluşturuyoruz

echo "Full Path : " $full_path

#install fastlane
bash "$DC_SCRIPT_PATH" "$GITHUB_REPOSITORY [${GITHUB_REF}] #$GITHUB_RUN_NUMBER" "Fastlane kuruluyor" "${PIPELINE_ID}" "0" "Fastlane kuruluyor" "0x00ff00" 

if ! type fastlane > /dev/null 2>&1; then
  if type brew > /dev/null 2>&1; then
    brew install fastlane@2.210.1
  else
    sudo gem install fastlane -NV -v 2.210.1
  fi
fi

#install bundler
bash "$DC_SCRIPT_PATH" "$GITHUB_REPOSITORY [${GITHUB_REF}] #$GITHUB_RUN_NUMBER" "Bundle kuruluyor" "${PIPELINE_ID}" "0" "Bundle kuruluyor" "0xffff00"
script_path=$(cd $(dirname ${0}); pwd)
cp -r ${script_path}/fastlane ./
cp -r ${script_path}/Gemfile ./

if [[ $BROWSERSTACK_UPLOAD = true || $BUILD_PODS = true ]]; then
    bundle install
fi


# If the variable FASTLANE_ENV is set then run fastlane with the --env equal to the variable.
if [ -n "${FASTLANE_ENV}" ]; then
    echo "Running fastlane with environment: ${FASTLANE_ENV}"
    if ! type bundle > /dev/null 2>&1; then
        echo "Bundler is not installed. Please install bundler to use fastlane with environment variables."
        bash "$DC_SCRIPT_PATH" "$GITHUB_REPOSITORY [${GITHUB_REF}] #$GITHUB_RUN_NUMBER" "Bundler kurulamadı" "${PIPELINE_ID}" "0" "Bundler kurulamadı" "0xffff00"
    fi
    
    if ! type fastlane > /dev/null 2>&1; then
        echo "Fastlane is not installed. Please install fastlane to use fastlane with environment variables."
        bash "$DC_SCRIPT_PATH" "$GITHUB_REPOSITORY [${GITHUB_REF}] #$GITHUB_RUN_NUMBER" "Fastlane kurulamadı" "${PIPELINE_ID}" "0" "Fastlane kurulamadı" "0xffff00"
    fi
    fastlane --env ${FASTLANE_ENV} build
else
    echo "Running fastlane"
    bash "$DC_SCRIPT_PATH" "$GITHUB_REPOSITORY [${GITHUB_REF}] #$GITHUB_RUN_NUMBER" "Fastlane çalıştırılıyor" "${PIPELINE_ID}" "0" "Fastlane çalıştırılıyor" "0xffff00"
    fastlane build
fi
