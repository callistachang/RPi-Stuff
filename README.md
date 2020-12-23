# RPi-Stuff

## Contents

- [Installation](#installation)
- [DuckDNS](#dynamic-dns)
- [Docker](#docker)
- [Pi-hole](#pi-hole)
- [PiVPN](#pivpn)
- [Backups](#backups)

## Installation

I downloaded [Raspberry Pi OS](https://www.raspberrypi.org/software/operating-systems/) with desktop, and flashed the image to a micro SD card using BalenaEtcher. Then, I set it up with a monitor.

#### SSH access

`sudo raspi-config` > Interface Options > SSH

#### System updates

Before doing anything, I ran `sudo apt-get update -y && sudo apt-get upgrade -y` on the terminal.

## Dynamic DNS

### Introduction

A **dynamic IP address** is an IP address that changes from time to time (unlike a static IP address). 

Most home networks have a dynamic IP address, because it allows internet service providers (ISPs) to recycle them, making it more cost-effective. This is done via a protocol called the Dynamic Host Configuration Protocol (DHCP). Your home network's IP address gets pulled from a pool of addresses and then assigned by your ISP. After a period of time, that IP address is put back into the pool and you are assigned a new IP address.

This is where **DDNS** comes in - a method of automatically updating a name server in the DNS. 

### DuckDNS

**[DuckDNS](https://www.duckdns.org/)** provides a public DNS server that anyone can get a subdomain and use their scripts to update their records. Via a cron job, the RPi would send a HTTPS post to DuckDNS's central system to update it with its latest external IP.

#### Instructions

I logged in to DuckDNS with my GitHub account and created a subdomain `callista.duckdns.org`. Under the 'install' tab, I clicked 'pi' under 'Operating Systems' and followed the instructions from there.

To check if DuckDNS's cronjob is still running, check `service cron status`.

### Port Forwarding (for SSH access via DuckDNS subdomain)

`192.168.3.1` on the browser > Settings > 安全设置 > NAT 服务 > 端口映射. There, I can set up port forwarding for port 22 (or any other port, really). I found my router's address by typing `ipconfig` on the command prompt and finding out the Default Gateway address.

Now, I can SSH to my RPi via PuTTY, with `callista.duckdns.org` as my IP address.

## Docker

I followed the instructions [here](https://phoenixnap.com/kb/docker-on-raspberry-pi) to download Docker onto my RPi.

## Pi-hole

## PiVPN

## Backups

### Introduction

I followed the instructions [here](https://magpi.raspberrypi.org/articles/back-up-raspberry-pi) which required me to download [Win32 Disk Imager](https://sourceforge.net/projects/win32diskimager/). I plugged the micro SD card to my laptop and read the contents to an `.img` file. Backups are saved to a folder `/Desktop/RPi/backups`.

### Records

- 23/12/20 3:04PM: Initial setup, system updates, SSH access on raspi-config, DuckDNS cronjob, Docker installation
