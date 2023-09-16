#!/usr/bin/env bash

set -eEuo pipefail

tail -f /dev/null
exec reflex -s go run main.go
