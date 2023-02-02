# OrangePi Zero 2

The OrangePi Zero 2 board is a relatively in-expensive and accessible pi alternative. 
I am using it to run klipper for this printer.

## Connections

### Printer serial connection

To connect to the printer's mainboard, I am using UART 5 on the Pi.

#### Enabling UART5

To enable UART5, it must be added to the `overlays` in `/boot/orangepiEnv.txt`. Example:

```
overlays=uart5
```

#### Physical Connection

The phsyical connection between the the Pi and the main board is as follows:

| Pi       | PSU | Robin Nano v1.2 |
| -------- | --- | --------------- |
|          | 5v  |                 |
|          | GND |                 |
| UART5 TX |     |                 |
| UART5 RX |     |                 |

### ADXL345 (Work in progress)

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
