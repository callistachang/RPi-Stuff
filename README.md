# RPi Config

## Contents

- [Model](#hardware-model)
- [Installation](#software-installation)
- [Vim](#vim)
- [Crontab](#crontab)
- [DuckDNS](#dynamic-dns)
- [Nginx](#nginx)
- [Docker](#docker)
- [Pi-hole](#pi-hole)
- [PiVPN](#pivpn)
- [Copying files via SCP](#scp)
- [Backups](#backups)

## Hardware Model

I have the Raspberry Pi 4 Model B Rev 1.2.

## Software Installation

I downloaded [Raspberry Pi OS](https://www.raspberrypi.org/software/operating-systems/) with desktop released on 2nd Dec 2020, and flashed the image to a micro SD card using BalenaEtcher. Then, I set it up with a monitor.

#### what if u don't have a monitor and you want to connect to wifi!

After flashing the image, add a file `wpa_supplicant.conf`:

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=<Insert 2 letter ISO 3166-1 country code here>

network={
    scan_ssid=1
    ssid="<Name of your wireless LAN>"
    psk="<Password for your wireless LAN>"
    proto=RSN
    key_mgmt=WPA-PSK
    pairwise=CCMP
    auth_alg=OPEN
}
```

and an empty file `ssh` to the root dir.

Assuming the RPi is connected to the computer (e.g. via USB) you are trying to ssh from, ssh using `ssh pi@raspberry.local` and input the password as `raspberry`. Then change your password from then on.

#### Enabling SSH

`sudo raspi-config` > Interface Options > SSH > Enable SSH

#### System updates

```
sudo apt-get update -y && sudo apt-get upgrade -y
```

## Vim

> :warning: This part is outdated. Please refer to my [dotfiles](https://github.com/callistachang/dotfiles) for my latest setup! :warning:

### Introduction

Vim is my main text editor for Linux systems.

```
sudo apt install vim
```

#### My .vimrc settings

These are my [.vimrc settings](.vimrc).

#### Package manager

I use Vundle as my Vim package manager.

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

I followed the quickstart instructions [here](https://github.com/VundleVim/Vundle.vim). To download a new package, I run the command `:PluginInstall`.

#### Sudo vim

To enable my .vimrc settings whenever I'm on sudo, I had to copy over my settings and download Vundle again.

```
sudo cp ~/.vimrc /root/.vimrc
sudo git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim
```

## Crontab

These are my [crontab settings](crontab). I used [cron.guru](https://crontab.guru/), it's a useful site to know how to write cron jobs the way you want it.

```
# edit cron jobs
crontab -e
# check up on your cron babies
sudo service cron [start|stop|restart|status]
```

## Dynamic DNS

### Introduction

A **dynamic IP address** is an IP address that changes from time to time (unlike a static IP address).

Most home networks have a dynamic IP address, because it allows internet service providers (ISPs) to recycle them, making it more cost-effective. This is done via a protocol called the Dynamic Host Configuration Protocol (DHCP). Your home network's IP address gets pulled from a pool of addresses and then assigned by your ISP. After a period of time, that IP address is put back into the pool and you are assigned a new IP address.

This is where **DDNS** comes in - a method of automatically updating a name server in the DNS.

### DuckDNS

[DuckDNS](https://www.duckdns.org/) provides a public DNS server that anyone can get a subdomain and use their scripts to update their records. Via a cron job, the RPi would send a HTTPS post to DuckDNS's central system to update it with its latest external IP.

#### Instructions

I logged in to DuckDNS with my GitHub account and created a subdomain `XXX.duckdns.org`. Under the 'install' tab, I clicked 'pi' under 'Operating Systems' and followed the instructions from there.

To check if DuckDNS's cronjob is still running, check `service cron status`.

### Port Forwarding (for SSH access via DuckDNS subdomain)

For my router, it is `192.168.3.1` on the browser > Settings > 安全设置 > NAT 服务 > 端口映射. There, I can set up port forwarding for all the ports I need to. I found my router's address by typing `ipconfig` on the command prompt and finding out the Default Gateway address.

## Nginx

### Installation

```
sudo apt install nginx
sudo service nginx start  # start the server
sudo service nginx status  # check how the server is doing
vim /etc/nginx/sites-available/default  # edit the nginx configuration
```

## Docker

> :warning: I'm no longer downloading Docker because my RPi is too weak to handle that. :warning:

I followed the instructions [here](https://phoenixnap.com/kb/docker-on-raspberry-pi) to download Docker onto my RPi.

### Docker Compose

And [here](https://sanderh.dev/setup-Docker-and-Docker-Compose-on-Raspberry-Pi/) for downloading Docker Compose.

These are the usual commands:

```
# Runs a docker-compose.yml file in the background
docker-compose up --detach

# Checks on the running containers
docker-compose ps

# Kills the running container
docker-compose kill
```

## Pi-hole

I downloaded Pi-hole the usual way: run `curl -sSL https://install.pi-hole.net | bash` and answered everything as recommended. I chose Cloudflare as my main DNS server.

Then, on my router (it's a Huawei router), I went to 我要上网 > 静态 DNS > set my RPi's IP address as the primary DNS > set what was initially the primary DNS address to the secondary DNS slot.

I followed the instructions here, where I downloaded [Wally3k's](https://firebog.net/) and [Developer Dan's](https://www.github.developerdan.com/hosts/) adlists, and [mmotti's regex list](https://github.com/mmotti/pihole-regex). I'll be trying [yubiuser's tool](https://github.com/yubiuser/pihole_adlist_tool) out to audit which lists are actually being used.

I also used [anudeepND's whitelist](https://github.com/anudeepND/whitelist).

Finally, I followed instructions via [Reddit post](https://www.reddit.com/r/pihole/comments/g9ytt9/youtube_some_success_ymmv_please_test/) and [Git repository](https://gitlab.com/grublets/youtube-updater-for-pi-hole) in order to minimize YouTube ads. I added a cron job to update the blocklist via editing my crontab file.

## PiVPN

`curl -L https://install.pivpn.io | bash`

Port forward the UDP port, not the TCP port.

## SCP

> Update: You can just use VSCode's remote server extension to drop files in and out.

Secure File Copy is used to copy files back and forth between my RPi and desktop. The format for SCP is `scp <from> <to>`, which I executed via the WSL command line.

```
# Copying my .vimrc file from my RPi to my Desktop
scp pi@callista.duckdns.org:~/.vimrc ./Desktop
```

## Clear Cache

`sudo sh -c "echo 1 > /proc/sys/vm/drop_caches"`

## Backups

### Introduction

I followed the instructions [here](https://magpi.raspberrypi.org/articles/back-up-raspberry-pi) which required me to download [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/). I plugged the micro SD card to my laptop and read the contents to an `.img` file. Backups are saved to a folder `/Desktop/RPi/backups`.

### Records

- 23/12/20 3:04PM: Initial setup, system updates, SSH access on raspi-config, DuckDNS cronjob, Docker installation
- 27/12/20 12:36 AM: Downloaded vim, included .vimrc settings, downloaded Vundle and ran PluginInstall (for both root and pi), changed hostname and password
- 28/12/20 1:22 PM: GOT [PI-HOLE](#pi-hole) WORKING
- 5/7/22 10:11 AM: Oh, wow, it's been a while! I now run Pi-hole, PiVPN, Netdata and Codeserver on my RPi. It's mostly for the Pi-hole, really. As for my .vimrc, it's outdated, I now use Neovim and [these are my configs](https://github.com/callistachang/dotfiles).
