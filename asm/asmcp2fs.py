# David Mann
# asmcp2fs.py
# 07-AUG-2016

# Purpose:
# asmcmd helper for

# Prereq:
# Shell environment set for ASM Oracle Home and asmcmd command available.
# This script makes use of asmcmd utility.
#
# Usage:
# List all files from root of ASM:
#   script.py
# List all files in +DATAC1 directory and below
#   script.py +DATAC1
# Create commands to make regular filesystem directories and generate asmcmd
# cp commands to copy files to regular filesystem
#   script.py #DATAC1/MYDB /u01/oradata

import string
import subprocess
import sys

def main():
  global pushdirlist
  global pushcommandlist
  pushdirlist  = []
  pushcommandlist = []

  # No Parameters, List dirs recursively starting at ASM root
  if (len(sys.argv) == 1):
    getdirlist('')
  # 1 Parameter : List dirs recursively starting at supplied directory
  if (len(sys.argv) == 2):
    getdirlist(sys.argv[1]+'/')
  # 2 Parameters : Create copy commands from source to dir
  if (len(sys.argv) == 3):
    getdirlist(sys.argv[1]+'/')

#  for i in pushdirlist:
#    print(i)
  for i in pushcommandlist:
    print(i)



def pushdir(dirpath):
  pushdirlist.append("mkdir -p "+dirpath)



def pushcommand(cmd):
  pushcommandlist.append(cmd)



def getdirlist(path):
  #print("asmcmd ls " + path)
  p = subprocess.Popen("asmcmd ls " + path, stdout=subprocess.PIPE, shell=True)
  (output, err) = p.communicate()
  dirlist= string.split(output,'\n')
  for entry in dirlist:
    if (entry != ''):
      finalpath=path+entry
      if (entry.endswith('/')):
        if (len(sys.argv)==3):
#          pushdir(finalpath.replace(sys.argv[1],sys.argv[2]))
          print('mkdir -p '+finalpath.replace(sys.argv[1],sys.argv[2]))
        getdirlist(finalpath)
      else:
        if (len(sys.argv)==3):
          pushcommand('asmcmd cp '+finalpath+' '+finalpath.replace(sys.argv[1],sys.argv[2]))
        else:
          print(finalpath)
          #pushcommand(finalpath)



main()
