## hwstat

Function collecting **hardware and software configutation** statistic as well **kernel settings and system limits** from different sources integral in the operating system for output in one place.

It is convenient for the system administrator to get all the information on the system quickly without having to remember all the commands and filter the output. Can be used to reconcile OS settings by means of **diff (e.g. via pipeline)** and **metrics monitoring (e.g. via influxdb and grafana)**.

Tested by Ubuntu Server 20.04 and 22.04 and Hypervisor VMware

### Sources of data collection:

- uname
- uptime
- systemd-analyze/systemd-timesyncd
- timedatectl
- systemctl
- ntpd
- local
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
- lspci
- lsblk
- df
- fstab
- lvm **(use root permission)**
- md **(use root permission)**
- ethtool
- networkctl
- systemd-resolve/resolvectl
- hosts
- ss
- ufw **(use root permission)**
- firewalld **(use root permission)**
- iptables **(use root permission)**
- hosts allow/deny
- apt
- dpkg
- snap
- users/group
- shadow **(use root permission)**
- sudoers **(use root permission)**
- login.defs
- profile/bashrc
- ssh
- **sysctl** (vm, net, fs)
- lsof **(for full output use root permission)**
- **limits users (for output all users use root permission)**
- **limits processes** (format: count unique processes and his Soft/Hard metrics)
- last logon
- quota **(use root permission)**
- versions
- docker **(use root permission)**
- zabbix

### Example 1:

