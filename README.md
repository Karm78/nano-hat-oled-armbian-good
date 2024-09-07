# NanoHAT OLED for Armbian - Python3
NanoHAT OLED and GPIO Button Control for Armbian. This documentation contains installation and upgrade instructions.

## Disclaimer

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## Getting Started

### Prerequisites

### This is a fork from the original project : https://github.com/crouchingtigerhiddenadam/nano-hat-oled-armbian
Was 2 mistake, this \ left in python code and change package tts-dejavu by the newest -> fonts-dejavu


This guide assumes you are using Armbian Bookworm. If you know what you're doing, this program can work on other releases too.

Enable i2c0:
```
sudo nano /boot/armbianEnv.txt
```
Add `i2c0` to the `overlays=` line, for example if the line appears as follows:
```
overlays=usbhost1 usbhost2
```
Then add `i2c0` with a space seperating it from the other values:
```
overlays=i2c0 usbhost1 usbhost2
```
Save these changes by pressing `ctrl+x`, `ctrl+y` and `enter` as prompted at the bottom of the screen.  
    
Reboot the system for the changes to take effect:
```
sudo reboot now
```

### Dependencies
Install the dependences from APT:
```
sudo apt -y install \
  git \
  python3 \
  python3-libgpiod \
  python3-pil \
  python3-smbus \
  ttf-dejavu
```

### Get the Code
Clone from GitHub:
```
cd /tmp
git clone https://github.com/Karm78/nano-hat-oled-armbian-good/
```

Run the code (optional):
```
cd /tmp/nano-hat-oled-armbian
python3 oled-start3.py
```
Use `ctrl+c` to terminate.

### Install
Make the program directory:
```
sudo mkdir /usr/share/nanohatoled
```
Copy the program files:
```
sudo mv /tmp/nano-hat-oled-armbian/oled-start3.py /usr/share/nanohatoled/
sudo cp /tmp/nano-hat-oled-armbian/splash.png /usr/share/nanohatoled/
```
Compile the code:
```
python3 -O -m py_compile oled-start3.py
```
Edit `rc.local`:
```
sudo nano /etc/rc.local
```
Then find the line:
```
exit 0
```
And add `cd /usr/share/nanohatoled` and `/usr/bin/nice /usr/bin/python3 -n 10 oled-start3.py &` before `exit 0` so the lines look like this:
```
cd /usr/share/nanohatoled && /usr/bin/nice -n 10 /usr/bin/python3 oled-start3.py &
exit 0
```
Save these changes by pressing `ctrl+x`, `ctrl+y` and `enter` as prompted at the bottom of the screen.   
   
Compile the code:
```
cd /tmp/nano-hat-oled-armbian
python3 -O -m py_compile oled-start3.py
```
Reboot the system for the changes to take effect.
```
sudo reboot now
```

## Upgrade from Previous Versions
Get the latest code:
```
cd /tmp
git clone https://github.com/crouchingtigerhiddenadam/nano-hat-oled-armbian
```
Compile the code:
```
cd /tmp/nano-hat-oled-armbian
python3 -O -m py_compile oled-start3.py
```
Remove files from the previous version:
```
sudo rm /usr/share/nanohatoled/* -r
```
Copy the lastest version into place:
```
sudo mv /tmp/nano-hat-oled-armbian/oled-start3.py /usr/share/nanohatoled/
sudo mv /tmp/nano-hat-oled-armbian/splash.png /usr/share/nanohatoled/
```
Edit `rc.local`:
```
sudo nano /etc/rc.local
```
Then find the line:
```
exit 0
```
If required, change `cd /usr/share/nanohatoled & /usr/bin/nice /usr/bin/python -n 10 oled-start.pyo &` before `exit 0` so the lines look like this:
```
cd /usr/share/nanohatoled && /usr/bin/nice -n 10 /usr/bin/python3 oled-start3.py &
exit 0
```
Save these changes by pressing `ctrl+x`, `ctrl+y` and `enter` as prompted at the bottom of the screen.   
  
Compile the code:
```
cd /tmp/nano-hat-oled-armbian
python3 -O -m py_compile oled-start3.py
```
Reboot the system for the changes to take effect.
```
sudo reboot now
```

## Troubleshooting

### Compatibility with BakeBit and NanoHatOLED
This does not require the FriendlyARM BakeBit or NanoHatOLED software to be installed. If this has already been installed you will need disable it.
```
sudo nano /etc/rc.local
```
Then find the lines:
```
/usr/local/bin/oled-start
exit 0
```
And comment out the `oled-start` line by adding `#` at the start of the line, so the lines look like this:
```
# /usr/local/bin/oled-start
exit 0
```
Save these changes by pressing `ctrl+x`, `ctrl+y` and `enter` as prompted at the bottom of the screen.   
   
Reboot the system for the changes to take effect.
```
sudo reboot now
```

## Appendix

### Experimental Quick Install and Update
   
Enable the i2c0 by changing `/boot/armbianEnv.txt` and reboot.   
   
After reboot, run the following command:
```
sudo wget -O - \
  https://raw.githubusercontent.com/Karm78/nano-hat-oled-armbian-good/blob/primary/install3.sh | \
  sudo bash -
```
The command can be used to make a fresh installation or update an existing installation to the latest version.
   
Reboot the system for the changes to take effect:
```
sudo reboot now
```
