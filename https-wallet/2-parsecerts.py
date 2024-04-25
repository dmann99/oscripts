#!/bin/python
import os

# Determine if we need to query certs from site
#if not os.path.isfile('certout.txt'):
#    sslcmd = 'openssl s_client -showcerts -servername '+sys.argv[1]+' -connect '+sys.argv[1]+':443 > certout.txt'
#    os.system(sslcmd)



# Read openssl s_client output from out.txt
with open("certout.txt") as file_in:
    lines = []
    for line in file_in:
        lines.append(line)

# Look for Cert blocks in out.txt
fileno = 1
lineno = 0
while lineno < len(lines):

    # Found beginning of a cert block, process it
    if "BEGIN CERTIFICATE" in lines[lineno]:
        f = open(format(fileno)+".cer","w")

        print(lines[lineno-2])
        print(lines[lineno-1])
        print(format(lineno)+"|"+lines[lineno])

        while "END CERTIFICATE" not in lines[lineno]:
            print(lines[lineno])
            f.write(lines[lineno])
            lineno += 1
        # END CERTIFICATE line
        print(lines[lineno])
        f.write(lines[lineno])
        f.close()
        fileno += 1


    lineno += 1

os.system('orapki wallet create -wallet . -pwd WalletPassword123 -auto_login')
#os.system('orapki wallet add -wallet . -trusted_cert -cert ./1.cer -pwd WalletPassword123')
#os.system('orapki wallet add -wallet . -trusted_cert -cert ./2.cer -pwd WalletPassword123')
os.system('orapki wallet add -wallet . -trusted_cert -cert ./3.cer -pwd WalletPassword123')
os.system('orapki wallet display -summary -wallet . -pwd WalletPassword123')
os.system('orapki wallet display -complete -wallet . -pwd WalletPassword123')

