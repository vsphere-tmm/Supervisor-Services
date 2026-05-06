#!/bin/bash
# Helper script to simulate job scheduling

while :
do
  kubectl create -f ${1}
  kubectl create -f ${2}
  sleep ${3:-10}
done