```bash
root@devops-01:~# bash hwstat.sh

Hostname                          : devops-01
Uptime                            : 18 days 11:34 (2023-09-09 01:48:45)
Startup                           : 10.804s (kernel) + 40.423s (userspace) = 51.228s
Local Time                        : Wed 2023-09-27 13:22:54 MSK
Time Zone                         : Europe/Moscow (MSK, +0300)
Language locale use               : en_US.UTF-8
NTP service/synchronized          : yes/active
NTP systemd service status        : active
NTP systemd current server sync   : 91.189.91.157:123 (ntp.ubuntu.com)
NTPD status                       : No installed
NTPD conf server/pool             :
NTPD current server sync          :
Syslog service                    : active (running) since Tue 2023-09-19 00:32:29 MSK; 1 week 1 day ago
Syslog remote server              : 192.168.3.99:514
Syslog today/all error            : 1662/2692
Journal today/all error           : 1/2237
OS                                : Ubuntu 22.04.3 LTS
Kernel                            : Linux 5.15.0-82-generic
Systemd version                   : 249.11-0ubuntu3.10
Hypervisor                        : VMware
CPU                               : Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz
Core                              : 1
Architecture                      : x86_64
Virtualization                    : full
L2                                : 256 KiB
L3                                : 12 MiB
CPU MHz                           : 2904.008
Modules count                     : 169
Motherboard                       : 440BX Desktop Reference Platform
BIOS                              : Phoenix Technologies LTD
BIOS Version                      : 6.00
BIOS Release                      : 11.12.2020
PS Process Started/Threads count  : 273/543
Process Running/All to System     : 7/545
CPU avg 1/5/15 min                : 5.47 4.75 4.61
CPU avg usr/sys/wa/idle           : 25  17      0       57
CPU cur usr/sys/wa/idle           : 55  45      0       0
IOps avg in/out                   : 14  657
IOps current in/out               : 0   0
MEM use/cache/all                 : 1515/2246/3876 MB
MEM cache/buffer/dirty            : 2008380/32304/419344 KB
SWAP use/all                      : 216/3888 MB
SWAP Mount                        : file /swap.img
SWAP Running free mem             : 60 %
Cache background/ratio            : 10/20 %
Cache expire/writeback            : 3000/500 hundredths sec
Ethernet Adapter                  : Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
VGA controller                    : VMware SVGA II Adapter
Audio controller                  : Ensoniq ES1371/ES1373 / Creative Labs CT2518 (rev 02)
SCSI controller                   : Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
SATA controller                   : VMware SATA AHCI controller
Filesystem type root/boot         : ext4/ext4
All Disk and Volume count         : 6
All Disk and Volume names         : sda, sda1, sda2, sda3, sdb, sdb1
Disk size                         : sda 50G, sdb 10G
Disk all size                     : 60 GB
Disk Running Model                : sda VMware Virtual S 50G, sdb VMware Virtual S 10G
Mount Filesystem free/all         : /dev/mapper/ubuntu--vg-ubuntu--lv (26G/57G), /dev/sda2 (1.6G/2.0G), //192.168.3.100/Backup (236G/1.9T)
Mount fstab count                 : 4
LVM Volume Group                  : ubuntu-vg pdisk:2 lgroup:2 (976.00m/57.99g)
LVM Physical Volume               : /dev/sda3 -> ubuntu-vg (0/48.00g), [unknown] -> ubuntu-vg (976.00m/10.00g)
LVM Logical Volume                : snap-1 -> ubuntu-vg (1.00g), ubuntu-lv -> ubuntu-vg (56.04g)
MD RAID Level/Status              : No arrays
MD Active/Work/Fail/Spare         :
Network Interfaces                : docker0, docker_gwbridge, ens33
Network Driver/Speed              : docker0 (bridge/10000Mb/s), docker_gwbridge (bridge/10000Mb/s), ens33 (e1000/1000Mb/s)
DNS Resolv configuration          : 127.0.0.53
DNS Resolv conf link              : /run/systemd/resolve/stub-resolv.conf
DNS Server systemd list           : 192.168.3.101, 8.8.8.8, 1.1.1.1
DNS Server systemd current        : 192.168.3.101
Hosts file count addreses         : 2
Socket ESTAB count                : 5
Socket LISTEN unique port         : 2121, 44662, 50794, 8080
UFW Status                        : active
UFW Rule allow/deny count         : 22/4
FWD Status                        : running
FWD Rule ports/services           : 10/6
Iptables rule count               : 34
Hosts allow/deny services         : 0/0
Unit Startup/All count            : 132/441
Cron tasks curr/all users         : 1/2
APT show auto/manual              : 1038 (972/66)
APT Last Update                   : 22 Sep 10:40
APT List Upgrade count            : 23
DPKG Packet count                 : 1050
SNAP Packet count                 : 0
User/Group count                  : 44/73
User using password               : root, lifailon
User directory                    : Jenkins, lifailon
Sudo nopasswd/all count           : 0/4
Login pass min/max days           : 0/99999
Login idle timeout seconds        : 1440
ssh port/x11/login pass/root      : 2121/yes/yes/yes
ssh keepalive/interval/count      : yes/30/3
IPv6 disable                      : false
Route ip forward                  : true
ICMP ignore broadcast/all         : true/false
ICMP accept/send redirect         : false/true
TCP SYN use cookies               : true
TCP fastopen data connect         : 1
TCP SYN max backlog               : 256
TCP SYN-ACK max backlog           : 4096
TCP SYN/SYN-ACK retries           : 6/5
TCP Keepalive Time Live           : 7200+(75*9)=7875 sec
TCP orphan max socket             : 16384
TCP orphan retries count          : 0
TCP FIN timeout socket            : 60 sec
TCP metrics save                  : true
TCP mem min/load/max page         : 43971/58628/87942
Socket in/out buffer min          : 4096/4096 bytes
Socket in/out default             : 131072/16384 bytes
Socket in/out buffer max          : 212992/212992 bytes
Socket TIME-WAIT max              : 16384
Socket local port range           : 32768-60999
Net Kernel max backlog            : 1000
Net reverse path filter           : 2
Async IO request curr/max         : 2305/65536
Msg queues/count/size max         : 256/10/8192
Descriptor Files use/no use       : 3008/0
Descriptor Files max              : 9223372036854775807
Descriptor max for process        : 1048576
List Open Files/All count         : 26247/32578
Limits configuration count        : 4
Limits last change date           : Sep 18 17:35
User logon before change Limits   : root 192.168.3.100 Sep 18 17:34 - 18:20 (00:45)
Limits User Open Files Soft/Hard  : 1 1024/16384 42 2048/8192 count
Limits User File Size  Soft/Hard  : 43 unlimited/unlimited blocks
Limits User Stack Size Soft/Hard  : 43 8192/unlimited kbytes
Limits User Msg Queues Soft/Hard  : 43 819200/819200 bytes
Limits User User Proc  Soft/Hard  : 43 15052/15052 count
Limits User CPU Time   Soft/Hard  : 43 unlimited/unlimited sec
Limits User MEM Size   Soft/Hard  : 43 unlimited/unlimited kbytes
Limits Process Open Files S/H     : 1 10000/10000 20 1024/1048576 173 1024/4096 36 1024/524288 26 1048576/1048576 1 16384/16384 7 524288/524288 1 65536/65536 1 8192/8192 count
Limits Process File Size  S/H     : 266 unlimited/unlimited blocks
Limits Process Stack Size S/H     : 1 67108864/67108864 265 8388608/unlimited kbytes
Limits Process Msg Queues S/H     : 266 819200/819200 bytes
Limits Process User Proc  S/H     : 245 15052/15052 21 unlimited/unlimited count
Limits Process CPU Time   S/H     : 266 unlimited/unlimited sec
Limits Process MEM Size   S/H     : 266 unlimited/unlimited kbytes
Quota verison                     : 4.06
Quota current Space use/hard/soft : None
Quota current Files use/hard/soft : None
Quota use disk count              : 1
Quota use user Space/Files count  : 3/2
Bash version                      : 5.1.16
Python version                    : 3.10.12
Java OpenJDK verison              : 11.0.20.1 2023-08-24
Ansible version                   : No installed
Docker/Compose version            : 24.0.5/v2.21.0
Docker Volumes/Images             : 4/7
Docker Running/All                : 4/12
Docker LISTEN host ports          : 3000, 3001, 5433
Zabbix Agent status               : active (running) since Mon 2023-09-25 23:00:02 MSK; 1 day 14h ago
Zabbix Agent version              : 6.4.6
Zabbix config                     : /etc/zabbix/zabbix_agentd.conf
Zabbix server                     : 192.168.3.102
```

