import socket
import subprocess
import sys
from datetime import datetime

subprocess.call('cls', shell=True)

remoteServer = raw_input("Enter a remote host to scan: ")
remoteServerIP = socket.gethostbyname(remoteServer)

print "-" * 60
print "Please wait, scanning in progress", remoteServerIP
print "-" * 60

t1 = datetime.now()

try:
    for port in range(1,1025):
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        result = sock.connect_ex((remoteServerIP, port))
        if result == 0:
            print "Port {}:     Open".format(port)
        sock.close()
        
except KeyboardInterrupt:
    print "User Terminated Process"
    sys.exit()

except socket.gaierror:
    print "Hostname could not be resolved."
    sys.exit()

except socket.error:
    print "Could not connect to server"
    sys.exit()

t2 = datetime.now()

total = t2 - t1

print "Scanning Completed in: ", total
