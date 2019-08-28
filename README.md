# GlobeApp

[![Build Status](https://app.bitrise.io/app/fd484f140df74394/status.svg?token=Q6BBbhXb81p_UR_iyEh6hw&branch=master)](https://app.bitrise.io/app/fd484f140df74394)

This app was part of a coding challenge and shows a map and by **long-press** it opens a pop-up with the address of the selected location.
To fetch the selected location it uses the plain geocode-API from google without acessing the GoogleMaps-Framework (part of the task).

### Install

1. Create a new `env-vars.sh` file containing `export GOOGLE_MAPS=<<YOUR_API_KEY>>` in the app folder
    - Alternative: provide an environment variable with `GOOGLE_MAPS` containing your API-key
2. Use `pod install` to install all dependencies

*Step 1 is necessary to generate `ApiKeys.generated.swift` which holds all credentials. This helps to hide credentials and API-keys from the public.*