### Example 2:

Use Ubuntu 20.04 and not root permission

```bash
lifailon@pi-hole-01:~$ bash hwstat.sh

Hostname                          : pi-hole-01
Uptime                            : 5 days 2:43  (2023-09-22 10:49:56)
Startup                           : 6.784s (kernel) + 25.156s (userspace) = 31.940s
Local Time                        : Wed 2023-09-27 13:32:57 MSK
Time Zone                         : Europe/Moscow (MSK, +0300)
Language locale use               : en_US.UTF-8
NTP service/synchronized          : yes/n/a
NTP systemd service status        : inactive
NTP systemd current server sync   :
NTPD status                       : active
NTPD conf server/pool             : 2/0
NTPD current server sync          : roswell.systems
Syslog service                    : active (running) since Fri 2023-09-22 10:50:11 MSK; 5 days ago
Syslog remote server              : 192.168.3.99:514 192.168.3.105:514
Syslog today/all error            : 0/0
Journal today/all error           : 14/895
OS                                : Ubuntu 20.04.6 LTS
Kernel                            : Linux 5.4.0-163-generic
Systemd version                   : 245.4-4ubuntu3.22
Hypervisor                        : VMware
CPU                               : Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz
Core                              : 1
Architecture                      : x86_64
Virtualization                    : full
L2                                : 256 KiB
L3                                : 12 MiB
CPU MHz                           : 2904.010
Modules count                     : 114
Motherboard                       : Permission denied
BIOS                              : Permission denied
BIOS Version                      : Permission denied
BIOS Release                      : Permission denied
PS Process Started/Threads count  : 308/620
Process Running/All to System     : 2/619
CPU avg 1/5/15 min                : 0.26 0.74 0.61
CPU avg usr/sys/wa/idle           : 3   4       0       93
CPU cur usr/sys/wa/idle           : 1   2       0       97
IOps avg in/out                   : 19  57
IOps current in/out               : 0   0
MEM use/cache/all                 : 1092/744/1940 MB
MEM cache/buffer/dirty            : 616368/62616/784 KB
SWAP use/all                      : 0/0 MB
SWAP Mount                        :
SWAP Running free mem             : 60 %
Cache background/ratio            : 10/20 %
Cache expire/writeback            : 3000/500 hundredths sec
Ethernet Adapter                  : Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
VGA controller                    : VMware SVGA II Adapter
Audio controller                  : Ensoniq ES1371/ES1373 / Creative Labs CT2518 (rev 02)
SCSI controller                   : Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
SATA controller                   : VMware SATA AHCI controller
Filesystem type root/boot         : ext4/ext4
All Disk and Volume count         : 5
All Disk and Volume names         : sda, sda1, sda2, sda3, sdb
Disk size                         : sda 50G, sdb 10G
Disk all size                     : 60 GB
Disk Running Model                : sda VMware_Virtual_S 50G, sdb VMware_Virtual_S 10G
Mount Filesystem free/all         : /dev/mapper/ubuntu--vg-ubuntu--lv (30G/48G), /dev/sda2 (698M/974M), /dev/md0 (9.3G/9.8G)
Mount fstab count                 : 3
LVM Volume Group                  : Permission denied
LVM Physical Volume               : Permission denied
LVM Logical Volume                : Permission denied
MD RAID Level/Status              : md0
MD Active/Work/Fail/Spare         : Permission denied
Network Interfaces                : docker0, ens33
Network Driver/Speed              : docker0 (bridge/), ens33 (e1000/1000Mb/s)
DNS Resolv configuration          : 8.8.8.8, 1.1.1.1, 127.0.0.53
DNS Resolv conf link              : /run/resolvconf/resolv.conf
DNS Server systemd list           : 8.8.8.8, 1.1.1.1, 9.9.9.9
DNS Server systemd current        : 8.8.8.8
Hosts file count addreses         : 2
Socket ESTAB count                : 3
Socket LISTEN unique port         : 2121, 80
UFW Status                        : Permission denied or no installed
UFW Rule allow/deny count         :
FWD Status                        : Permission denied or no installed
FWD Rule ports/services           :
Iptables rule count               : 0
Hosts allow/deny services         : 0/0
Unit Startup/All count            : 384/403
Cron tasks curr/all users         : 0/0
APT show auto/manual              : 1242 (1164/78)
APT Last Update                   : 27 Sep 00:59
APT List Upgrade count            : 1
DPKG Packet count                 : 1265
SNAP Packet count                 : 4
User/Group count                  : 53/81
User using password               : Permission denied
User directory                    : lifailon, tester, testuser
Sudo nopasswd/all count           : Permission denied
Login pass min/max days           : 0/99999
Login idle timeout seconds        : 1440
ssh port/x11/login pass/root      : 2121/yes/yes/prohibit-password
ssh keepalive/interval/count      : yes/0/3
IPv6 disable                      : false
Route ip forward                  : true
ICMP ignore broadcast/all         : true/false
ICMP accept/send redirect         : false/true
TCP SYN use cookies               : true
TCP fastopen data connect         : 1
TCP SYN max backlog               : 128
TCP SYN-ACK max backlog           : 4096
TCP SYN/SYN-ACK retries           : 6/5
TCP Keepalive Time Live           : 7200+(75*9)=7875 sec
TCP orphan max socket             : 8192
TCP orphan retries count          : 0
TCP FIN timeout socket            : 60 sec
TCP metrics save                  : true
TCP mem min/load/max page         : 21408/28545/42816
Socket in/out buffer min          : 4096/4096 bytes
Socket in/out default             : 131072/16384 bytes
Socket in/out buffer max          : 212992/212992 bytes
Socket TIME-WAIT max              : 8192
Socket local port range           : 32768-60999
Net Kernel max backlog            : 1000
Net reverse path filter           : 2
Async IO request curr/max         : 0/65536
Msg queues/count/size max         : 256/10/8192
Descriptor Files use/no use       : 4896/0
Descriptor Files max              : 9223372036854775807
Descriptor max for process        : 1048576
List Open Files/All count         : 4171/6866
Limits configuration count        : 0
Limits last change date           : Sep 18 17:35
User logon before change Limits   :
Limits User Open Files Soft/Hard  : 1024/1048576 count
Limits User File Size  Soft/Hard  : unlimited/unlimited blocks
Limits User Stack Size Soft/Hard  : 8192/unlimited kbytes
Limits User Msg Queues Soft/Hard  : 819200/819200 bytes
Limits User User Proc  Soft/Hard  : 7400/7400 count
Limits User CPU Time   Soft/Hard  : unlimited/unlimited sec
Limits User MEM Size   Soft/Hard  : unlimited/unlimited kbytes
Limits Process Open Files S/H     : 45 1024/1048576 171 1024/4096 42 1024/524288 31 1048576/1048576 1 16384/16384 1 256/256 1 50/50 3 524288/524288 count
Limits Process File Size  S/H     : 1 0/0 294 unlimited/unlimited blocks
Limits Process Stack Size S/H     : 1 204800/unlimited 295 8388608/unlimited kbytes
Limits Process Msg Queues S/H     : 1 0/0 294 819200/819200 bytes
Limits Process User Proc  S/H     : 1 1/1 1 3/3 270 7400/7400 23 unlimited/unlimited count
Limits Process CPU Time   S/H     : 295 unlimited/unlimited sec
Limits Process MEM Size   S/H     : 2 200000/200000 292 unlimited/unlimited kbytes
Quota verison                     : 4.05
Quota current Space use/hard/soft : 388M/400M/500M
Quota current Files use/hard/soft : 3004/0/0
Quota use disk count              : 1
Quota use user Space/Files count  : Permission denied
Bash version                      : 5.0.17
Python version                    : 3.8.10
Java OpenJDK verison              : 17.0.8.1 2023-08-24
Ansible version                   : No installed
Docker/Compose version            : 24.0.5/1.26.0, build d4451659
Docker Volumes/Images             : Permission denied
Docker Running/All                : Permission denied
Docker LISTEN host ports          : Permission denied
Zabbix Agent status               : active (running) since Fri 2023-09-22 10:50:12 MSK; 5 days ago
Zabbix Agent version              : 6.4.6
Zabbix config                     : /etc/zabbix/zabbix_agentd.conf
Zabbix server                     : 192.168.3.102,192.168.3.99
```