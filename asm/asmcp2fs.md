# Purpose: 
This script is an asmcmd helper for recursively listing and copying files. 

# Prereq: 
Shell environment set for ASM Oracle Home and asmcmd command available. This script makes use of asmcmd utility. This is usually accomplished by logging into the account that owns the ASM/GI binaries and running `. oraenv`

# Usage: 
* List all files from root of ASM: 
```
python asmcp2fs.py
```
* List all files in +DATAC1/MYDB directory and below
```
python asmcp2fs.py +DATAC1/MYDB
```
* Create commands to make regular filesystem directories and generate asmcmd cp commands to copy files to regular filesystem
```
python asmcp2fs.py +DATAC1/MYDB /u01/oradata
```
