# Raspberry Pi 4 Setup

## Boot Config

### UART/Serial

If using MainsailOS, these configurations are already done.

In order to use serial communication with the MCU, we need to ensure UART is enabled to put
pins 8 and 10 into UART/serial mode. This is done by adding `enable_uart=1` to `/boot/config.txt`.

It is also commonly mentioned that bluetooth needs to be disabled, which is done by adding
`dtoverlay=disable-bt` to `/boot/config.txt`.

### SPI

To use an accelerometer for input shaper, you would need to enable SPI by adding `dtparam=spi=on`
to `/boot/config.txt`. Again MainsailOS has it configured this way by default. In my setup, I am
now using a can bus board at my hotend and am using the accelerometer built-in to the board. So
this configuration is not needed for my setup.

## Pins

| Pin | Name    | Usage |
| --- | ------- | ----- |
|   4 | 5V      | Connect to PSU. |
|   5 | GPIO 3  | Connect to power button for power control. This pin when pulled low, will power on the pi. |
|   4 | GND     | Connect to PSU. |
|   7 | GPIO 4  | ~Undecided whether I will implement this...not sure I want it to be so easy to power off unless it can be blocked by an active print job. Connect to same power button as GPIO 3. When pulled low, start soft power off.~ |
|   8 | UART TX | Serial Connection to printer mainboard. Should be available at `/dev/ttyAMA0`. |
|   9 | GND     | ~Connect to power button. Used to pull GPIO 3 and 4 when button is pressed.~ |
|  10 | UART RX | Serial Connection to printer mainboard. Should be available at `/dev/ttyAMA0`. |
|  14 | GND     | ~Connect to MCU to ensure same ground between pi and mcu for stable serial communication.~ |
|  15 | GPIO 22 | Connect to relay board. Controls the 24v PSU. |
|  17 | 3.3V    | Connect to relay board. |
|  20 | GND     | Connect to relay board. |


# USB Wifi

Because the pi is in the metal enclosed bottom, the built-in wifi is terrible. It does appear possible to modify the pi to add an external antenna connector, but I've currently opted to use a USB wifi adapter. However, having both built-in (wlan0) and USB wifi adapter (wlan1) configured did not work correctly. The built-in adapter still more/less functioned but the USB adapter would constantly "de-auth" itself and routing was all funky. To disable wlan0, I added `denyinterfaces wlan0` to `/etc/dhcpcd.conf` and then `sudo systemctl restart dhcpcd`.
