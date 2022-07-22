# Labjack T7-Pro

## Sensor data monitoring device

- https://labjack.com/ljm 
- https://labjack.com/support/software/examples/ljm/python

- todo

-

## Install 

- Reference 

   https://labjack.com/support/software/installers/ljm


### Install LJM with kipling (Ubuntu 20.04 LTS, Linux, x86_64)

```bash
   $ wget https://labjack.com/sites/default/files/software/labjack_ljm_software_2019_07_16_x86_64.tar.gz
   $ tar -xvf labjack_ljm_software_2019_07_16_x86_64.tar.gz
   $ sudo ./labjack_ljm_installer.run

     - installs .so library files to `/usr/local/lib`
     - installs .h header files to `/usr/local/include`
     - installs LJM/Kipling files to `/usr/local/share`
     - sets up LabJack device rule files
     - sets up LabJack file permissions
     - installs Kipling to `/opt/labjack_kipling`
     - installs a Kipling command-line launcher `/usr/local/bin/labjack_kipling`
```

### Install python package

```bash
    $ python -m pip install labjack-ljm
```


## Sample code

### Read Serial Number

```python
from labjack import ljm

# Open first found LabJack
handle = ljm.openS("ANY", "ANY", "ANY")

# Call eReadName to read the serial number from the LabJack.
name = "SERIAL_NUMBER"
result = ljm.eReadName(handle, name)

print("\neReadName result: ")
print("    %s = %f" % (name, result))

```


### Read voltage

```python
from labjack import ljm

handle = ljm.openS("T7", "USB", "ANY")

# Read the voltage on AIN0
voltage = ljm.eReadName(handle, "AIN1")

print('voltage of AIN1 = ', voltage)
```


