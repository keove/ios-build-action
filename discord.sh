#!/bin/bash

baseUrl="https://discordwk.keove.com/discord"

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


