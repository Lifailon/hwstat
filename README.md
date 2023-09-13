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

### Example:

```bash
root@devops-01:~# bash hwstat.sh

Hostname                  : devops-01
Uptime                    : 4 days 13:51 (2023-09-09 01:46:33)
Startup                   : 10.804s (kernel) + 40.423s (userspace) = 51.228s
GRUB boot param           : BOOT_IMAGE=/vmlinuz-5.15.0-82-generic root=/dev/mapper/ubuntu--vg-ubuntu--lv
Local Time                : Wed 2023-09-13 15:38:18 MSK
Time Zone                 : Europe/Moscow (MSK, +0300)
NTP service               : active
NTP server                : 185.125.190.56:123 (ntp.ubuntu.com)
Syslog service            : active (running) since Wed 2023-09-13 14:58:02 MSK; 40min ago
Syslog local server       : udp:514
Syslog remote server      : 192.168.3.104:514
Syslog today/all error    : 154/154
Journal today/all error   : 57/65
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
Process Started count     : 272
Running/All Process       : 15/551
CPU avg 1/5/15 min        : 3.70 3.37 3.38
CPU avg usr/sys/wa/idle   : 6   8       0       86
CPU cur usr/sys/wa/idle   : 27  26      0       47
IOps avg in/out           : 28  1064
IOps current in/out       : 0   2412
MEM use/all/cache         : 1688/3876/2070 MB
MEM cache/buffer/dirty    : 1456280/324036/1392 KB
SWAP use/all              : 145/3888 MB
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
Mount Filesystem free     : /dev/sda2 (1.6G/2.0G), //192.168.3.100/Backup (304G/1.9T), overlay (36G/57G)
LVM Volume Group          : ubuntu-vg pdisk:2 lgroup:2 (976.00m/57.99g)
LVM Physical Volume       : /dev/sda3 -> ubuntu-vg (0/48.00g), [unknown] -> ubuntu-vg (976.00m/10.00g)
LVM Logical Volume        : snap-1 -> ubuntu-vg (1.00g), ubuntu-lv -> ubuntu-vg (56.04g)
Network Interfaces        : br-fdb5c30fc2a1, docker0, docker_gwbridge, ens33, veth3fb69fe, veth5535ce9
Network Driver/Speed      : docker_gwbridge (bridge/10000Mb/s), ens33 (e1000/1000Mb/s)
Current DNS Server        : 1.1.1.1
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
TCP no metrics save       : false
TCP mem min/load/max page : 43971/58628/87942
Socket in/out buffer min  : 4096/4096 byte
Socket in/out default     : 131072/16384 byte
Socket in/out buffer max  : 212992/212992 byte
Socket TIME-WAIT max      : 16384
Socket local port range   : 32768-60999
Net Kernel max backlog    : 1000
Net reverse path filter   : 2
Descriptor Files use/max  : 2912/9223372036854775807
List Open Files count     : 38694
Limits count              : 0
Socket ESTAB count        : 23
Socket LISTEN unique port : 2121, 3306, 39324, 48674, 8080
UFW Status                : active
UFW Rule allow/deny count : 22/4
FWD Status                : running
FWD Rule ports/services   : 10/6
Iptables rule count       : 34
Unit Startup/All count    : 112/406
Cron jobs enabled count   : 1
APT show auto/manual      : 841 (778/63)
APT Last Update           : 13 Sep 14:27
APT List Upgrade count    : 8
DPKG Packet count         : 852
SNAP Packet count         : 4
User count                : 41
User directories          : Jenkins, lifailon
Bash version              : 5.1.16
Python version            : 3.10.12
Ansible version           : 2.10.8
Docker/Compose version    : 24.0.5/2.21.0
Docker Volumes/Images     : 4/5 (phpmyadmin, postgres, grafana, louislam/uptime-kuma, portainer/agent)
Docker Running/All        : 4/9 (portainer_agent, grafana, uptime-kuma, pgsql)
Docker LISTEN host ports  : 3000, 3001, 5433
Zabbix Agent status       : active (running) since Wed 2023-09-13 09:00:04 MSK; 6h ago
Zabbix Agent version      : 6.4.6
Zabbix config             : /etc/zabbix/zabbix_agentd.conf
Zabbix server             : 192.168.3.102
```
