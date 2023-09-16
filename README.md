## hwstat

Function collecting hardware and software statistic as well kernel settings from different sources in the operating system for output in one place.

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
- limits
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

Hostname                   : devops-01
Uptime                     : 7 days 22:03 (2023-09-09 01:48:45)
Startup                    : 10.804s (kernel) + 40.423s (userspace) = 51.228s
Local Time                 : Sat 2023-09-16 23:52:22 MSK
Time Zone                  : Europe/Moscow (MSK, +0300)
NTP service/synchronized   : yes/inactive
NTP server sync systemd    : systemd-timesyncd.service inactive
NTPd status                : No installed
TNPd server/pool for sync  :
Syslog service             : active (running) since Wed 2023-09-13 14:58:02 MSK; 3 days ago
Syslog remote server       : 192.168.3.99:514
Syslog today/all error     : 36/242
Journal today/all error    : 61/61
OS                         : Ubuntu 22.04.3 LTS
Kernel                     : Linux 5.15.0-82-generic
Systemd version            : 249.11-0ubuntu3.9
Hypervisor                 : VMware
CPU                        : Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz
Core                       : 1
Architecture               : x86_64
L2                         : 256 KiB
L3                         : 12 MiB
Motherboard                : 440BX Desktop Reference Platform
BIOS                       : Phoenix Technologies LTD
BIOS Version               : 6.00
BIOS Release               : 11.12.2020
Process Started count      : 266
Running/All Process        : 7/555
CPU avg 1/5/15 min         : 2.93 1.83 1.57
CPU avg usr/sys/wa/idle    : 15 13      0       72
CPU cur usr/sys/wa/idle    : 26 33      0       41
IOps avg in/out            : 20 1104
IOps current in/out        : 0  1300
MEM use/all/cache          : 1486/3876/2281 MB
MEM cache/buffer/dirty     : 1747248/292476/1152 KB
SWAP use/all               : 394/3888 MB
SWAP Mount                 : file /swap.img
SWAP Running free mem      : 60 %
Cache background/ratio     : 10/20 %
Cache expire/writeback     : 3000/500 hundredths sec
Ethernet Adapter           : Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
VGA controller             : VMware SVGA II Adapter
Audio controller           : Ensoniq ES1371/ES1373 / Creative Labs CT2518 (rev 02)
SCSI controller            : Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
SATA controller            : VMware SATA AHCI controller
All Disk and Volume        : sda, sda1, sda2, sda3, sdb, sdb1
Disk size                  : sda (50G), sdb (10G)
Disk Running Model         : sda VMware Virtual S 50G, sdb VMware Virtual S 10G
Mount Filesystem free/all  : /dev/mapper/ubuntu--vg-ubuntu--lv (31G/57G), /dev/sda2 (1.6G/2.0G), //192.168.3.100/Backup (336G/1.9T)
Mount fstab count          : 4
LVM Volume Group           : ubuntu-vg pdisk:2 lgroup:2 (976.00m/57.99g)
LVM Physical Volume        : /dev/sda3 -> ubuntu-vg (0/48.00g), [unknown] -> ubuntu-vg (976.00m/10.00g)
LVM Logical Volume         : snap-1 -> ubuntu-vg (1.00g), ubuntu-lv -> ubuntu-vg (56.04g)
MD RAID Level/Status       : No arrays
MD Active/Work/Fail/Spare  :
Network Interfaces         : docker0, docker_gwbridge, ens33
Network Driver/Speed       : docker0 (bridge/10000Mb/s), docker_gwbridge (bridge/10000Mb/s), ens33 (e1000/1000Mb/s)
DNS Resolv configutation   : 127.0.0.53
DNS Resolv conf link       : /run/systemd/resolve/stub-resolv.conf
DNS Server systemd current : 192.168.3.101
DNS Server systemd list    : 192.168.3.101, 8.8.8.8, 1.1.1.1
Hosts file count addreses  : 2
IPv6 disable               : false
Route ip forward           : true
ICMP ignore broadcast/all  : true/false
ICMP accept/send redirect  : false/true
TCP SYN use cookies        : true
TCP fastopen data connect  : 1
TCP SYN max backlog        : 256
TCP SYN-ACK max backlog    : 4096
TCP SYN/SYN-ACK retries    : 6/5
TCP Keepalive Time Live    : 7200+(75*9)=7875 sec
TCP orphan max socket      : 16384
TCP orphan retries count   : 0
TCP FIN timeout socket     : 60 sec
TCP metrics save           : true
TCP mem min/load/max page  : 43971/58628/87942
Socket in/out buffer min   : 4096/4096 byte
Socket in/out default      : 131072/16384 byte
Socket in/out buffer max   : 212992/212992 byte
Socket TIME-WAIT max       : 16384
Socket local port range    : 32768-60999
Net Kernel max backlog     : 1000
Net reverse path filter    : 2
Async IO request curr/max  : 2305/65536
Descriptor Files use/max   : 3040/9223372036854775807
Descriptor max for process : 1048576
List Open Files/All count  : 32577/40241
Limits count               : 0
Socket ESTAB count         : 21
Socket LISTEN unique port  : 2121, 3306, 44662, 59532, 8080
UFW Status                 : active
UFW Rule allow/deny count  : 22/4
FWD Status                 : running
FWD Rule ports/services    : 10/6
Iptables rule count        : 42
Hosts allow/deny services  : 0/0
Unit Startup/All count     : 111/407
Cron tasks curr/all users  : 1/0
APT show auto/manual       : 842 (778/64)
APT Last Update            : 16 Sep 13:54
APT List Upgrade count     : 12
DPKG Packet count          : 853
SNAP Packet count          : 4
User/Group count           : 41/68
User using password        : root, lifailon
User directories           : Jenkins, lifailon
Sudo all conf user count   : 4
Login pass min/max days    : 0/99999
ssh port/login pass/root   : 2121/yes/yes
Bash version               : 5.1.16
Python version             : 3.10.12
Ansible version            : 2.10.8
Docker/Compose version     : 24.0.5/2.21.0
Docker Volumes/Images      : 4/7
Docker Running/All         : 4/11
Docker LISTEN host ports   : 3000, 3001, 5433
Zabbix Agent status        : active (running) since Sat 2023-09-16 23:00:02 MSK; 53min ago
Zabbix Agent version       : 6.4.6
Zabbix config              : /etc/zabbix/zabbix_agentd.conf
Zabbix server              : 192.168.3.102
```

### Example 2:

Use Ubuntu 20.04 and not root permission

```
lifailon@pi-hole-01:~$ bash hwstat.sh

