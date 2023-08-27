function hwstat {
hn=$(uname -a | awk '{print $2}')
uptime=$(uptime | sed -E "s/^ ..:..:.. up //; s/ [0-9] user.+//; s/,//g")
startup=$(systemd-analyze | sed -n "1p" | sed "s/Startup finished in //")
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
mb=$(dmidecode -t baseboard | grep Product | awk -F": " '{print $2}')
bios=$(dmidecode -t bios | grep Vendor | sed -E "s/.+Vendor: //")
ver=$(dmidecode -t bios | grep Version | sed -E "s/.+Version: //")
rel=$(dmidecode -t bios | grep Release | sed -E "s/.+Release Date: //" | sed "s/\//./g")
mem=$(free -m | grep Mem | awk '{print $2}')
swap=$(free -m | grep Swap | awk '{print $2}')
mount=$(swapon | sed '1d' | awk '{print $2,$1}')
eth=$(lspci | grep -i ethernet | awk -F": " '{print $NF}')
video=$(lspci | grep -i vga | awk -F": " '{print $NF}')
audio=$(lspci | grep -i audio | awk -F": " '{print $NF}')
scsi=$(lspci | grep -i scsi | awk -F": " '{print $NF}')
sata=$(lspci | grep -i sata | awk -F": " '{print $NF}')
sd=$(ls -l /dev | grep sd | awk '{print $NF}')
sd=$(echo $sd | sed -E "s/\s/, /g")
lsblk=$(lsblk | grep -w "sd.." | awk '{print $1" ("$4"),"}' | sed -r "s/├─|└─//")
lsblk=$(echo $lsblk | sed -r "s/,$//")
pvs=$(pvs | sed "1d; s/<//" | awk '{print $1" -> "$2" ("$6"/"$5")"}')
vgs=$(vgs | sed "1d; s/<//" | awk '{print $1" pdisk:"$2" lgroup:"$3" ("$7"/"$6")"}')
lvs=$(lvs | sed "1d; s/<//" | awk '{print $1" "$2" ("$4")"}')
usr=$(cat /etc/passwd | wc -l)
home=($(ls /home))
home=$(echo ${home[@]} | sed "s/ /, /")
int=($(ls /sys/class/net))
int=$(echo ${int[@]} | sed "s/ /, /")
dns=$(resolvectl status | grep "Current DNS" | awk -F": " '{print $2}')
unit_all=$(systemctl list-unit-files | sed "1d" | wc -l)
unit_startup=$(systemctl list-unit-files --state=enabled | sed "1d" | wc -l)
dpkg=$(dpkg -l | wc -l)
showauto=$(apt-mark showauto | wc -l)
showmanual=$(apt-mark showmanual | wc -l)
zabbix_status=$(systemctl status zabbix-agent | grep Active | awk -F": " '{print $2}')
zabbix_path=$(systemctl status zabbix-agent | grep -P -o "(?<=-c ).*(?=.conf)" | sed "s/$/.conf/")
zabbix_server=$(cat $zabbix_path | grep -Po "(?<=^Server=).+")
echo "Hostname              : $hn"
echo "Uptime                : $uptime"
echo "Startup               : $startup"
echo "Local Time            : $time"
echo "Time Zone             : $tz"
echo "NTP service           : $ntp"
echo "NTP server            : $srv"
echo "Kernel                : $kernel"
echo "OS                    : $os"
echo "Hypervisor            : $vm"
echo "CPU                   : $cpu"
echo "Core                  : $core"
echo "Architecture          : $arch"
echo "L2                    : $l2"
echo "L3                    : $l3"
echo "Motherboard           : $mb"
echo "BIOS                  : $bios"
echo "BIOS Version          : $ver"
echo "BIOS Release          : $rel"
echo "Memory                : $mem MB"
echo "SWAP                  : $swap MB"
echo "SWAP Mount            : $mount"
echo "Ethernet Adapter      : $eth "
echo "VGA controller        : $video"
echo "Audio controller      : $audio"
echo "SCSI controller       : $scsi"
echo "SATA controller       : $sata"
echo "Disk and Volume       : $sd"
echo "Disk and Volume size  : $lsblk"
echo "Physical Volume       : $pvs"
echo "Volume Group          : $vgs"
echo "Logical Volume        : $lvs"
echo "User count            : $usr"
echo "User directories      : $home"
echo "Network Interfaces    : $int"
echo "Current DNS Server    : $dns"
echo "Unit Startup count    : $unit_startup/$unit_all"
echo "DPKG Packet count     : $dpkg"
echo "APT show auto/manual  : $showauto/$showmanual"
echo "Zabbix agent status   : $zabbix_status"
echo "Zabbix config         : $zabbix_path"
echo "Zabbix server         : $zabbix_server"
}

hwstat