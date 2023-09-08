function hwstat {
hn=$(uname -a | awk '{print $2}')
uptime=$(uptime | sed -E "s/^ ..:..:.. up //; s/ [0-9] user.+//; s/,//g")
startup=$(systemd-analyze | sed -n "1p" | sed "s/Startup finished in //")
time=$(timedatectl | grep Local | sed -E "s/.+time: //")
tz=$(timedatectl | grep zone | sed -E "s/.+zone: //")
ntp=$(timedatectl | grep NTP | sed -E "s/.+service: //")
srv=$(systemctl status systemd-timesyncd | grep "Status": | sed -E "s/^.+server //; "s/.\"//"")
os=$(lsb_release -d | sed -E "s/Description:\s+//")
kernel=$(uname -a | awk '{print $1,$3}')
systemd_ver=$(systemd --version | grep -Eo "\(.+\)" | sed -E "s/\(|\)//g")
vm=$(lscpu | grep Hypervisor | awk '{print $3}')
cpu=$(lscpu | grep "Model name" | sed -E "s/Model name:\s+//")
core=$(lscpu | grep "^CPU(s)" | awk '{print$2}')
arch=$(lscpu | grep "Architecture" | sed -E "s/Architecture:\s+//")
l2=$(lscpu | grep L2 | awk '{print $3,$4}')
l3=$(lscpu | grep L3 | awk '{print $3,$4}')
mb=$(dmidecode -t baseboard 2> /dev/null | grep Product | awk -F": " '{print $2}')
bios=$(dmidecode -t bios 2> /dev/null | grep Vendor | sed -E "s/.+Vendor: //")
ver=$(dmidecode -t bios 2> /dev/null | grep Version | sed -E "s/.+Version: //")
rel=$(dmidecode -t bios 2> /dev/null | grep Release | sed -E "s/.+Release Date: //" | sed "s/\//./g")
ps=$(ps -A | sed 1d | wc -l)
run=$(cat /proc/loadavg | awk '{print $4}')
avg=$(cat /proc/loadavg | awk '{print $1,$2,$3}')
vmstat=$(vmstat 1 2)
vms_avg=$(printf "%s\n" "${vmstat[@]}" | sed -n 3p)
vms_cur=$(printf "%s\n" "${vmstat[@]}" | sed -n 4p)
us_avg=$(echo $vms_avg | awk '{print $13}')
us_cur=$(echo $vms_cur | awk '{print $13}')
sy_avg=$(echo $vms_avg | awk '{print $14}')
sy_cur=$(echo $vms_cur | awk '{print $14}')
wa_avg=$(echo $vms_avg | awk '{print $16}')
wa_cur=$(echo $vms_cur | awk '{print $16}')
id_avg=$(echo $vms_avg | awk '{print $15}')
id_cur=$(echo $vms_cur | awk '{print $15}')
bi_avg=$(echo $vms_avg | awk '{print $9}')
bi_cur=$(echo $vms_cur | awk '{print $9}')
bo_avg=$(echo $vms_avg | awk '{print $10}')
bo_cur=$(echo $vms_cur | awk '{print $10}')
mem_all=$(free -m | grep Mem | awk '{print $2}')
mem_use=$(free -m | grep Mem | awk '{print $3}')
mem_cache=$(free -m | grep Mem | awk '{print $6}')
cache=$(cat /proc/meminfo | grep -iE "^cache" | awk '{print $2}')
buf=$(cat /proc/meminfo | grep -iE "^buff" | awk '{print $2}')
dirty=$(cat /proc/meminfo | grep -iE "Dirty" | awk '{print $2}')
drop_cache=$(ls -l /proc/sys/vm/drop_caches | awk '{print $7,$6,$8}')
swap_all=$(free -m | grep Swap | awk '{print $2}')
swap_use=$(free -m | grep Swap | awk '{print $3}')
mount=$(swapon | sed '1d' | awk '{print $2,$1}')
swaprun=$(sysctl vm.swappiness 2> /dev/null | awk -F "= " '{print $2}')
back_ratio=$(sysctl vm.dirty_background_ratio 2> /dev/null | awk -F "= " '{print $2}')
ratio=$(sysctl vm.dirty_ratio 2> /dev/null | awk -F "= " '{print $2}')
expire=$(sysctl vm.dirty_expire_centisecs 2> /dev/null | awk -F "= " '{print $2}')
writeback=$(sysctl vm.dirty_writeback_centisecs 2> /dev/null | awk -F "= " '{print $2}')
eth=$(lspci | grep -i ethernet | awk -F": " '{print $NF}' | sed -n 1p)
video=$(lspci | grep -i vga | awk -F": " '{print $NF}')
audio=$(lspci | grep -i audio | awk -F": " '{print $NF}')
scsi=$(lspci | grep -i scsi | awk -F": " '{print $NF}')
sata=$(lspci | grep -i sata | awk -F": " '{print $NF}')
sd=$(ls -l /dev | grep sd | awk '{print $NF}')
sd=$(echo $sd | sed -E "s/\s/, /g")
lsblk=$(lsblk | grep -w "sd." | awk '{print $1" ("$4"),"}')
lsblk=$(echo $lsblk | sed -r "s/,$//")
diskmodel=$(lsblk -o NAME,MODEL,SIZE,STATE --nodeps | grep -Ew "running" | awk '{print $0","}' | sed -E "s/ running//")
diskmodel=$(echo $diskmodel | sed -r "s/,$//")
df=$(df -h | sed 1d | grep -vE "mapper|vg|lv|tmpfs" | awk '{print $1" ("$4"/"$2"),"}')
df=$(echo $df | sed -r "s/,$//")
vgs=$(vgs 2> /dev/null | sed "1d; s/<//" | awk '{print $1" pdisk:"$2" lgroup:"$3" ("$7"/"$6"),"}')
vgs=$(echo $vgs | sed -r "s/,$//")
pvs=$(pvs 2> /dev/null | sed "1d; s/<//" | awk '{print $1" -> "$2" ("$6"/"$5"),"}')
pvs=$(echo $pvs | sed -r "s/,$//")
lvs=$(lvs 2> /dev/null | sed "1d; s/<//" | awk '{print $1" -> "$2" ("$4"),"}')
lvs=$(echo $lvs | sed -r "s/,$//")
int=($(ls /sys/class/net | sed "s/lo//"))
interface=$(echo ${int[@]} | sed "s/ /, /g")
net_driver=()
for i in ${int[@]}
do
driver=$(ethtool -i $i 2> /dev/null | grep driver | sed "s/driver: //")
speed=$(ethtool $i 2> /dev/null | grep -i speed | sed -E "s/.+: //")
net_driver+=($(echo "$i ($driver/$speed),"))
done
net_driver=$(echo ${net_driver[@]} | sed "s/,$//")
dns=$(resolvectl status | grep "Current DNS" | awk -F": " '{print $2}')
dnslist=$(networkctl status | sed -E "s/Gateway.+//; s/Address.+//" | grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")
dnslist=$(echo $dnslist | sed "s/ /, /g")
tcp_max_syn_backlog=$(sysctl net.ipv4.tcp_max_syn_backlog 2> /dev/null | awk -F "= " '{print $2}')
somaxconn=$(sysctl net.core.somaxconn 2> /dev/null | awk -F "= " '{print $2}')
netdev_max_backlog=$(sysctl net.core.netdev_max_backlog 2> /dev/null | awk -F "= " '{print $2}')
tcp_keepalive=$(sysctl -a 2> /dev/null | grep net.ipv4.tcp_keepalive | grep -Po "(?<=\=\s)[0-9]+")
keep_print=$(echo $tcp_keepalive | awk '{print $3"+("$1"*"$2")"}')
keep_sum=$(echo $tcp_keepalive | awk '{print $3+($1*$2)}')
icmp_ignore=$(cat /proc/sys/net/ipv4/icmp_echo_ignore_all)
icmp=$(if (( $(echo "$icmp_ignore == 1" | bc) )); then echo "true"; else echo "false"; fi)
route=$(cat /proc/sys/net/ipv4/ip_forward)
route_ip_forward=$(if (( $(echo "$route == 1" | bc) )); then echo "true"; else echo "false"; fi)
use=$(cat /proc/sys/fs/file-nr | awk '{print $1}')
descriptor=$(sysctl fs.file-max 2> /dev/null | awk -F "= " '{print $2}')
lsof=$(lsof 2> /dev/null | sed 1d | wc -l)
du=$(du -a / 2> /dev/null | wc -l)
limits=$(cat /etc/security/limits.conf | grep -Ev "^$|^#" | wc -l)
ss=$(ss -tun | wc -l)
ports=$(ss -tun | sed 1d | awk '{print $5}' | awk -F ":" '{print $NF","}' | sort | uniq)
ports=$(echo $ports | sed -r "s/,$//")
iptables=$(echo $(( $(iptables -L  2> /dev/null | wc -l) - 8 )) )
if [ $iptables -eq "-8" ]; then iptables=$(/dev/null 2> /dev/null); fi
ufw=$(ufw status 2> /dev/null | awk '{print $2}')
unit_all=$(systemctl list-unit-files | sed "1d" | wc -l)
unit_startup=$(systemctl list-unit-files --state=enabled | sed "1d" | wc -l)
apt_list=$(apt list --installed 2> /dev/null | sed 1d | wc -l)
showauto=$(apt-mark showauto | wc -l)
showmanual=$(apt-mark showmanual | wc -l)
last_update=$(ls -l /var/cache/apt/pkgcache.bin | awk '{print $7,$6,$8}')
list_update=$(apt list --upgradable 2> /dev/null | sed 1d |  wc -l)
dpkg=$(dpkg -l | wc -l)
snap=$(snap list | sed 1d | wc -l)
usr=$(cat /etc/passwd | wc -l)
home=($(ls /home))
home=$(echo ${home[@]} | sed "s/ /, /g")
bash=$(bash --version | sed -n 1p | sed -E "s/.+version //")
python=$(python3 --version | sed "s/Python //")
ansible=$(ansible --version 2> /dev/null | sed -n 1p | sed "s/ansible //")
if [ ${#ansible} -eq 0 ]
then
ansible="Not installed"
fi
docker_version=$(docker --version 2> /dev/null | sed "s/Docker version //")
if [ ${#docker_version} -ne 0 ]
then
docker_compose_version=$(docker-compose --version 2> /dev/null | sed "s/docker-compose version //")
docker_images=$(docker images | sed 1d | awk '{print $1}')
docker_images=$(echo ${docker_images[@]} | sed "s/ /, /g")
docker_images_count=$(echo $docker_images | wc -w)
docker_ps=$(docker ps | sed 1d | awk '{print $NF}')
docker_ps=$(echo ${docker_ps[@]} | sed "s/ /, /g")
docker_ps_count=$(echo $docker_ps | wc -w)
docker_host_port=$(docker inspect $(docker ps -q) --format='{{.NetworkSettings.Ports}}' | grep -Po "[0-9]+(?=}]])")
docker_host_port=$(echo ${docker_host_port[@]} | sed "s/ /, /g")
docker_v=$(echo "$docker_version/$docker_compose_version")
docker_i=$(echo "$docker_images_count ($docker_images)")
docker_p=$(echo "$docker_ps_count ($docker_ps)")
else
docker_v="Not installed"
fi
zabbix_service=$(systemctl status zabbix-agent 2> /dev/null)
zabbix_status=$(printf "%s\n" "${zabbix_service[@]}" | grep Active | awk -F": " '{print $2}')
zabbix_test=$(echo $zabbix_status | grep -wo "active")
if [ ${#zabbix_test} -gt 0 ]
then
zabbix_agent=$(printf "%s\n" "${zabbix_service[@]}" | grep -P " -c " | sed -n 1p | sed -E "s/ -c.+//; s/.+=//" | awk '{print $NF}')
zabbix_ver=$($zabbix_agent --version | sed -n 1p | grep -Eo [0-9].+)
zabbix_conf=$(printf "%s\n" "${zabbix_service[@]}" | grep -P -o "(?<=-c ).*(?=.conf)" | sed "s/$/.conf/")
zabbix_server=$(cat $zabbix_conf | grep -Po "(?<=^Server=).+")
else
zabbix_ver=$(/dev/null 2> /dev/null)
zabbix_conf=$(/dev/null 2> /dev/null)
zabbix_server=$(/dev/null 2> /dev/null)
fi
echo
echo "Hostname                : $hn"
echo "Uptime                  : $uptime"
echo "Startup                 : $startup"
echo "Local Time              : $time"
echo "Time Zone               : $tz"
echo "NTP service             : $ntp"
echo "NTP server              : $srv"
echo "OS                      : $os"
echo "Kernel                  : $kernel"
echo "Systemd version         : $systemd_ver"
echo "Hypervisor              : $vm"
echo "CPU                     : $cpu"
echo "Core                    : $core"
echo "Architecture            : $arch"
echo "L2                      : $l2"
echo "L3                      : $l3"
echo "Motherboard             : $mb"
echo "BIOS                    : $bios"
echo "BIOS Version            : $ver"
echo "BIOS Release            : $rel"
echo "Process Started count   : $ps"
echo "Running/All Process     : $run"
echo "CPU avg 1/5/15 min      : $avg"
echo -e "CPU avg usr/sys/wa/idle : $us_avg\t$sy_avg\t$wa_avg\t$id_avg"
echo -e "CPU cur usr/sys/wa/idle : $us_cur\t$sy_cur\t$wa_cur\t$id_cur"
echo -e "IOps avg in/out         : $bi_avg\t$bo_avg"
echo -e "IOps current in/out     : $bi_cur\t$bo_cur"
echo "MEM use/all/cache       : $mem_use/$mem_all/$mem_cache MB"
echo "MEM cache/buffer/dirty  : $cache/$buf/$dirty KB"
echo "SWAP use/all            : $swap_use/$swap_all MB"
echo "SWAP Mount              : $mount"
echo "SWAP Running free mem   : $swaprun %"
echo "Cache background/ratio  : $back_ratio/$ratio %"
echo "Cache expire/writeback  : $expire/$writeback hundredths sec"
echo "Ethernet Adapter        : $eth"
echo "VGA controller          : $video"
echo "Audio controller        : $audio"
echo "SCSI controller         : $scsi"
echo "SATA controller         : $sata"
echo "All Disk and Volume     : $sd"
echo "Disk size               : $lsblk"
echo "Disk Running Model      : $diskmodel"
echo "Mount Filesystem free   : $df"
echo "LVM Volume Group        : $vgs"
echo "LVM Physical Volume     : $pvs"
echo "LVM Logical Volume      : $lvs"
echo "Network Interfaces      : $interface"
echo "Network Driver/Speed    : $net_driver"
echo "Current DNS Server      : $dns"
echo "DNS Server List         : $dnslist"
echo "TCP max syn backlog     : $tcp_max_syn_backlog"
echo "TCP max connect backlog : $somaxconn"
echo "Net Kernel max backlog  : $netdev_max_backlog"
echo "TCP Keepalive Time Live : $keep_print=$keep_sum"
echo "ICMP ignore             : $icmp"
echo "Route ip forward        : $route_ip_forward"
echo "Descriptor File use/max : $use/$descriptor"
echo "List Open Files count   : $lsof"
echo "All dir and files count : $du"
echo "Limits count            : $limits"
echo "Socket ESTAB count      : $ss"
echo "Unique open net ports   : $ports"
echo "iptables rule count     : $iptables"
echo "UFW Status              : $ufw"
echo "Unit Startup count      : $unit_startup/$unit_all"
echo "APT show auto/manual    : $apt_list ($showauto/$showmanual)"
echo "APT Last Update         : $last_update"
echo "APT List Upgrade count  : $list_update"
echo "DPKG Packet count       : $dpkg"
echo "SNAP Packet count       : $snap"
echo "User count              : $usr"
echo "User directories        : $home"
echo "Bash version            : $bash"
echo "Python version          : $python"
echo "Ansible version         : $ansible"
echo "Docker/Compose version  : $docker_v"
echo "Docker images           : $docker_i"
echo "Docker running          : $docker_p"
echo "Docker listen host port : $docker_host_port"
echo "Zabbix Agent status     : $zabbix_status"
echo "Zabbix Agent version    : $zabbix_ver"
echo "Zabbix config           : $zabbix_conf"
echo "Zabbix server           : $zabbix_server"
echo
}

hwstat