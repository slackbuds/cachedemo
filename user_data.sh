#!/bin/sh

apt-get update
apt-get upgrade -y
apt-get install -y valkey
apt-get autoremove
