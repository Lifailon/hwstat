## hwstat

Function collecting hardware statistic from different sources in the operating system for output in one place.

Tested by Ubuntu Server 20.04.2 and 22.04.2.

**Sources of data collection:**
- uname
- timedatectl
- systemctl
- lsb_release
- lscpu
- free
- swapon
- dmidecode (use root permission)
- lspci
- mount
- ls `/dev` and `/sys/class/net`
- resolvectl

### Example:

```bash
root@devops-01:~# bash hwstat.sh

Hostname            : devops-01
Local Time          : Fri 2023-08-25 16:33:08 MSK
Time Zone           : Europe/Moscow (MSK, +0300)
NTP service         : active
NTP server          : 185.125.190.56:123 (ntp.ubuntu.com)
Kernel              : Linux 5.15.0-79-generic
OS                  : Ubuntu 22.04.2 LTS
Hypervisor          : VMware
CPU                 : Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz
Core                : 1
Architecture        : x86_64
L2                  : 256 KiB
L3                  : 12 MiB
Memory              : 3876 MB
SWAP                : 3888 MB
SWAP Mount          : file /swap.img
Motherboard         : 440BX Desktop Reference Platform
BIOS                : Phoenix Technologies LTD
Version             : 6.00
Release             : 11.12.2020
Ethernet Adapter    : Intel Corporation 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
VGA controller      : VMware SVGA II Adapter
Audio controller    : Ensoniq ES1371/ES1373 / Creative Labs CT2518 (rev 02)
SCSI controller     : Broadcom / LSI 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 01)
SATA controller     : VMware SATA AHCI controller
Mount fs            : /dev/mapper/ubuntu--vg-ubuntu--lv on / type ext4 (rw,relatime)
Disk                : sda, sda1, sda2, sda3
Network Interfaces  : ens33, lo
Current DNS Server  : 192.168.3.101
```
