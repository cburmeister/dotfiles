#!/bin/bash

VIRTUALENVS=($(workon))

for NAME in "${VIRTUALENVS[@]}"
do
    workon "$NAME"
    pip install --upgrade pip
done
