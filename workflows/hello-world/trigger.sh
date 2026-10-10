#!/bin/sh

# Start the hello-world workflow, wait for it to complete and print the result.
set -eu

exec temporal workflow execute \
  --type hello-world \
  --task-queue zigflow
