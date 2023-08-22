#!/bin/sh

clean_up() {
    # Clean Up Terraform State Files
    find /terraform -regex "/terraform/\.*terraform.*" | xargs rm -rf
}

trap clean_up SIGTERM
trap clean_up SIGINT

sleep infinity &
wait
