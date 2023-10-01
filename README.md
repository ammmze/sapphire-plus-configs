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
