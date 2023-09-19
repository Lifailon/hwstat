## hwstat

Function collecting hardware and software configutation statistic as well kernel settings from different sources in the operating system for output in one place.

It is convenient for the system administrator to get all the information quickly without having to remember all the commands and filter the output. Can be used to reconcile OS settings (**diff metrics**).

Tested by Ubuntu Server 20.04 and 22.04 and Hypervisor VMware

### Sources of data collection:

- uname
- uptime
- systemd
- timedatectl
- systemctl
- ntpd
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
- sysctl (vm, net, fs)
- lspci
- lsblk
- df
- fstab
- lvm **(use root permission)**
- md **(use root permission)**
- ethtool
- systemd-resolve/resolvectl
- networkctl
- hosts
- lsof **(for full output use root permission)**
- limits **(for full output use root permission)**
- ss
- ufw **(use root permission)**
- firewalld **(use root permission)**
- iptables **(use root permission)**
- apt
- dpkg
- snap
- users/group
- shadow **(use root permission)**
- sudoers **(use root permission)**
- login
- ssh
- versions
- docker **(use root permission)**
- zabbix

### Example 1:

```bash
root@devops-01:~# bash hwstat.sh

Hostname                         : devops-01
Uptime                           : 10 days 13:35 (2023-09-09 01:48:45)
Startup                          : 10.804s (kernel) + 40.423s (userspace) = 51.228s
Local Time                       : Tue 2023-09-19 15:23:56 MSK
Time Zone                        : Europe/Moscow (MSK, +0300)
NTP service/synchronized         : yes/active
NTP systemd service status       : active
NTP systemd current server sync  : 91.189.91.157:123 (ntp.ubuntu.com)
NTPD status                      : No installed
NTPD conf server/pool            :
NTPD current server sync         :
Syslog service                   : active (running) since Tue 2023-09-19 00:32:29 MSK; 14h ago
Syslog remote server             : 192.168.3.99:514
Syslog today/all error           : 599/607
Journal today/all error          : 1081/1081
OS                               : Ubuntu 22.04.3 LTS
Kernel                           : Linux 5.15.0-82-generic
Systemd version                  : 249.11-0ubuntu3.10
Hypervisor                       : VMware
CPU                              : Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz
Core                             : 1
Architecture                     : x86_64
L2                               : 256 KiB
L3                               : 12 MiB
Motherboard                      : 440BX Desktop Reference Platform
BIOS                             : Phoenix Technologies LTD
BIOS Version                     : 6.00
BIOS Release                     : 11.12.2020
Process Started count            : 276
Running/All Process to System    : 2/567
CPU avg 1/5/15 min               : 2.07 1.30 1.13
CPU avg usr/sys/wa/idle          : 18   15      0       67
CPU cur usr/sys/wa/idle          : 13   17      0       70
IOps avg in/out                  : 20   1098
IOps current in/out              : 0    4
MEM use/cache/all                : 1447/2321/3876 MB
MEM cache/buffer/dirty           : 1791488/297180/928 KB
SWAP use/all                     : 93/3888 MB
SWAP Mount                       : file /swap.img
SWAP Running free mem            : 60 %
Cache background/ratio           : 10/20 %
Cache expire/writeback           : 3000/500 hundredths sec
Ethernet Adapter                 : Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
VGA controller                   : VMware SVGA II Adapter
Audio controller                 : Ensoniq ES1371/ES1373 / Creative Labs CT2518 (rev 02)
SCSI controller                  : Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
SATA controller                  : VMware SATA AHCI controller
All Disk and Volume count        : 6
All Disk and Volume names        : sda, sda1, sda2, sda3, sdb, sdb1
Disk size                        : sda 50G, sdb 10G
Disk all size                    : 60 GB
Disk Running Model               : sda VMware Virtual S 50G, sdb VMware Virtual S 10G
Mount Filesystem free/all        : /dev/mapper/ubuntu--vg-ubuntu--lv (29G/57G), /dev/sda2 (1.6G/2.0G), //192.168.3.100/Backup (336G/1.9T)
Mount fstab count                : 4
LVM Volume Group                 : ubuntu-vg pdisk:2 lgroup:2 (976.00m/57.99g)
LVM Physical Volume              : /dev/sda3 -> ubuntu-vg (0/48.00g), [unknown] -> ubuntu-vg (976.00m/10.00g)
LVM Logical Volume               : snap-1 -> ubuntu-vg (1.00g), ubuntu-lv -> ubuntu-vg (56.04g)
MD RAID Level/Status             : No arrays
MD Active/Work/Fail/Spare        :
Network Interfaces               : docker0, docker_gwbridge, ens33
Network Driver/Speed             : docker0 (bridge/10000Mb/s), docker_gwbridge (bridge/10000Mb/s), ens33 (e1000/1000Mb/s)
DNS Resolv configuration         : 127.0.0.53
DNS Resolv conf link             : /run/systemd/resolve/stub-resolv.conf
DNS Server systemd list          : 192.168.3.101, 8.8.8.8, 1.1.1.1
DNS Server systemd current       : 8.8.8.8
Hosts file count addreses        : 2
Socket ESTAB count               : 5
Socket LISTEN unique port        : 2121, 44662, 59532
IPv6 disable                     : false
Route ip forward                 : true
ICMP ignore broadcast/all        : true/false
ICMP accept/send redirect        : false/true
TCP SYN use cookies              : true
TCP fastopen data connect        : 1
TCP SYN max backlog              : 256
TCP SYN-ACK max backlog          : 4096
TCP SYN/SYN-ACK retries          : 6/5
TCP Keepalive Time Live          : 7200+(75*9)=7875 sec
TCP orphan max socket            : 16384
TCP orphan retries count         : 0
TCP FIN timeout socket           : 60 sec
TCP metrics save                 : true
TCP mem min/load/max page        : 43971/58628/87942
Socket in/out buffer min         : 4096/4096 bytes
Socket in/out default            : 131072/16384 bytes
Socket in/out buffer max         : 212992/212992 bytes
Socket TIME-WAIT max             : 16384
Socket local port range          : 32768-60999
Net Kernel max backlog           : 1000
Net reverse path filter          : 2
Async IO request curr/max        : 2305/65536
Msg queues/count/size max        : 256/10/8192
Descriptor Files use/no use      : 3328/0
Descriptor Files max             : 9223372036854775807
Descriptor max for process       : 1048576
List Open Files/All count        : 27495/34502
Limits configuration count       : 4
Limits User Open Files Soft/Hard : 1 1024/16384 42 2048/8192 count
Limits User File Size  Soft/Hard : 43 unlimited/unlimited blocks
Limits User Stack Size Soft/Hard : 43 8192/unlimited kbytes
Limits User Msg Queues Soft/Hard : 43 819200/819200 bytes
Limits User User Proc  Soft/Hard : 43 15052/15052 count
Limits User CPU Time   Soft/Hard : 43 unlimited/unlimited sec
Limits User MEM Size   Soft/Hard : 43 unlimited/unlimited kbytes
Limits Process Open Files S/H    : 1 10000/10000 18 1024/1048576 174 1024/4096 39 1024/524288 28 1048576/1048576 1 16384/16384 7 524288/524288 1 65536/65536 1 8192/8192 count
Limits Process File Size  S/H    : 270 unlimited/unlimited blocks
Limits Process Stack Size S/H    : 1 67108864/67108864 269 8388608/unlimited kbytes
Limits Process Msg Queues S/H    : 270 819200/819200 bytes
Limits Process User Proc  S/H    : 247 15052/15052 23 unlimited/unlimited count
Limits Process CPU Time   S/H    : 270 unlimited/unlimited sec
Limits Process MEM Size   S/H    : 270 unlimited/unlimited kbytes
UFW Status                       : active
UFW Rule allow/deny count        : 22/4
FWD Status                       : running
FWD Rule ports/services          : 10/6
Iptables rule count              : 34
Hosts allow/deny services        : 0/0
Unit Startup/All count           : 129/438
Cron tasks curr/all users        : 1/2
APT show auto/manual             : 1038 (972/66)
APT Last Update                  : 19 Sep 00:28
APT List Upgrade count           : 6
DPKG Packet count                : 1050
SNAP Packet count                : 8
User/Group count                 : 44/73
User using password              : root, lifailon
User directory                   : Jenkins, lifailon
Sudo nopasswd/all count          : 0/4
Login pass min/max days          : 0/99999
ssh port/x11/login pass/root     : 2121/yes/yes/yes
Bash version                     : 5.1.16
Python version                   : 3.10.12
Ansible version                  : 2.10.8
Docker/Compose version           : 24.0.5/2.21.0
Docker Volumes/Images            : 4/7
Docker Running/All               : 4/11
Docker LISTEN host ports         : 3000, 3001, 5433
Zabbix Agent status              : active (running) since Mon 2023-09-18 23:00:01 MSK; 16h ago
Zabbix Agent version             : 6.4.6
Zabbix config                    : /etc/zabbix/zabbix_agentd.conf
Zabbix server                    : 192.168.3.102
```

