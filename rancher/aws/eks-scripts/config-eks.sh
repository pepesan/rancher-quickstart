#!/bin/bash
aws eks --region eu-west-3 \
 update-kubeconfig \
 --name $1
