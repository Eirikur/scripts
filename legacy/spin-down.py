#!/usr/bin/python3
import subprocess
boot_drive = 'sda'
idle_time = 12 # units of 5 seconds up to value of 240

# Drives only, name and rotary (physical hdd) flag output only
lsblk_out = subprocess.check_output(["lsblk", "--list", "-d", "-o", "name,rota"])
text = lsblk_out.decode('utf-8').split('\n')[1:] # skip header
for line in text:
            if line:
               name, rotary = line.split() # Rotary was not reliable
               if name != boot_drive:
                  device_name = "/dev/" + name
                  cmd = ['sudo', 'hdparm', '-S', str(idle_time), device_name]
                  print(' '.join(cmd))
                  subprocess.run(cmd,
                                 # shell=True,
                                 check=True,
                                 stdout=subprocess.DEVNULL,
                                 stderr=subprocess.DEVNULL,)
