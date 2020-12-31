#!/bin/bash

su -c ./root.sh  # Assume we're not in sudoers to begin with
./user.sh $1
