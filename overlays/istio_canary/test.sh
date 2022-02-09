#!/usr/bin/env bash

URL="https://REDACTED"

seq 10 | xargs -Iz curl -s $URL | rg title | rg "httpbin|tornado" | rg -v "h2"
