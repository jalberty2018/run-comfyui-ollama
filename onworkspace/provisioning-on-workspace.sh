#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -f /workspace/provisioning.md ]]
then
	mv /provisioning.md /workspace/provisioning.md
else
	rm -f /provisioning.md
fi
