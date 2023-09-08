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
- versions
- docker **(use root permission)**
- zabbix

### Example:

```bash
root@devops-01:~# bash hwstat.sh

Hostname                : devops-01
Uptime                  : 6 days 10:15
Startup                 : 10.804s (kernel) + 40.423s (userspace) = 51.228s
Local Time              : Fri 2023-09-08 22:00:02 MSK
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
Process Started count   : 295
Running/All Process     : 2/526
CPU avg 1/5/15 min      : 1.76 1.33 1.10
CPU avg usr/sys/wa/idle : 4     7       0       88
CPU cur usr/sys/wa/idle : 9     12      1       77
IOps avg in/out         : 26    1046
IOps current in/out     : 64    1204
MEM use/all/cache       : 1572/3876/2172 MB
MEM cache/buffer/dirty  : 1214080/442264/436 KB
SWAP use/all            : 309/3888 MB
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
Mount Filesystem free   : /dev/sda2 (1.6G/2.0G), //192.168.3.100/Backup (497G/1.9T), /dev/sdc1 (4.8G/5.0G), overlay (35G/57G), shm (63M/64M), overlay (35G/57G), shm (64M/64M)
LVM Volume Group        : ubuntu-vg pdisk:2 lgroup:2 (976.00m/57.99g)
LVM Physical Volume     : /dev/sda3 -> ubuntu-vg (0/48.00g), /dev/sdb1 -> ubuntu-vg (976.00m/10.00g)
LVM Logical Volume      : snap-1 -> ubuntu-vg (1.00g), ubuntu-lv -> ubuntu-vg (56.04g)
Network Interfaces      : br-08c386e371e6, docker0, ens33, ens37, veth1a7934d, veth608677e
Network Driver/Speed    : br-08c386e371e6 (bridge/10000Mb/s), docker0 (bridge/Unknown!), ens33 (e1000/1000Mb/s), ens37 (e1000/1000Mb/s), veth1a7934d (veth/10000Mb/s), veth608677e (veth/10000Mb/s)
Current DNS Server      : 8.8.8.8
DNS Server List         : 172.17.0.1, 172.18.0.1, 192.168.3.101, 8.8.8.8, 1.1.1.1
TCP max syn backlog     : 256
TCP max connect backlog : 4096
Net Kernel max backlog  : 1000
TCP Keepalive Time Live : 7200+(75*9)=7875
ICMP ignore             : false
Route ip forward        : true
Descriptor File use/max : 2816/9223372036854775807
List Open Files count   : 42845
All dir and files count : 655991
Limits count            : 0
Socket ESTAB count      : 24
Unique open net ports   : 2121, 3306, 57934, 8080
iptables rule count     : 32
UFW Status              : inactive
Unit Startup count      : 113/405
APT show auto/manual    : 837 (773/64)
APT Last Update         : 8 Sep 21:59
APT List Upgrade count  : 1
DPKG Packet count       : 848
SNAP Packet count       : 4
User count              : 41
User directories        : Jenkins, lifailon
Bash version            : 5.1.16(1)-release (x86_64-pc-linux-gnu)
Python version          : 3.10.12
Ansible version         : 2.10.8
Docker/Compose version  : 24.0.5, build 24.0.5-0ubuntu1~22.04.1/1.26.0, build d4451659
Docker images           : 2 (postgres, louislam/uptime-kuma)
Docker running          : 2 (uptime-kuma, pgsql)
Docker listen host port : 3001, 5433
Zabbix Agent status     : active (running) since Thu 2023-09-07 23:00:01 MSK; 23h ago
Zabbix Agent version    : 6.4.6
Zabbix config           : /etc/zabbix/zabbix_agentd.conf
Zabbix server           : 192.168.3.102
```
