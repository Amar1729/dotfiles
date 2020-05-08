#! /usr/bin/env bash

# one-liner to generate list of packages installed by pipx

pipx list|grep package|awk '{print $2}'
