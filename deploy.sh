#!/bin/bash

sudo apt update && sudo apt install git
git clone https://github.com/express42/reddit.git
cd reddit && bundle install
