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
- dmidecode (use root permission)
- ps
- loadavg
- vmstat
- vmstat
- free
- swapon
- sysctl
- lspci
- lsblk
- df
- lvm (use root permission)
- resolvectl
- networkctl
- lsof
- du
- limits
- ss
- iptables
- ufw
- apt
- dpkg
- snap
- version

### Example:

```bash
root@devops-01:~# bash hwstat.sh

Hostname                : devops-01
Uptime                  : 4 days  4:44
Startup                 : 10.804s (kernel) + 40.423s (userspace) = 51.228s
Local Time              : Wed 2023-09-06 16:28:19 MSK
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
Process Started count   : 264
Running/All Process     : 1/424
CPU avg 1/5/15 min      : 0.42 0.56 0.58
CPU avg usr/sys/wa/idle : 4     6       0       90
CPU cur usr/sys/wa/idle : 8     14      0       77
IOps avg in/out         : 27    1011
IOps current in/out     : 0     800
Memory use/all          : 1628/3876 MB
SWAP use/all            : 85/3888 MB
SWAP Mount              : file /swap.img
SWAP Running free mem   : 60%
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
Network Interfaces      : ens33, lo
Current DNS Server      : 192.168.3.101
DNS Server List         : 192.168.3.101, 8.8.8.8, 1.1.1.1
TCP max syn backlog     : 256
TCP max connect backlog : 4096
Net Kernel max backlog  : 1000
TCP Keepalive Time Live : 7200+(75*9)=7875
ICMP ignore             : false
Route ip forward        : false
Descriptor File use/max : 2560/9223372036854775807
List Open Files count   : 36526
All dir and files count : 518436
Limits count            : 0
Socket ESTAB count      : 20
Unique open net ports   : 2121, 3306, 57934
iptables rule count     : 1
UFW Status              : inactive
Unit Startup count      : 109/398
APT show auto/manual    : 826 (767/59)
APT Last Update         : 6 Sep 15:14
APT List Upgrade count  : 2
DPKG Packet count       : 837
SNAP Packet count       : 4
User count              : 41
User directories        : Jenkins, lifailon
Bash version            : 5.1.16(1)-release (x86_64-pc-linux-gnu)
Python version          : 3.10.12
Zabbix Agent status     : active (running) since Tue 2023-09-05 23:00:01 MSK; 17h ago
Zabbix Agent version    : 6.4.6
Zabbix config           : /etc/zabbix/zabbix_agentd.conf
Zabbix server           : 192.168.3.102
```
