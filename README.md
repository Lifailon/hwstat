## hwstat

Function collecting hardware and software statistic from different sources in the operating system for output in one place.

It is convenient for the system administrator to get all the information quickly without having to remember all the commands and filter the output.

Tested by Ubuntu Server 20.04 and 22.04 and Hypervisor VMware

### Sources of data collection:

- uname
- uptime
- systemd
- timedatectl
- systemctl
- lsb_release
- lscpu
- dmidecode **(use root permission)**
- ps
- loadavg
- vmstat
- vmstat
- free
- meminfo
- swapon
- sysctl
- lspci
- lsblk
- df
- lvm **(use root permission)**
- ethtool
- resolvectl
- networkctl
- lsof **(for full output use root permission)**
- du **(for full output use root permission)**
- limits
- ss
- iptables **(use root permission)**
- ufw **(use root permission)**
- apt
- dpkg
- snap
- version

### Example:

```bash
root@devops-01:~# bash hwstat.sh

Hostname                : devops-01
Uptime                  : 5 days 14:57
Startup                 : 10.804s (kernel) + 40.423s (userspace) = 51.228s
Local Time              : Fri 2023-09-08 02:42:01 MSK
Time Zone               : Europe/Moscow (MSK, +0300)
NTP service             : active
NTP server              : 91.189.91.157:123 (ntp.ubuntu.com)
OS                      : Ubuntu 22.04.3 LTS
Kernel                  : Linux 5.15.0-82-generic
Systemd version         : 249.11-0ubuntu3.9
Hypervisor              : VMware
CPU                     : Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz
Core                    : 1
Architecture            : x86_64
L2                      : 256 KiB
L3                      : 12 MiB
Motherboard             : 440BX Desktop Reference Platform
BIOS                    : Phoenix Technologies LTD
BIOS Version            : 6.00
BIOS Release            : 11.12.2020
Process Started count   : 259
Running/All Process     : 8/419
CPU avg 1/5/15 min      : 1.03 0.86 0.76
CPU avg usr/sys/wa/idle : 4     7       0       89
CPU cur usr/sys/wa/idle : 12    19      1       68
IOps avg in/out         : 25    1025
IOps current in/out     : 0     1024
MEM use/all/cache       : 1813/3876/1791 MB
MEM cache/buffer/dirty  : 917092/386152/1300 KB
SWAP use/all            : 85/3888 MB
SWAP Mount              : file /swap.img
SWAP Running free mem   : 80 %
Cache background/ratio  : 10/15 %
Cache expire/writeback  : 3000/500 hundredths sec
Ethernet Adapter        : Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
VGA controller          : VMware SVGA II Adapter
Audio controller        : Ensoniq ES1371/ES1373 / Creative Labs CT2518 (rev 02)
SCSI controller         : Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
SATA controller         : VMware SATA AHCI controller
All Disk and Volume     : sda, sda1, sda2, sda3, sdb, sdb1, sdc, sdc1
Disk size               : sda (50G), sdb (10G), sdc (10G)
Disk Running Model      : sda VMware Virtual S 50G, sdb VMware Virtual S 10G, sdc VMware Virtual S 10G
Mount Filesystem free   : /dev/sda2 (1.6G/2.0G), //192.168.3.100/Backup (497G/1.9T), /dev/sdc1 (4.8G/5.0G)
LVM Volume Group        : ubuntu-vg pdisk:2 lgroup:2 (976.00m/57.99g)
LVM Physical Volume     : /dev/sda3 -> ubuntu-vg (0/48.00g), /dev/sdb1 -> ubuntu-vg (976.00m/10.00g)
LVM Logical Volume      : snap-1 -> ubuntu-vg (1.00g), ubuntu-lv -> ubuntu-vg (56.04g)
Network Interfaces      : ens33, ens37
Network Driver/Speed    : ens33 (e1000/1000Mb/s), ens37 (e1000/1000Mb/s)
Current DNS Server      : 1.1.1.1
DNS Server List         : 192.168.3.101, 8.8.8.8, 1.1.1.1
TCP max syn backlog     : 256
TCP max connect backlog : 4096
Net Kernel max backlog  : 1000
TCP Keepalive Time Live : 7200+(75*9)=7875
ICMP ignore             : false
Route ip forward        : false
Descriptor File use/max : 2400/9223372036854775807
List Open Files count   : 35749
All dir and files count : 517951
Limits count            : 0
Socket ESTAB count      : 22
Unique open net ports   : 2121, 3306, 57934, 8080
iptables rule count     : 1
UFW Status              : inactive
Unit Startup count      : 109/399
APT show auto/manual    : 829 (767/62)
APT Last Update         : 8 Sep 01:41
APT List Upgrade count  : 2
DPKG Packet count       : 840
SNAP Packet count       : 4
User count              : 41
User directories        : Jenkins, lifailon
Bash version            : 5.1.16(1)-release (x86_64-pc-linux-gnu)
Python version          : 3.10.12
Zabbix Agent status     : active (running) since Thu 2023-09-07 23:00:01 MSK; 3h 42min ago
Zabbix Agent version    : 6.4.6
Zabbix config           : /etc/zabbix/zabbix_agentd.conf
Zabbix server           : 192.168.3.102
```
