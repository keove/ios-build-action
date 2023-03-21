#!/bin/bash

baseUrl="http://10.10.10.8:8011/discord"

project_name="$1"
message="$2"
projectId="$3"
start="$4"
description="$5"
color="$6"


# Sunucuya POST isteği gönder
curl --location --request POST "${baseUrl}" \
--header 'Content-Type: application/json' \
--data-raw '{
    "data": {
        "project": "'"${project_name}"'",
        "message": "'"${message}"'",
        "projectId": "'"${projectId}"'",
        "start": "'"${start}"'",
        "description": "'"${description}"'",
        "color": "'"${color}"'"
    }
}' --insecure --silent


