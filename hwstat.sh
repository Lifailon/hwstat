function hwstat {
# apt list --installed
# cat /etc/passwd # кол-во пользв
hn=$(uname -a | awk '{print $2}')
time=$(timedatectl | grep Local | sed -E "s/.+time: //")
tz=$(timedatectl | grep zone | sed -E "s/.+zone: //")
ntp=$(timedatectl | grep NTP | sed -E "s/.+service: //")
srv=$(systemctl status systemd-timesyncd | grep "Status": | sed -E "s/^.+server //; "s/.\"//"")
kernel=$(uname -a | awk '{print $1,$3}')
os=$(lsb_release -d | sed -E "s/Description:\s+//")
vm=$(lscpu | grep Hypervisor | awk '{print $3}')
cpu=$(lscpu | grep "Model name" | sed -E "s/Model name:\s+//")
core=$(lscpu | grep "^CPU(s)" | awk '{print$2}')
arch=$(lscpu | grep "Architecture" | sed -E "s/Architecture:\s+//")
l2=$(lscpu | grep L2 | awk '{print $3,$4}')
l3=$(lscpu | grep L3 | awk '{print $3,$4}')
mem=$(free -m | grep Mem | awk '{print $2}')
swap=$(free -m | grep Swap | awk '{print $2}')
mount=$(swapon | sed '1d' | awk '{print $2,$1}')
mb=$(dmidecode -t baseboard | grep Product | awk -F": " '{print $2}')
bios=$(dmidecode -t bios | grep Vendor | sed -E "s/.+Vendor: //")
ver=$(dmidecode -t bios | grep Version | sed -E "s/.+Version: //")
rel=$(dmidecode -t bios | grep Release | sed -E "s/.+Release Date: //" | sed "s/\//./g")
eth=$(lspci | grep -i ethernet | awk -F": " '{print $NF}')
video=$(lspci | grep -i vga | awk -F": " '{print $NF}')
audio=$(lspci | grep -i audio | awk -F": " '{print $NF}')
scsi=$(lspci | grep -i scsi | awk -F": " '{print $NF}')
sata=$(lspci | grep -i sata | awk -F": " '{print $NF}')
map=$(mount | grep "mapper")
sd=$(ls -l /dev | grep sd | awk '{print $NF}')
sd=$(echo $sd | sed -E "s/\s/, /g")
int=($(ls /sys/class/net))
int=$(echo ${int[@]} | sed "s/ /, /")
dns=$(resolvectl status | grep "Current DNS" | awk -F": " '{print $2}')
echo "Hostname            : $hn"
echo "Local Time          : $time"
echo "Time Zone           : $tz"
echo "NTP service         : $ntp"
echo "NTP server          : $srv"
echo "Kernel              : $kernel"
echo "OS                  : $os"
echo "Hypervisor          : $vm"
echo "CPU                 : $cpu"
echo "Core                : $core"
echo "Architecture        : $arch"
echo "L2                  : $l2"
echo "L3                  : $l3"
echo "Memory              : $mem MB"
echo "SWAP                : $swap MB"
echo "SWAP Mount          : $mount"
echo "Motherboard         : $mb"
echo "BIOS                : $bios"
echo "Version             : $ver"
echo "Release             : $rel"
echo "Ethernet Adapter    : $eth "
echo "VGA controller      : $video"
echo "Audio controller    : $audio"
echo "SCSI controller     : $scsi"
echo "SATA controller     : $sata"
echo "Mount fs            : $map"
echo "Disk                : $sd"
echo "Network Interfaces  : $int"
echo "Current DNS Server  : $dns"
}

hwstat