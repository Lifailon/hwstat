## hwstat (Hardware Statistics)

Tool for quickly obtaining information about hardware characteristics, software configuration, kernel and limits in metrics format (in text or `json` format) from various sources built into the operating system.

The script is written primarily for system administrators, so that they don't have to remember all the commands and their parameters, but instead get filtered output in one place.

### Data sources

- `uname`
- `uptime`
- `who`
- `systemd-analyze`
- `systemd-timesyncd`
- `timedatectl`
- `systemctl`
- `ntpd`
- `local`
- `syslog`
- `journalctl`
- `lsb_release`
- `lscpu`
- `dmidecode` **\* use root permission**
- `ps`
- `loadavg`
- `vmstat`
- `free`
- `meminfo`
- `swapon`
- `lshw`
- `lspci`
- `lsblk`
- `df`
- `fstab`
- `lvm` **\* use root permission**
- `md` **\* use root permission**
- `ethtool`
- `networkctl`
- `systemd-resolve`
- `resolvectl`
- `hosts`
- `ss`
- `ufw` **\* use root permission**
- `firewalld` **\* use root permission**
- `nftables` **\* use root permission**
- `iptables` **\* use root permission**
- `hosts`
- `apt`
- `dpkg`
- `snap`
- `users`
- `group`
- `shadow` **\* use root permission**
- `sudoers` **\* use root permission**
- `login.defs`
- `profile`
- `bashrc`
- `ssh`
- `sysctl`
- `lsof` (for full output **use root permission**)
- `limits` for users (for output all users **use root permission**)
- `limits` for processes (format: count unique processes and his `Soft/Hard` metrics)
- `last logon`
- `quota` **\* use root permission**
- `bash`, `python`, `perl`, `pwsh`, `dotnet`, `java`, `node`, `npm`, `go` and `ansible` versions
- `docker` **\* use root permission**
- `zabbix`

### Install

You can run the script from the GitHub repository without installing it:

```bash
curl -sS https://raw.githubusercontent.com/Lifailon/hwstat/rsa/hwstat.sh | bash
# Output in json format:
curl -sS https://raw.githubusercontent.com/Lifailon/hwstat/rsa/hwstat.sh | bash -s -- "json"
```

The script does not make any changes to your system while it is running.

Or run these commands to install the script on your system to run from anywhere:

```bash
sudo curl -s https://raw.githubusercontent.com/Lifailon/hwstat/rsa/hwstat.sh -o /usr/bin/hwstat
sudo chmod +x /usr/bin/hwstat

sudo hwstat json | jq .
```

Example output on `Ubuntu Server` in `Hyper-V hypervisor` using **root permission**:

