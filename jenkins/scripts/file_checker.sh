#! /usr/bin/env bash

C_DETECTED=0
JAVA_DETECTED=0
PYTHON_DETECTED=0
Javascript_DETECTED=0
BEFUNGE_DETECTED=0


if [ -f Makefile ]; then C_DETECTED=1; echo -n "C"; fi

if [ -f requirements.txt ]; then PYTHON_DETECTED=1; echo -n "PYTHON"; fi

if [ -f app/pom.xml ]; then JAVA_DETECTED=1 ;echo -n "JAVA"; fi

if [ -f package.json ]; then Javascript_DETECTED=1 ;echo -n "JAVASCRIPT"; fi

if [ -f app/main.bf ]; then BEFUNGE_DETECTED=1 ;echo -n "BEFUNGE"; fi

DETECTIONS=$((C_DETECTED+PYTHON_DETECTED+JAVA_DETECTED+Javascript_DETECTED+BEFUNGE_DETECTED))

if [ $DETECTIONS != 1 ];then
    echo $DETECTIONS
    echo "Fail to detect the technology of the repository"
    exit 1
fi
