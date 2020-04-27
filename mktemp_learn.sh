#!/bin/bash

trap 'rm -f "$TEMPFILE"' EXIT

TEMPFILE=$(mktemp) || exit 1

ls -l $TEMPFILE








