#!/bin/bash

openssl s_client -showcerts -servername google.com -connect google.com:443 > certout.txt

