#!/usr/bin/python3
# Push a file to the remote version of working directory.  Strip home off.
# 6 Aug 2019, added -z to enable compression
# echo "Sending $1"
# time rsync --times --update --stats --archive --partial --partial-dir=~/.rsync-partial
import os
import sys
import subprocess

from pathlib import Path


source = sys.argv[1] 
directory = os.path.basename(os.getcwd())
local_target=Path("/media/eh/Internal Tank/")
cloud_target="9185@usw-s009.rsync.net:"
lan_target=""

def do_rsync(source: str, destination: str)->bool:
    # os.makedirs(destination, exist_ok=True)
    print(f"{source} | {destination}")

class Rsync():
    def __init__(self: object, source: str, dest:str)->None:
        self.process = subprocess.Popen(['rsync', '-av', '--progress', '--info=progress2',
                                         source,
                                         dest],
                                         stdout=subprocess.PIPE)
        return
                                        
    def read(self)->bool:
        for line in self.process.stdout:
            line = line.decode('utf-8')
            line = line.strip().split()
            if len(line) == 6:
                minutes, seconds, millis = line[3].split(':')
                for item in minutes, seconds, millis:
                    item = int(item)
                remaining = minutes + seconds
                print(f"Remaining: {remaining}")
            print(line)
            
                                        
                                    
    

for destination in [local_target, lan_target, cloud_target]:
              if destination: # is not empty
                 destination=os.path.abspath(destination)
                 print(destination)
                 do_rsync(source, destination)

