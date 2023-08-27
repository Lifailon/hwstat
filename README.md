## hwstat

Function collecting hardware statistic from different sources in the operating system for output in one place.

It is convenient for the system administrator to get all the information quickly without having to remember all the commands and filter the output.

Tested by Ubuntu Server 20.04.2 and 22.04.2.

**Sources of data collection:**
- uname
- timedatectl
- systemctl
- lsb_release
- lscpu
- dmidecode (use root permission)
- free
- swapon
- lspci
- lsblk
- lvm (pvs, vgs, lvs)
- resolvectl
- dpkg
- apt-mark
- limits

### Example:

```bash
root@devops-01:~# bash hwstat.sh

Hostname              : devops-01
Local Time            : Sun 2023-08-27 13:25:13 MSK
Time Zone             : Europe/Moscow (MSK, +0300)
NTP service           : active
NTP server            : 91.189.91.157:123 (ntp.ubuntu.com)
Kernel                : Linux 5.15.0-79-generic
OS                    : Ubuntu 22.04.3 LTS
Hypervisor            : VMware
CPU                   : Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz
Core                  : 1
Architecture          : x86_64
L2                    : 256 KiB
L3                    : 12 MiB
Motherboard           : 440BX Desktop Reference Platform
BIOS                  : Phoenix Technologies LTD
BIOS Version          : 6.00
BIOS Release          : 11.12.2020
Memory                : 3876 MB
SWAP                  : 3888 MB
SWAP Mount            : file /swap.img
Ethernet Adapter      : Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
VGA controller        : VMware SVGA II Adapter
Audio controller      : Ensoniq ES1371/ES1373 / Creative Labs CT2518 (rev 02)
SCSI controller       : Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
SATA controller       : VMware SATA AHCI controller
Disk and Volume       : sda, sda1, sda2, sda3
Disk and Volume size  : sda (50G), sda1 (1M), sda2 (2G), sda3 (48G)
Physical Volume       : /dev/sda3 -> ubuntu-vg (0/48.00g)
Volume Group          : ubuntu-vg pdisk:1 lgroup:1 (0/48.00g)
Logical Volume        : ubuntu-lv ubuntu-vg (48.00g)
User count            : 38
User directories      : Jenkins, lifailon
Network Interfaces    : ens33, lo
Current DNS Server    : 192.168.3.101
DPKG Packet count     : 782
APT show auto/manual  : 732/45
Zabbix agent status   : active (running) since Sat 2023-08-26 23:00:01 MSK; 14h ago
Zabbix config         : /etc/zabbix/zabbix_agentd.conf
Zabbix server         : 192.168.3.102
```
