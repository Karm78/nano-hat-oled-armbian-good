#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please re-run as root user."
  exit
fi

# Get dependencies from APT
apt -y install git python3 python3-libgpiod python3-pil python3-smbus fonts-dejavu

# Get the code
if [ -d "/tmp/nano-hat-oled-armbian" ]
then
  rm /tmp/nano-hat-oled-armbian -rf
fi
cd /tmp
git clone https://github.com/Karm78/nano-hat-oled-armbian-good
cd ./nano-hat-oled-armbian

# Setup rc.local
if ! grep -Fxq "cd /usr/share/nanohatoled && /usr/bin/nice -n 10 /usr/bin/python3 oled-start3.py &" /etc/rc.local
then
  sed -i -e '$i \cd /usr/share/nanohatoled && /usr/bin/nice -n 10 /usr/bin/python3 oled-start3.py &' /etc/rc.local
fi

# Make the program directory
if [ ! -d "/usr/share/nanohatoled" ]
then
  mkdir /usr/share/nanohatoled
fi

# Copy program files
mv oled-start3.py /usr/share/nanohatoled/
mv splash.png /usr/share/nanohatoled/

# Move to directory
cd /usr/share/nanohatoled/

# Compile the code
python3 -O -m py_compile oled-start3.py

# Start OLED
/usr/bin/nice -n 10 /usr/bin/python3 oled-start3.py &
