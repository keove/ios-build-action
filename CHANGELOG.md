# Change Log

## [2.1.0] - 2023-01-30

### Added

- `fastlane-env` (optional) input: Name of the env file name to pass to fastlane --env
- `ios-app-id` (optional) input: The iOS application identifier; useful to sync a specific provisioning profile

## [2.0.0] - 2022-10-06

Redesign of the Fastlane build and certificate handling.

### Breaking

- This version uses `Match` so you cannot use base64 version of the certificates, instead you need to have a GitHub repo that match will use to store the certificates and an Apple app key. Follow the README to see the new parameters list.