### Example 2:

Use Ubuntu 20.04 and not root permission

```bash
lifailon@pi-hole-01:~$ bash hwstat.sh

Hostname                         : pi-hole-01
Uptime                           : 22:33 (2023-09-18 16:50:16)
Startup                          : 22.036s (kernel) + 24.708s (userspace) = 46.744s
Local Time                       : Вт 2023-09-19 15:23:43 MSK
Time Zone                        : Europe/Moscow (MSK, +0300)
NTP service/synchronized         : yes/n/a
NTP systemd service status       : inactive
NTP systemd current server sync  :
NTPD status                      : active
NTPD conf server/pool            : 2/0
NTPD current server sync         : 91.206.16.3
Syslog service                   : active (running) since Mon 2023-09-18 16:50:46 MSK; 22h ago
Syslog remote server             : 192.168.3.99:514 192.168.3.105:514
Syslog today/all error           : 0/0
Journal today/all error          : 26/1533
OS                               : Ubuntu 20.04.6 LTS
Kernel                           : Linux 5.4.0-162-generic
Systemd version                  : 245.4-4ubuntu3.22
Hypervisor                       : VMware
CPU                              : Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz
Core                             : 1
Architecture                     : x86_64
L2                               : 256 KiB
L3                               : 12 MiB
Motherboard                      : Permission denied
BIOS                             : Permission denied
BIOS Version                     : Permission denied
BIOS Release                     : Permission denied
Process Started count            : 305
Running/All Process to System    : 2/610
CPU avg 1/5/15 min               : 0.04 0.06 0.08
CPU avg usr/sys/wa/idle          : 1    2       0       97
CPU cur usr/sys/wa/idle          : 0    3       0       97
IOps avg in/out                  : 55   64
IOps current in/out              : 0    0
MEM use/cache/all                : 1063/807/1940 MB
MEM cache/buffer/dirty           : 653136/85268/504 KB
SWAP use/all                     : 0/0 MB
SWAP Mount                       :
SWAP Running free mem            : 60 %
Cache background/ratio           : 10/20 %
Cache expire/writeback           : 3000/500 hundredths sec
Ethernet Adapter                 : Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
VGA controller                   : VMware SVGA II Adapter
Audio controller                 : Ensoniq ES1371/ES1373 / Creative Labs CT2518 (rev 02)
SCSI controller                  : Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
SATA controller                  : VMware SATA AHCI controller
All Disk and Volume count        : 5
All Disk and Volume names        : sda, sda1, sda2, sda3, sdb
Disk size                        : sda 50G, sdb 10G
Disk all size                    : 60 GB
Disk Running Model               : sda VMware_Virtual_S 50G, sdb VMware_Virtual_S 10G
Mount Filesystem free/all        : /dev/mapper/ubuntu--vg-ubuntu--lv (30G/48G), /dev/sda2 (698M/974M), /dev/md127 (9,3G/9,8G)
Mount fstab count                : 3
LVM Volume Group                 : Permission denied
LVM Physical Volume              : Permission denied
LVM Logical Volume               : Permission denied
MD RAID Level/Status             : md127
MD Active/Work/Fail/Spare        : Permission denied
Network Interfaces               : docker0, ens33
Network Driver/Speed             : docker0 (bridge/), ens33 (e1000/1000Mb/s)
DNS Resolv configuration         : 8.8.8.8, 1.1.1.1, 127.0.0.53
DNS Resolv conf link             : /run/resolvconf/resolv.conf
DNS Server systemd list          : 8.8.8.8, 1.1.1.1, 9.9.9.9
DNS Server systemd current       : 8.8.8.8
Hosts file count addreses        : 2
Socket ESTAB count               : 3
Socket LISTEN unique port        : 2121
IPv6 disable                     : false
Route ip forward                 : true
ICMP ignore broadcast/all        : true/false
ICMP accept/send redirect        : false/true
TCP SYN use cookies              : true
TCP fastopen data connect        : 1
TCP SYN max backlog              : 128
TCP SYN-ACK max backlog          : 4096
TCP SYN/SYN-ACK retries          : 6/5
TCP Keepalive Time Live          : 7200+(75*9)=7875 sec
TCP orphan max socket            : 8192
TCP orphan retries count         : 0
TCP FIN timeout socket           : 60 sec
TCP metrics save                 : true
TCP mem min/load/max page        : 21408/28545/42816
Socket in/out buffer min         : 4096/4096 bytes
Socket in/out default            : 131072/16384 bytes
Socket in/out buffer max         : 212992/212992 bytes
Socket TIME-WAIT max             : 8192
Socket local port range          : 32768-60999
Net Kernel max backlog           : 1000
Net reverse path filter          : 2
Async IO request curr/max        : 0/65536
Msg queues/count/size max        : 256/10/8192
Descriptor Files use/no use      : 5088/0
Descriptor Files max             : 9223372036854775807
Descriptor max for process       : 1048576
List Open Files/All count        : 4136/6863
Limits configuration count       : 0
Limits User Open Files Soft/Hard : 1024/1048576 count
Limits User File Size  Soft/Hard : unlimited/unlimited blocks
Limits User Stack Size Soft/Hard : 8192/unlimited kbytes
Limits User Msg Queues Soft/Hard : 819200/819200 bytes
Limits User User Proc  Soft/Hard : 7400/7400 count
Limits User CPU Time   Soft/Hard : unlimited/unlimited sec
Limits User MEM Size   Soft/Hard : unlimited/unlimited kbytes
Limits Process Open Files S/H    : 14 1024/1048576 171 1024/4096 50 1024/524288 27 1048576/1048576 1 16384/16384 30 2048/8192 1 256/256 1 50/50 3 524288/524288 4 8192/8192 count
Limits Process File Size  S/H    : 1 0/0 293 unlimited/unlimited blocks
Limits Process Stack Size S/H    : 1 204800/unlimited 293 8388608/unlimited kbytes
Limits Process Msg Queues S/H    : 1 0/0 293 819200/819200 bytes
Limits Process User Proc  S/H    : 1 1/1 1 3/3 269 7400/7400 23 unlimited/unlimited count
Limits Process CPU Time   S/H    : 294 unlimited/unlimited sec
Limits Process MEM Size   S/H    : 2 200000/200000 292 unlimited/unlimited kbytes
UFW Status                       : Permission denied or no installed
UFW Rule allow/deny count        :
FWD Status                       : Permission denied or no installed
FWD Rule ports/services          :
Iptables rule count              : 0
Hosts allow/deny services        : 0/0
Unit Startup/All count           : 381/400
Cron tasks curr/all users        : 0/0
APT show auto/manual             : 1237 (1162/75)
APT Last Update                  : 19 сен 12:10
APT List Upgrade count           : 4
DPKG Packet count                : 1259
SNAP Packet count                : 4
User/Group count                 : 53/81
User using password              : Permission denied
User directory                   : lifailon, tester, testuser
Sudo nopasswd/all count          : Permission denied
Login pass min/max days          : 0/99999
ssh port/x11/login pass/root     : 2121/yes/yes/prohibit-password
Bash version                     : 5.0.17
Python version                   : 3.8.10
Ansible version                  : No installed
Docker/Compose version           : Permission denied
Docker Volumes/Images            : Permission denied
Docker Running/All               : Permission denied
Docker LISTEN host ports         : Permission denied
Zabbix Agent status              : active (running) since Mon 2023-09-18 16:50:47 MSK; 22h ago
Zabbix Agent version             : 6.4.6
Zabbix config                    : /etc/zabbix/zabbix_agentd.conf
Zabbix server                    : 192.168.3.102,192.168.3.99
```
