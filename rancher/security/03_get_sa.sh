#!/bin/bash
kubectl get serviceaccount -n testing $1 -o jsonpath='{.secrets[0].name}'
