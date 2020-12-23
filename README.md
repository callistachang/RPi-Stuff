# RPi-Stuff

## Contents

-  [Installation](#installation)
-  [DuckDNS](#dynamic-dns)
-  [Docker](#docker)
-  [Pi-hole](#pi-hole)
-  [PiVPN](#pivpn)

## Installation

I downloaded [Raspberry Pi OS](https://www.raspberrypi.org/software/operating-systems/) with desktop, and flashed the image to a micro SD card using BalenaEtcher. I put it into the RPi and set it up with a monitor.

#### Enabling SSH

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

### Port Forwarding (for SSH access)

`192.168.3.1` on the browser > Settings > 安全设置 > NAT 服务 > 端口映射. There, I can set up port forwarding for port 22 (or any other port, really). I found my router's address by typing `ipconfig` on the command prompt and finding out the Default Gateway address.

Now, I can SSH to my RPi via PuTTY, with `callista.duckdns.org` as my IP address.

## Docker

## Pi-hole

## PiVPN
