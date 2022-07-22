from labjack import ljm

handle = ljm.openS("T7", "USB", "ANY")

# Read the voltage on AIN0
voltage = ljm.eReadName(handle, "AIN0")

print("voltage of AIN0 = ", voltage)

