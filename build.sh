#!/bin/bash -e

if ! type fastlane > /dev/null 2>&1; then
  if type brew > /dev/null 2>&1; then
    brew install fastlane@2.210.1
  else
    sudo gem install fastlane -NV -v 2.210.1
  fi
fi

#echo cocoapos version
echo "Cocoapods version: $(pod --version)"

#echo podfile.lock
cat Podfile.lock

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
    fi
    
    if ! type fastlane > /dev/null 2>&1; then
        echo "Fastlane is not installed. Please install fastlane to use fastlane with environment variables."
    fi
    fastlane --env ${FASTLANE_ENV} build
else
    echo "Running fastlane"
    fastlane build
fi