```json
{
  "Hostname": "hv-dev-101",
  "Uptime": "16:37",
  "Boot time": "1.874s (firmware) + 55.081s (loader) + 25.644s (kernel) + 3min 6.844s (userspace) = 4min 29.445s",
  "Last reboot": "16.01.2025 18:39",
  "Local Time": "Fri 2025-01-17 11:17:15 MSK",
  "Time Zone": "+0300",
  "Language locale use": "en_US.UTF-8",
  "NTP service/synchronized": "yes/active",
  "NTP systemd service status": "active",
  "NTP systemd current server sync": "91.189.91.157:123 (ntp.ubuntu.com)",
  "NTPD status": "inactive",
  "NTPD conf server/pool": "2/0",
  "NTPD current server sync": "",
  "Syslog service": "active (running) since Thu 2025-01-16 18:41:35 MSK; 16h ago",
  "Syslog remote server": "192.168.3.100:514",
  "Syslog today/all error": "0/73",
  "Journal today/all error": "1/319",
  "OS": "Ubuntu 24.04.1 LTS",
  "Kernel": "Linux 6.8.0-51-generic",
  "Systemd version": "255.4-1ubuntu8.4",
  "Hypervisor": "Microsoft",
  "CPU": "Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz",
  "Core": "2",
  "Architecture": "x86_64",
  "Virtualization": "full",
  "L2": "256 KiB",
  "L3": "12 MiB",
  "CPU MHz": "2904.011",
  "Modules count": "114",
  "Motherboard": "Virtual Machine",
  "BIOS": "Microsoft Corporation",
  "BIOS Version": "Hyper-V UEFI Release v4.1",
  "BIOS Release": "06.20.2024",
  "PS Process Started/Threads count": "144/254",
  "Process Running/All to System": "2/253",
  "CPU avg 1/5/15 min": "0.25 0.26 0.17",
  "CPU avg usr/sys/wa/idle": "1/1/0/97",
  "CPU cur usr/sys/wa/idle": "3/3/0/95",
  "IOps avg in/out": "139/123",
  "IOps current in/out": "0/0",
  "MEM use/cache/all": "721/957/1855 MB",
  "MEM cache/buffer/dirty": "826616/68176/292 KB",
  "SWAP use/all": "26/2047 MB",
  "SWAP Mount": "file /swap.img",
  "SWAP Running free mem": "60 %",
  "Cache background/ratio": "10/20 %",
  "Cache expire/writeback": "3000/500 hundredths sec",
  "Ethernet Adapter name/speed/mac": "eth0 1Gbit/s (00:15:5d:08:64:03)",
  "Ethernet Adapter configuration": "autonegotiation=off broadcast=yes driver=hv_netvsc driverversion=6.8.0-51-generic duplex=full firmware=N/A ip=192.168.3.101 link=yes multicast=yes speed=1Gbit/s",
  "Ethernet Adapter description": "",
  "VGA controller": "",
  "Audio controller": "",
  "SCSI controller": "",
  "SATA controller": "",
  "Filesystem type root/boot": "ext4/ext4",
  "All Disk and Volume count": "4",
  "All Disk and Volume names": "sda, sda1, sda2, sda3",
  "Disk size": "sda 100G",
  "Disk all size": "100 GB",
  "Disk Running Model": "sda Virtual Disk 100G, sr0 Virtual DVD-ROM 1024M",
  "Mount Filesystem free/all": "efivarfs (128M/128M), /dev/mapper/ubuntu--vg-ubuntu--lv (74G/95G), /dev/sda2 (1.7G/2.0G), /dev/sda1 (1.1G/1.1G)",
  "Mount fstab count": "4",
  "LVM Volume Group": "ubuntu-vg pdisk:1 lgroup:1 (0/96.95g)",
  "LVM Physical Volume": "/dev/sda3 -> ubuntu-vg (0/96.95g)",
  "LVM Logical Volume": "ubuntu-lv -> ubuntu-vg (96.95g)",
  "MD RAID level/status": "No arrays",
  "MD Active/Work/Fail/Spare": "",
  "Network Interfaces": "docker0, docker_gwbridge, eth0, mpqemubr0",
  "Network Driver/Speed": "docker0 (bridge/10000Mb/s), docker_gwbridge (bridge/10000Mb/s), eth0 (hv_netvsc/1000Mb/s), mpqemubr0 (bridge/Unknown!)",
  "DNS Resolv configuration": "127.0.0.53",
  "DNS Resolv conf link": "/run/systemd/resolve/stub-resolv.conf",
  "DNS Server systemd list": "8.8.8.8, 1.1.1.1",
  "DNS Server systemd current": "8.8.8.8",
  "Socket ESTAB count": "3",
  "Socket LISTEN unique port": "2121, 8080",
  "Hosts file count addreses": "2",
  "Hosts allow/deny services": "0/0",
  "Iptables rule count": "7",
  "UFW version": "0.36.2",
  "UFW status": "active",
  "UFW Rule allow/deny count": "22/4",
  "FWD version": "Not installed",
  "FWD status": "running",
  "FWD Rule ports/services": "10/6",
  "NFT version": "1.0.9",
  "NFT status": "inactive (disabled)",
  "NFT Rule chains/tables count": "12/3",
  "Unit Startup/All count": "110/430",
  "Cron tasks curr/all users": "0/0",
  "APT show auto/manual": "1492 (1436/56)",
  "APT Last Update": "17 Jan 10:20",
  "APT List Upgrade count": "44",
  "DPKG Packet count": "1500",
  "SNAP Packet count": "12",
  "User/Group count": "36/60",
  "User using password": "root, lifailon",
  "User directory": "lifailon, linuxbrew, test",
  "Sudo nopasswd/all count": "1/5",
  "Login pass min/max days": "0/99999",
  "Login idle timeout seconds": "",
  "ssh port/x11/login pass/root": "2121/yes/yes/yes",
  "ssh keepalive/interval/count": "yes/0/3",
  "IPv6 disable": "false",
  "Route ip forward": "true",
  "ICMP ignore broadcast/all": "true/false",
  "ICMP accept/send redirect": "false/true",
  "TCP SYN use cookies": "true",
  "TCP fastopen data connect": "1",
  "TCP SYN max backlog": "256",
  "TCP SYN-ACK max backlog": "4096",
  "TCP SYN/SYN-ACK retries": "6/5",
  "TCP Keepalive Time Live": "7200+(75*9)=7875 sec",
  "TCP orphan max socket": "16384",
  "TCP orphan retries count": "0",
  "TCP FIN timeout socket": "60 sec",
  "TCP metrics save": "true",
  "TCP mem min/load/max page": "44943/59927/89886",
  "Socket in/out buffer min": "4096/4096 bytes",
  "Socket in/out default": "131072/16384 bytes",
  "Socket in/out buffer max": "212992/212992 bytes",
  "Socket TIME-WAIT max": "16384",
  "Socket local port range": "32768-60999",
  "Net Kernel max backlog": "1000",
  "Net reverse path filter": "2",
  "Async IO request curr/max": "0/65536",
  "Msg queues/count/size max": "256/10/8192",
  "Descriptor Files use/no use": "1664/0",
  "Descriptor Files max": "9223372036854775807",
  "Descriptor max for process": "1048576",
  "List Open Files/All count": "3802/7053",
  "Limits configuration count": "0",
  "Limits last change date": "Apr 10 2024",
  "User logon before change Limits": "",
  "Limits User Open Files Soft/Hard": "35 1024/1048576 count",
  "Limits User File Size Soft/Hard": "35 unlimited/unlimited blocks",
  "Limits User Stack Size Soft/Hard": "35 8192/unlimited kbytes",
  "Limits User Msg Queues Soft/Hard": "35 819200/819200 bytes",
  "Limits User User Proc Soft/Hard": "35 15377/15377 count",
  "Limits User CPU Time Soft/Hard": "35 unlimited/unlimited sec",
  "Limits User MEM Size Soft/Hard": "35 unlimited/unlimited kbytes",
  "Limits Process Open Files S/H": "20 1024/1048576 87 1024/4096 16 1024/524288 18 1048576/1048576 1 16384/16384 3 524288/524288 count",
  "Limits Process File Size S/H": "146 unlimited/unlimited blocks",
  "Limits Process Stack Size S/H": "147 8388608/unlimited kbytes",
  "Limits Process Msg Queues S/H": "147 819200/819200 bytes",
  "Limits Process User Proc S/H": "133 15377/15377 12 unlimited/unlimited count",
  "Limits Process CPU Time S/H": "147 unlimited/unlimited sec",
  "Limits Process MEM Size S/H": "147 unlimited/unlimited kbytes",
  "Quota verison": "4.06",
  "Quota current Space use/hard/soft": "388M/400M/500M",
  "Quota current Files use/hard/soft": "3004/0/0",
  "Quota use disk count": "1",
  "Quota use user Space/Files count": "3/2",
  "Bash version": "5.2.21",
  "Python version": "3.12.3",
  "Perl version": "5.38.2",
  "PowerShell Core version": "7.4.6",
  "Dotnet Runtime version": "8.0.12",
  "Java OpenJDK verison": "21.0.5",
  "Node.js verison": "9.2.0",
  "NPM verison": "18.19.1",
  "Go verison": "1.23.4",
  "Ansible version": "Not installed",
  "Docker version": "24.0.7",
  "Docker Compose version": "Not installed",
  "Docker Volumes/Images": "0/3",
  "Docker Containers running/All": "2/2",
  "Docker LISTEN host ports": "9999",
  "Zabbix Agent status": "active (running)",
  "Zabbix Agent version": "6.4.6",
  "Zabbix config": "/etc/zabbix/zabbix_agentd.conf",
  "Zabbix server": "192.168.3.102"
}
```
