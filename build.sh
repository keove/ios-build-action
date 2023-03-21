#!/bin/bash -e

# Dizinimizi bir değişkene atıyoruz
directory="/Users/runner/work/_actions/keove/ios-build-action/v2.2.5/dist/../"

# build.sh dosyasını ekleyerek tam dizin oluşturuyoruz
full_path="${directory}discord.sh"
 

#install fastlane
bash "$full_path" "$GITHUB_REPOSITORY [${GITHUB_REF##*/}] #$GITHUB_RUN_NUMBER" "Fastlane kuruluyor" "Trippy-Dev-Android" "true" "Fastlane kuruluyor" "16711680" 

if ! type fastlane > /dev/null 2>&1; then
  if type brew > /dev/null 2>&1; then
    brew install fastlane@2.210.1
  else
    sudo gem install fastlane -NV -v 2.210.1
  fi
fi

#install bundler
bash "$full_path" "$GITHUB_REPOSITORY [${GITHUB_REF##*/}] #$GITHUB_RUN_NUMBER" "Bundler kuruluyor" "Trippy-Dev-Android" "0" "Bundler kuruluyor" "16711680"
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
        bash "$full_path" "$GITHUB_REPOSITORY [${GITHUB_REF##*/}] #$GITHUB_RUN_NUMBER" "Bundler kurulamadı" "Trippy-Dev-Android" "0" "Bundler kurulamadı" "16711680"
    fi
    
    if ! type fastlane > /dev/null 2>&1; then
        echo "Fastlane is not installed. Please install fastlane to use fastlane with environment variables."
        bash "$full_path" "$GITHUB_REPOSITORY [${GITHUB_REF##*/}] #$GITHUB_RUN_NUMBER" "Fastlane kurulamadı" "Trippy-Dev-Android" "0" "Fastlane kurulamadı" "16711680"
    fi
    fastlane --env ${FASTLANE_ENV} build
else
    echo "Running fastlane"
    bash "$full_path" "$GITHUB_REPOSITORY [${GITHUB_REF##*/}] #$GITHUB_RUN_NUMBER" "Fastlane çalıştırılıyor" "Trippy-Dev-Android" "0" "Fastlane çalıştırılıyor" "16711680"
    fastlane build
fi
