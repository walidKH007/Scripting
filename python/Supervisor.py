#!/usr/bin/python

import os
import psutil
from hurry.filesize import size
from paramiko import SSHClient, AutoAddPolicy, RSAKey
from paramiko.auth_handler import AuthenticationException, SSHException
import pysftp

#####################Uptime.py##############################""
#----------------------------------------
# Gives a human-readable uptime string
def uptime():

     try:
         f = open( "/proc/uptime" )
         contents = f.read().split()
         f.close()
     except:
        return "Cannot open uptime file: /proc/uptime"

     total_seconds = float(contents[0])

     # Helper vars:
     MINUTE  = 60
     HOUR    = MINUTE * 60
     DAY     = HOUR * 24

     # Get the days, hours, etc:
     days    = int( total_seconds / DAY )
     hours   = int( ( total_seconds % DAY ) / HOUR )
     minutes = int( ( total_seconds % HOUR ) / MINUTE )
     seconds = int( total_seconds % MINUTE )

     # Build up the pretty string (like this: "N days, N hours, N minutes, N seconds")
     string = ""
     if days > 0:
         string += str(days) + " " + (days == 1 and "day" or "days" ) + ", "
     if len(string) > 0 or hours > 0:
         string += str(hours) + " " + (hours == 1 and "hour" or "hours" ) + ", "
     if len(string) > 0 or minutes > 0:
         string += str(minutes) + " " + (minutes == 1 and "minute" or "minutes" ) + ", "
     string += str(seconds) + " " + (seconds == 1 and "second" or "seconds" )

     return string;

print ("The system uptime is:" + uptime())
#######################Memory#############

mem = psutil.virtual_memory()

print (mem[1])

print ("Memory Available : " + size(mem[1]))

print ("Memory Used : "+ size(mem[3]))

print ("Memory Free : "+ size(mem[4]))


################CPU##############################

CPU_Pct=str(round(float(os.popen('''grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage }' ''').readline()),2))

#CPU usage####
print("CPU Usage = " + CPU_Pct)

info = "\nThe system uptime is : "+uptime()+"\nMemory Available : "+size(mem[1])+"\nMemory Used : "+size(mem[3])+"\nMemory Free : "+size(mem[4])+"\nCPU Usage = "+str(CPU_Pct)+" % \n\nDisk usage : \n\n"


with open("info-client2.txt","wb") as f:
        f.write(info)


#####disk details####

os.system("df -h >> info-client2.txt")

###### 3 top process #######


os.system("echo '\n\ntop 3 cpu process\n\n' >> info-client2.txt")

os.system("ps aux --sort=-%cpu | head -4 | awk '{ print $1 \" :  \" $11 }' >> info-client2.txt")

os.system("echo '\n\ntop 3 Memory process\n\n' >> info-client2.txt")


os.system("ps aux --sort=-%mem | head -4 | awk '{ print $1 \" :  \" $11 }' >> info-client2.txt")


with pysftp.Connection('172.18.10.17', username='root', password='walid') as sftp:
    with sftp.cd('/root'):             # temporarily chdir to public
        sftp.put('info-client2.txt')  # upload file to public/ on remote
        #sftp.get('remote_file')         # get a remote file
