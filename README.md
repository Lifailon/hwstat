## hwstat

Function collecting hardware and software statistic as well kernel settings from different sources in the operating system for output in one place.

It is convenient for the system administrator to get all the information quickly without having to remember all the commands and filter the output.

Tested by Ubuntu Server 20.04 and 22.04 and Hypervisor VMware

### Sources of data collection:

- uname
- uptime
- systemd
- timedatectl
- systemctl
- syslog
- journalctl
- lsb_release
- lscpu
- dmidecode **(use root permission)**
- ps
- loadavg
- vmstat
- free
- meminfo
- swapon
- sysctl
- lspci
- lsblk
- df
- lvm **(use root permission)**
- md **(use root permission)**
- ethtool
- resolvectl
- networkctl
- lsof **(for full output use root permission and slow)**
- limits
- ss
- ufw **(use root permission)**
- firewalld **(use root permission)**
- iptables **(use root permission)**
- apt
- dpkg
- snap
- versions
- docker **(use root permission)**
- zabbix

### Example 1:

```bash
root@devops-01:~# bash hwstat.sh

Hostname                  : devops-01
Uptime                    : 5 days 12:37 (2023-09-09 01:46:33)
Startup                   : 10.804s (kernel) + 40.423s (userspace) = 51.228s
Local Time                : Thu 2023-09-14 14:23:45 MSK
Time Zone                 : Europe/Moscow (MSK, +0300)
NTP service               : active
NTP server                : 185.125.190.56:123 (ntp.ubuntu.com)
Syslog service            : active (running) since Wed 2023-09-13 14:58:02 MSK; 23h ago
Syslog local server       : udp:514
Syslog remote server      : 192.168.3.101:514 192.168.3.99:514
Syslog today/all error    : 27/189
Journal today/all error   : 5/111
OS                        : Ubuntu 22.04.3 LTS
Kernel                    : Linux 5.15.0-82-generic
Systemd version           : 249.11-0ubuntu3.9
Hypervisor                : VMware
CPU                       : Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz
Core                      : 1
Architecture              : x86_64
L2                        : 256 KiB
L3                        : 12 MiB
Motherboard               : 440BX Desktop Reference Platform
BIOS                      : Phoenix Technologies LTD
BIOS Version              : 6.00
BIOS Release              : 11.12.2020
Process Started count     : 268
Running/All Process       : 5/553
CPU avg 1/5/15 min        : 1.91 2.10 2.21
CPU avg usr/sys/wa/idle   : 9   10      0       80
CPU cur usr/sys/wa/idle   : 42  58      0       0
IOps avg in/out           : 25  1092
IOps current in/out       : 0   1284
MEM use/all/cache         : 1449/3876/2309 MB
MEM cache/buffer/dirty    : 1756312/293248/1156 KB
SWAP use/all              : 400/3888 MB
SWAP Mount                : file /swap.img
SWAP Running free mem     : 60 %
Cache background/ratio    : 10/20 %
Cache expire/writeback    : 3000/500 hundredths sec
Ethernet Adapter          : Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
VGA controller            : VMware SVGA II Adapter
Audio controller          : Ensoniq ES1371/ES1373 / Creative Labs CT2518 (rev 02)
SCSI controller           : Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
SATA controller           : VMware SATA AHCI controller
All Disk and Volume       : sda, sda1, sda2, sda3, sdb, sdb1
Disk size                 : sda (50G), sdb (10G)
Disk Running Model        : sda VMware Virtual S 50G, sdb VMware Virtual S 10G
Mount Filesystem free     : /dev/mapper/u--vg-u--lv (31G/57G), /dev/sda2 (1.6G/2.0G), //192.168.3.100/Backup (336G/1.9T)
LVM Volume Group          : u-vg pdisk:2 lgroup:2 (976.00m/57.99g)
LVM Physical Volume       : /dev/sda3 -> u-vg (0/48.00g), [unknown] -> u-vg (976.00m/10.00g)
LVM Logical Volume        : snap-1 -> u-vg (1.00g), u-lv -> u-vg (56.04g)
MD RAID Level/Status      : No arrays
MD Active/Work/Fail/Spare :
Network Interfaces        : docker0, docker_gwbridge, ens33
Network Driver/Speed      : docker0 (bridge/10000Mb/s), docker_gwbridge (bridge/10000Mb/s), ens33 (e1000/1000Mb/s)
Current DNS Server        : 8.8.8.8
DNS Server List           : 172.17.0.1, 172.18.0.1, 172.19.0.1, 192.168.3.101, 8.8.8.8, 1.1.1.1
IPv6 disable              : false
Route ip forward          : true
ICMP ignore broadcast/all : true/false
ICMP accept/send redirect : false/true
TCP SYN use cookies       : true
TCP fastopen data connect : 1
TCP SYN max backlog       : 256
TCP SYN-ACK max backlog   : 4096
TCP SYN/SYN-ACK retries   : 6/5
TCP Keepalive Time Live   : 7200+(75*9)=7875 sec
TCP orphan max socket     : 16384
TCP orphan retries count  : 0
TCP FIN timeout socket    : 60 sec
TCP metrics save          : true
TCP mem min/load/max page : 43971/58628/87942
Socket in/out buffer min  : 4096/4096 byte
Socket in/out default     : 131072/16384 byte
Socket in/out buffer max  : 212992/212992 byte
Socket TIME-WAIT max      : 16384
Socket local port range   : 32768-60999
Net Kernel max backlog    : 1000
Net reverse path filter   : 2
Descriptor Files use/max  : 2976/9223372036854775807
List Open Files count     : 39723
Limits count              : 0
Socket ESTAB count        : 22
Socket LISTEN unique port : 2121, 3306, 39324, 54070, 8080
UFW Status                : active
UFW Rule allow/deny count : 22/4
FWD Status                : running
FWD Rule ports/services   : 10/6
Iptables rule count       : 42
Unit Startup/All count    : 112/407
Cron jobs enabled count   : 1
APT show auto/manual      : 841 (778/63)
APT Last Update           : 14 Sep 13:09
APT List Upgrade count    : 2
DPKG Packet count         : 852
SNAP Packet count         : 4
User count                : 41
User directories          : Jenkins, lifailon
Bash version              : 5.1.16
Python version            : 3.10.12
Ansible version           : 2.10.8
Docker/Compose version    : 24.0.5/2.21.0
Docker Volumes/Images     : 4/7
Docker Running/All        : 4/10
Docker LISTEN host ports  : 3000, 3001, 5433
Zabbix Agent status       : active (running) since Wed 2023-09-13 23:00:01 MSK; 15h ago
Zabbix Agent version      : 6.4.6
Zabbix config             : /etc/zabbix/zabbix_agentd.conf
Zabbix server             : 192.168.3.102
```

