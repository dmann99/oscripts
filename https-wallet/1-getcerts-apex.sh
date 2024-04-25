#!/bin/bash

openssl s_client -showcerts -servername dplinv.ondemand.sas.com -connect dplinv.ondemand.sas.com:443 > certout.txt



