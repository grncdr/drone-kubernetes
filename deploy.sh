#!/bin/sh

echo '$1' | jq -r -f /make-shell-script.jq | sh

