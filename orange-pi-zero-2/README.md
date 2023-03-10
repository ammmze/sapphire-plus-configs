# OrangePi Zero 2

The OrangePi Zero 2 board is a relatively in-expensive and accessible pi alternative. 
I am using it to run klipper for this printer.

Manual provided by OrangePi can be found [here](https://drive.google.com/file/d/1T6ZbnrYIEGc89uKukrdOw8ESX8CYfmTY/view?usp=share_link).

## Connections

### Printer serial connection

To connect to the printer's mainboard, I am using UART 5 on the Pi.

#### Enabling UART5

To enable UART5, it must be added to the `overlays` in `/boot/orangepiEnv.txt`. Example:

```
overlays=uart5
```

#### Permissions

To ensure that device has the appropriate permissions to be used by klipper (and assuming that the user running klipper is in the `dialout` group), add a udev rule by creating the file `/etc/udev/rules.d/99-gpio.rules` with the following contents:

```
SUBSYSTEM=="gpio",NAME="gpiochip%n",OWNER="root",GROUP="dialout",MODE="0660"
```

#### Physical Connection

The phsyical connection between the the Pi and the main board is as follows:

| Pi       | PSU | Robin Nano v1.2 |
| -------- | --- | --------------- |
|          | 5v  |                 |
|          | GND |                 |
| UART5 TX |     |                 |
| UART5 RX |     |                 |

### ADXL345

An accelerometer can be used to measure resonances in the printer. 
This Pi board provides an SPI (serial peripheral interface) that can be used to connect to
an ADXL345 accelerometer.

#### Enabling SPI1

To enable SPI1, it must be added to the `overlays` in `/boot/orangepiEnv.txt` along with a couple of params. Example:

```
overlays=spi-spidev spi-add-cs1
param_spidev_spi_bus=1
param_spidev_spi_cs=1
```

> Not sure `spi-add-cs1` was required. I added it before I had found the manual and was having issues and then found those `param_*` options that were needed.

#### Permissions

To ensure that device has the appropriate permissions to be used by klipper (and assuming that the user running klipper is in the `dialout` group), add a udev rule by creating the file `/etc/udev/rules.d/99-spidev.rules` with the following contents:

```
SUBSYSTEM=="spidev",NAME="spidev%n.%n",OWNER="root",GROUP="dialout",MODE="0660"
```

#### Physical Connection

The phsyical connection between the the Pi and the ADXSL345 is as follows:

| Pi   | ADXL345 |
| ---- | ------- |
| 5v*  | VCC     |
| GND  | GND     |
| CS   | CS      |
| MOSI | SDA     |
| MISO | SCO     |
| CLK  | SCL     |

> _5v*_ ... I think some ADXL345 modules require less than 5v, so you may want to connect to the 3.3v pin instead.

#### Klipper config

To configure klipper to use the ADXL345 connected to the Orange Pi Zero 2, use the following config:
```ini
[adxl345]
cs_pin: host:None
spi_speed: 5000000
spi_bus: spidev1.1
```