### Example 2:

Use Ubuntu 20.04 and not root permission

```
lifailon@pi-hole-01:~$ bash hwstat.sh

Hostname                  : pi-hole-01
Uptime                    : 3:09 (2023-09-14 10:23:51)
Startup                   : 8.577s (kernel) + 1min 50.999s (userspace) = 1min 59.576s
Local Time                : Чт 2023-09-14 13:33:44 MSK
Time Zone                 : Europe/Moscow (MSK, +0300)
NTP service               : active
NTP server                : 185.125.190.56:123 (ntp.ubuntu.com)
Syslog service            : active (running) since Thu 2023-09-14 10:25:34 MSK; 3h 8min ago
Syslog local server       :
Syslog remote server      : 192.168.3.99:514
Syslog today/all error    : 0/84
Journal today/all error   : 65/1409
OS                        : Ubuntu 20.04.6 LTS
Kernel                    : Linux 5.4.0-162-generic
Systemd version           : 245.4-4ubuntu3.22
Hypervisor                : VMware
CPU                       : Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz
Core                      : 1
Architecture              : x86_64
L2                        : 256 KiB
L3                        : 12 MiB
Motherboard               : Permission denied
BIOS                      : Permission denied
BIOS Version              : Permission denied
BIOS Release              : Permission denied
Process Started count     : 309
Running/All Process       : 1/614
CPU avg 1/5/15 min        : 0.04 0.08 0.07
CPU avg usr/sys/wa/idle   : 1   2       0       97
CPU cur usr/sys/wa/idle   : 1   2       0       97
IOps avg in/out           : 143 58
IOps current in/out       : 0   0
MEM use/all/cache         : 920/1940/881 MB
MEM cache/buffer/dirty    : 738036/72632/528 KB
SWAP use/all              : 0/0 MB
SWAP Mount                :
SWAP Running free mem     : 60 %
Cache background/ratio    : 10/20 %
Cache expire/writeback    : 3000/500 hundredths sec
Ethernet Adapter          : Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
VGA controller            : VMware SVGA II Adapter
Audio controller          : Ensoniq ES1371/ES1373 / Creative Labs CT2518 (rev 02)
SCSI controller           : Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
SATA controller           : VMware SATA AHCI controller
All Disk and Volume       : sda, sda1, sda2, sda3, sdb
Disk size                 : sda (50G), sdb (10G), └─md0 (10G)
Disk Running Model        : sda VMware_Virtual_S 50G, sdb VMware_Virtual_S 10G
Mount Filesystem free     : /dev/mapper/u--vg-u--lv (31G/48G), /dev/sda2 (698M/974M), /dev/md0 (9,3G/9,8G)
LVM Volume Group          : Permission denied
LVM Physical Volume       : Permission denied
LVM Logical Volume        : Permission denied
MD RAID Level/Status      : md0
MD Active/Work/Fail/Spare : Permission denied
Network Interfaces        : docker0, ens33
Network Driver/Speed      : docker0 (bridge/), ens33 (e1000/1000Mb/s)
Current DNS Server        : 8.8.8.8
DNS Server List           : 172.17.0.1, 172.18.0.1, 8.8.8.8, 1.1.1.1
IPv6 disable              : false
Route ip forward          : true
ICMP ignore broadcast/all : true/false
ICMP accept/send redirect : false/true
TCP SYN use cookies       : true
TCP fastopen data connect : 1
TCP SYN max backlog       : 128
TCP SYN-ACK max backlog   : 4096
TCP SYN/SYN-ACK retries   : 6/5
TCP Keepalive Time Live   : 7200+(75*9)=7875 sec
TCP orphan max socket     : 8192
TCP orphan retries count  : 0
TCP FIN timeout socket    : 60 sec
TCP metrics save          : true
TCP mem min/load/max page : 21408/28545/42816
Socket in/out buffer min  : 4096/4096 byte
Socket in/out default     : 131072/16384 byte
Socket in/out buffer max  : 212992/212992 byte
Socket TIME-WAIT max      : 8192
Socket local port range   : 32768-60999
Net Kernel max backlog    : 1000
Net reverse path filter   : 2
Descriptor Files use/max  : 5056/9223372036854775807
List Open Files count     : 7292
Limits count              : 0
Socket ESTAB count        : 3
Socket LISTEN unique port : 2121
UFW Status                : Permission denied
UFW Rule allow/deny count :
FWD Status                : Permission denied
FWD Rule ports/services   :
Iptables rule count       : 0
Unit Startup/All count    : 377/396
Cron jobs enabled count   : 0
APT show auto/manual      : 1228 (1159/69)
APT Last Update           : 14 сен 13:25
APT List Upgrade count    : 0
DPKG Packet count         : 1249
SNAP Packet count         : 4
User count                : 52
User directories          : lifailon, tester, testuser
Bash version              : 5.0.17
Python version            : 3.8.10
Ansible version           : No installed
Docker/Compose version    : Permission denied
Docker Volumes/Images     : Permission denied
Docker Running/All        : Permission denied
Docker LISTEN host ports  : Permission denied
Zabbix Agent status       : active (running) since Thu 2023-09-14 10:25:35 MSK; 3h 8min ago
Zabbix Agent version      : 6.4.6
Zabbix config             : /etc/zabbix/zabbix_agentd.conf
Zabbix server             : 192.168.3.102,192.168.3.99
```
