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

### Examples


- Download examples

```bash
    $ wget https://labjack.com/sites/default/files/software/Python_LJM_2020_11_20.zip
    $ unzip Python_LJM_2020_11_20.zip
```


- Check examples 

```bash

    $ tree Python_LJM_2020_11_20/Examples


Examples/
├── Basic
│   ├── eAddresses.py
│   ├── eNames.py
│   ├── eReadAddress.py
│   ├── eReadAddresses.py
│   ├── eReadName.py
│   ├── eReadNames.py
│   ├── eWriteAddress.py
│   ├── eWriteAddresses.py
│   ├── eWriteName.py
│   ├── eWriteNames.py
│   └── write_read_loop_with_config.py
└── More
    ├── 1-Wire
    │   └── 1_wire.py
    ├── AIN
    │   ├── dual_ain_loop.py
    │   ├── single_ain.py
    │   └── single_ain_with_config.py
    ├── Config
    │   ├── read_config.py
    │   ├── read_device_name_string.py
    │   ├── write_device_name_string.py
    │   └── write_power_config.py
    ├── DIO
    │   ├── single_dio_read.py
    │   └── single_dio_write.py
    ├── DIO_EF
    │   └── dio_ef_config_1_pwm_and_1_counter.py
    ├── Ethernet
    │   ├── read_ethernet_config.py
    │   ├── read_ethernet_mac.py
    │   └── write_ethernet_config.py
    ├── I2C
    │   └── i2c_eeprom.py
    ├── List_All
    │   └── list_all.py
    ├── Lua
    │   └── lua_execution_control.py
    ├── SD
    │   ├── __init__.py
    │   ├── change_directory.py
    │   ├── delete_file.py
    │   ├── get_disk_info.py
    │   ├── list_directory.py
    │   ├── print_working_directory.py
    │   ├── read_file.py
    │   └── sd_util.py
    ├── SPI
    │   └── spi.py
    ├── Stream
    │   ├── advanced_aperiodic_stream_out.py
    │   ├── ljm_stream_util.py
    │   ├── periodic_stream_out.py
    │   ├── stream_basic.py
    │   ├── stream_basic_with_stream_out.py
    │   ├── stream_burst.py
    │   ├── stream_callback.py
    │   ├── stream_in_with_aperiodic_stream_out.py
    │   ├── stream_sequential_ain.py
    │   └── stream_triggered.py
    ├── Testing
    │   ├── auto_reconnect_test.py
    │   └── c-r_speed_test.py
    ├── Watchdog
    │   ├── read_watchdog_config.py
    │   └── write_watchdog_config.py
    └── WiFi
        ├── read_wifi_config.py
        ├── read_wifi_mac.py
        ├── read_wifi_rssi.py
        └── write_wifi_config.py

```