Hostname                   : pi-hole-01
Uptime                     : 1 day 10:53 (2023-09-15 12:57:28)
Startup                    : 10.681s (kernel) + 24.407s (userspace) = 35.088s
Local Time                 : Сб 2023-09-16 23:51:07 MSK
Time Zone                  : Europe/Moscow (MSK, +0300)
NTP service/synchronized   : yes/n/a
NTP server sync systemd    : systemd-timesyncd.service inactive
NTPd status                : active
TNPd server/pool for sync  : 0.ubuntu.pool.ntp.org, 0.ru.pool.ntp.org
Syslog service             : active (running) since Fri 2023-09-15 12:57:46 MSK; 1 day 10h ago
Syslog remote server       : 192.168.3.99:514 192.168.3.105:514
Syslog today/all error     : 0/33
Journal today/all error    : 58/1532
OS                         : Ubuntu 20.04.6 LTS
Kernel                     : Linux 5.4.0-162-generic
Systemd version            : 245.4-4ubuntu3.22
Hypervisor                 : VMware
CPU                        : Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz
Core                       : 1
Architecture               : x86_64
L2                         : 256 KiB
L3                         : 12 MiB
Motherboard                : 440BX Desktop Reference Platform
BIOS                       : Phoenix Technologies LTD
BIOS Version               : 6.00
BIOS Release               : 11.12.2020
Process Started count      : 308
Running/All Process        : 1/614
CPU avg 1/5/15 min         : 0.10 0.08 0.09
CPU avg usr/sys/wa/idle    : 1  1       0       98
CPU cur usr/sys/wa/idle    : 1  3       0       96
IOps avg in/out            : 39 58
IOps current in/out        : 0  124
MEM use/all/cache          : 1101/1940/763 MB
MEM cache/buffer/dirty     : 603344/64756/700 KB
SWAP use/all               : 0/0 MB
SWAP Mount                 :
SWAP Running free mem      : 60 %
Cache background/ratio     : 10/20 %
Cache expire/writeback     : 3000/500 hundredths sec
Ethernet Adapter           : Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
VGA controller             : VMware SVGA II Adapter
Audio controller           : Ensoniq ES1371/ES1373 / Creative Labs CT2518 (rev 02)
SCSI controller            : Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
SATA controller            : VMware SATA AHCI controller
All Disk and Volume        : sda, sda1, sda2, sda3, sdb
Disk size                  : sda (50G), sdb (10G)
Disk Running Model         : sda VMware_Virtual_S 50G, sdb VMware_Virtual_S 10G
Mount Filesystem free/all  : /dev/mapper/ubuntu--vg-ubuntu--lv (31G/48G), /dev/sda2 (698M/974M), /dev/md127 (9,3G/9,8G)
Mount fstab count          : 3
LVM Volume Group           : ubuntu-vg pdisk:1 lgroup:1 (0/49,00g)
LVM Physical Volume        : /dev/sda3 -> ubuntu-vg (0/49,00g)
LVM Logical Volume         : ubuntu-lv -> ubuntu-vg (49,00g)
MD RAID Level/Status       : md127 raid1/clean, degraded
MD Active/Work/Fail/Spare  : 1/1/0/0
Network Interfaces         : docker0, ens33
Network Driver/Speed       : docker0 (bridge/), ens33 (e1000/1000Mb/s)
DNS Resolv configutation   : 8.8.8.8, 1.1.1.1, 127.0.0.53
DNS Resolv conf link       : /run/resolvconf/resolv.conf
DNS Server systemd current : 8.8.8.8
DNS Server systemd list    : 8.8.8.8, 1.1.1.1, 9.9.9.9
Hosts file count addreses  : 2
IPv6 disable               : false
Route ip forward           : true
ICMP ignore broadcast/all  : true/false
ICMP accept/send redirect  : false/true
TCP SYN use cookies        : true
TCP fastopen data connect  : 1
TCP SYN max backlog        : 128
TCP SYN-ACK max backlog    : 4096
TCP SYN/SYN-ACK retries    : 6/5
TCP Keepalive Time Live    : 7200+(75*9)=7875 sec
TCP orphan max socket      : 8192
TCP orphan retries count   : 0
TCP FIN timeout socket     : 60 sec
TCP metrics save           : true
TCP mem min/load/max page  : 21408/28545/42816
Socket in/out buffer min   : 4096/4096 byte
Socket in/out default      : 131072/16384 byte
Socket in/out buffer max   : 212992/212992 byte
Socket TIME-WAIT max       : 8192
Socket local port range    : 32768-60999
Net Kernel max backlog     : 1000
Net reverse path filter    : 2
Async IO request curr/max  : 0/65536
Descriptor Files use/max   : 5184/9223372036854775807
Descriptor max for process : 1048576
List Open Files/All count  : 17937/25989
Limits count               : 0
Socket ESTAB count         : 3
Socket LISTEN unique port  : 2121
UFW Status                 : inactive
UFW Rule allow/deny count  :
FWD Status                 : Permission denied or no installed
FWD Rule ports/services    :
Iptables rule count        : 5
Hosts allow/deny services  : 0/0
Unit Startup/All count     : 381/400
Cron tasks curr/all users  : 0/0
APT show auto/manual       : 1234 (1163/71)
APT Last Update            : 16 сен 22:22
APT List Upgrade count     : 0
DPKG Packet count          : 1256
SNAP Packet count          : 4
User/Group count           : 53/81
User using password        : lifailon
User directories           : lifailon, tester, testuser
Sudo all conf user count   : 5
Login pass min/max days    : 0/99999
ssh port/login pass/root   : 2121/yes
yes/prohibit-password
Bash version               : 5.0.17
Python version             : 3.8.10
Ansible version            : No installed
Docker/Compose version     : 24.0.5/docker-compose version 1.26.0, build d4451659
Docker Volumes/Images      : 4/6
Docker Running/All         : 4/4
Docker LISTEN host ports   : 9001, 9000, 8080, 3001
Zabbix Agent status        : active (running) since Fri 2023-09-15 12:57:47 MSK; 1 day 10h ago
Zabbix Agent version       : 6.4.6
Zabbix config              : /etc/zabbix/zabbix_agentd.conf
Zabbix server              : 192.168.3.102,192.168.3.99
```
