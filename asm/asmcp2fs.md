# Purpose: 
This script is an asmcmd helper for recursively listing and copying files. 

# Prereq: 
Shell environment set for ASM Oracle Home and asmcmd command available. This script makes use of asmcmd utility. 

# Usage: 
* List all files from root of ASM: 
script.py
* List all files in +DATAC1 directory and below
script.py +DATAC1
* Create commands to make regular filesystem directories and generate asmcmd cp commands to copy files to regular filesystem
script.py #DATAC1/MYDB /u01/oradata
