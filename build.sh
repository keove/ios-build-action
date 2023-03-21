#!/bin/bash -e

echo "*"*100
echo "Current directory:"
pwd
echo "*"*100
echo "List of files:"
ls -la


#install fastlane
./discord.sh "Fastlane" "Fastlane kuruluyor" "1" "true" "Fastlane kuruluyor" "16711680" 

if ! type fastlane > /dev/null 2>&1; then
  if type brew > /dev/null 2>&1; then
    brew install fastlane@2.210.1
  else
    sudo gem install fastlane -NV -v 2.210.1
  fi
fi

#install bundler
./discord.sh "Bundler" "Bundler kuruluyor" "1" "true" "Bundler kuruluyor" "16711680"
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
        ./discord.sh "Bundler" "Bundler kurulamadı" "1" "true" "Bundler kurulamadı" "16711680"
    fi
    
    if ! type fastlane > /dev/null 2>&1; then
        echo "Fastlane is not installed. Please install fastlane to use fastlane with environment variables."
        ./discord.sh "Fastlane" "Fastlane kurulamadı" "1" "true" "Fastlane kurulamadı" "16711680"
    fi
    fastlane --env ${FASTLANE_ENV} build
else
    echo "Running fastlane"
    ./discord.sh "Fastlane" "Fastlane çalıştırılıyor" "1" "true" "Fastlane çalıştırılıyor" "16711680"
    fastlane build
fi
