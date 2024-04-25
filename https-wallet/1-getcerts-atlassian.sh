#!/bin/bash

openssl s_client -showcerts -servername sas-institute.atlassian.net -connect sas-institute.atlassian.net:443 > certout.txt

