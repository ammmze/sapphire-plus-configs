# sapphire-plus-configs

## Setup

1. Install MainsailOS onto SD card using Raspberry Pi Imager. Be sure to configure network in the imager for easy connection once you boot off the SD card.
2. Install SD card in the Pi
3. Boot the pi and wait for it to come online and get an ip address.
4. SSH into the pi.
5. Install 1password cli and chezmoi. TODO: links
6. Apply chezmoi configs
  ```shell
  chezmoi init --apply ammmze/sapphire-plus-configs
  ```
  > Note: still may have some quirks with installs to add some klipper plugins
7. Restart the relevant services
  ```shell
  sudo systemctl restart moonraker.service klipper.service crowsnest.service sonar.service
  ```

## Flashing notes

### Robin Nano 1.2

* STM32F103
* 28KiB bootloader
* USART1 PA10/PA9
* GPIO pins to set at micro-controller startup "!PC6,!PD13" to turn off display at startup

```shell
cd ~/klipper
make clean KCONFIG_CONFIG=config.robin-nano1.2 OUT=out.robin-nano1.2/
make menuconfig KCONFIG_CONFIG=config.robin-nano1.2 OUT=out.robin-nano1.2/
make KCONFIG_CONFIG=config.robin-nano1.2 OUT=out.robin-nano1.2/ -j4
./scripts/update_mks_robin.py out.robin-nano1.2/klipper.bin out.robin-nano1.2/Robin_nano.bin
```

> # Copy the file out/Robin_nano*.bin (if you can't find the file the script was not executed)
> # to an SD card and then restart the printer with that SD card.
> # If you removed the LCD screen rename the file to "Robin_nano43.bin" or "Robin_nano.bin" for correct flashing.
> Personally on my SP5 w/o LCD screen I needed it to be "Robin_nano.bin"

### Compile and flash katapult

#### Mellow SHTv2

```shell
cd ~/katapult
make clean KCONFIG_CONFIG=.shtv2.config OUT=shtv2.out/
make menuconfig KCONFIG_CONFIG=.shtv2.config OUT=shtv2.out/
make KCONFIG_CONFIG=.shtv2.config OUT=shtv2.out/ -j4
sudo service klipper stop
sudo dfu-util -a 0 -D ~/katapult/shtv2.out/katapult.bin --dfuse-address 0x08000000:force:mass-erase:leave -d 314b:0106
# proceed to compile/flash klipper
```

### EasyBRD

```shell
cd ~/katapult
make clean KCONFIG_CONFIG=config.ercfv1.1 OUT=out.ercfv1.1/
make menuconfig KCONFIG_CONFIG=config.ercfv1.1 OUT=out.ercfv1.1/
make KCONFIG_CONFIG=config.ercfv1.1 OUT=out.ercfv1.1/ -j4
sudo service klipper stop
sudo make KCONFIG_CONFIG=config.ercfv1.1 OUT=out.ercfv1.1/ flash FLASH_DEVICE=314b:0106
# proceed to compile/flash klipper
```

### Compile and flash klipper

#### Mellow SHTv2

```shell
cd ~/klipper
make clean KCONFIG_CONFIG=.shtv2.config OUT=shtv2.out/
make menuconfig KCONFIG_CONFIG=.shtv2.config OUT=shtv2.out/
make KCONFIG_CONFIG=.shtv2.config OUT=shtv2.out/ -j4
sudo service klipper stop
python3 ~/katapult/scripts/flashtool.py -i can0 -f ~/klipper/shtv2.out/klipper.bin -u 333ba2572085 -v
sudo service klipper start
```


### EasyBRD


```shell
cd ~/klipper
make clean KCONFIG_CONFIG=config.ercfv1.1 OUT=out.ercfv1.1/
make menuconfig KCONFIG_CONFIG=config.ercfv1.1 OUT=out.ercfv1.1/
make KCONFIG_CONFIG=config.ercfv1.1 OUT=out.ercfv1.1/ -j4
sudo service klipper stop
python3 ~/katapult/scripts/flashtool.py -i can0 -f ~/klipper/out.ercfv1.1/klipper.bin -u 6e0a60194b42 -v
sudo service klipper start
```