#!/bin/bash
function hwstat {
hn=$(uname -a | awk '{print $2}')
uptime=$(uptime | sed -E "s/^ ..:..:.. up[ ]+//; s/ [0-9] user.+//; s/,//g")
uptime=$(echo "$uptime ($(uptime -s))" | sed "s/  / /")
startup=$(systemd-analyze | sed -n "1p" | sed "s/Startup finished in //")
time=$(timedatectl | grep Local | sed -E "s/.+time: //")
#grub_boot_param=$(cat /proc/cmdline)
tz=$(timedatectl | grep zone | sed -E "s/.+zone: //")
ntp_sync=$(timedatectl | grep synchronized | sed -E "s/.+synchronized: //; s/\s//g")
ntp_service=$(timedatectl | grep NTP | sed -E "s/.+service: //")
ntp_systemd=$(systemctl status systemd-timesyncd)
ntp_status=$(printf "%s\n" "${ntp_systemd[@]}" | grep -Eo "Active:\s[a-z]+\s" | sed "s/Active: //")
if [ $ntp_status == "active" ]
then
ntp_server=$(printf "%s\n" "${ntp_systemd[@]}" | grep "Status": | sed -E "s/^.+server //; "s/.\"//"")
fi
ntpd=$(systemctl status ntp 2> /dev/null | grep -Eo "Active:\s[a-z]+\s" | sed "s/Active: //")
if [ ${#ntpd} -eq 0 ]
then
ntpd_status="No installed"
else
ntpd_status=$ntpd
ntpd_server=$(cat /etc/ntp.conf | grep -E "^server" | awk '{print $2}' | wc -l)
ntpd_pool=$(cat /etc/ntp.conf | grep -E "^pool" | awk '{print $2}' | wc -l)
ntpd_sp=$(echo "$ntp_server/$ntpd_pool")
ntpd_current_server=$(ntpq -p | grep -Eo "^\*[a-z.]+\s+[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+" | sed "s/  / /; s/*//")
fi
syslog_status=$(systemctl status rsyslog 2> /dev/null | grep Active: | awk -F ": " '{print $2}')
#syslog_local_server=$(cat /etc/rsyslog.conf | grep "^input" | awk -F "=" '{print $2,$3}' | tr -d "im" | sed -r 's/\"//g; s/\)//; s/ port /:/')
#syslog_local_server=$(echo ${syslog_local_server[@]})
syslog_path=$(cat /etc/rsyslog.conf | grep "\$IncludeConfig" | awk '{print $NF}')
syslog_remote_server=($(cat $syslog_path | grep -Po "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+\:[0-9]+"))
syslog_remote_server=$(echo ${syslog_remote_server[@]})
date=$(date "+%b %e")
syslog_error_today=$(cat /var/log/syslog | grep "$date\s" | grep -Ei "error:" | wc -l)
syslog_error_all=$(cat /var/log/syslog | grep -Ei "error:" | wc -l)
journalctl_all=$(journalctl -p 3 | wc -l)
journalctl_today=$(journalctl -p 3 --since today | wc -l)
os=$(lsb_release -d | sed -E "s/Description:\s+//")
kernel=$(uname -a | awk '{print $1,$3}')
systemd_ver=$(systemd --version | grep -Eo "\(.+\)" | sed -E "s/\(|\)//g")
vm=$(lscpu | grep Hypervisor | awk '{print $3}')
cpu=$(lscpu | grep "Model name" | sed -E "s/Model name:\s+//")
core=$(lscpu | grep "^CPU(s)" | awk '{print$2}')
arch=$(lscpu | grep "Architecture" | sed -E "s/Architecture:\s+//")
l2=$(lscpu | grep L2 | awk '{print $3,$4}')
l3=$(lscpu | grep L3 | awk '{print $3,$4}')
mb=$(dmidecode -t baseboard 2> /dev/null | grep Product | awk -F ": " '{print $2}')
if [ ${#mb} -ne 0 ]
then
bios=$(dmidecode -t bios 2> /dev/null | grep Vendor | sed -E "s/.+Vendor: //")
ver=$(dmidecode -t bios 2> /dev/null | grep Version | sed -E "s/.+Version: //")
rel=$(dmidecode -t bios 2> /dev/null | grep Release | sed -E "s/.+Release Date: //" | sed "s/\//./g")
else
mb="Permission denied"
bios="Permission denied"
ver="Permission denied"
rel="Permission denied"
fi
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
swaprun=$(cat /proc/sys/vm/swappiness)
back_ratio=$(cat /proc/sys/vm/dirty_background_ratio)
ratio=$(cat /proc/sys/vm/dirty_ratio)
expire=$(cat /proc/sys/vm/dirty_expire_centisecs)
writeback=$(cat /proc/sys/vm/dirty_writeback_centisecs)
eth=$(lspci | grep -i ethernet | awk -F ": " '{print $NF}' | sed -n 1p)
video=$(lspci | grep -i vga | awk -F ": " '{print $NF}')
audio=$(lspci | grep -i audio | awk -F ": " '{print $NF}')
scsi=$(lspci | grep -i scsi | awk -F ": " '{print $NF}')
sata=$(lspci | grep -i sata | awk -F ": " '{print $NF}')
sd=$(ls -l /dev | grep sd | awk '{print $NF}')
sd=$(echo $sd | sed -E "s/\s/, /g")
lsblk=$(lsblk | grep -w "^sd." | awk '{print $1" ("$4"),"}')
lsblk=$(echo $lsblk | sed -r "s/,$//")
diskmodel=$(lsblk -o NAME,MODEL,SIZE,STATE --nodeps | grep -Ew "running" | awk '{print $0","}' | sed -E "s/ running//")
diskmodel=$(echo $diskmodel | sed -r "s/,$//")
df=$(df -h | sed 1d | grep -vE "udev|tmpfs|loop|docker" | awk '{print $1" ("$4"/"$2"),"}')
df=$(echo $df | sed -r "s/,$//")
fstab=$(cat /etc/fstab | sed "/^#\|^$/d" | wc -l)
if [ $(vgs 2> /dev/null | wc -l) -ne 0 ]
then
vgs=$(vgs 2> /dev/null | sed "1d; s/<//" | awk '{print $1" pdisk:"$2" lgroup:"$3" ("$7"/"$6"),"}')
vgs=$(echo $vgs | sed -r "s/,$//")
pvs=$(pvs 2> /dev/null | sed "1d; s/<//" | awk '{print $1" -> "$2" ("$6"/"$5"),"}')
pvs=$(echo $pvs | sed -r "s/,$//")
lvs=$(lvs 2> /dev/null | sed "1d; s/<//" | awk '{print $1" -> "$2" ("$4"),"}')
lvs=$(echo $lvs | sed -r "s/,$//")
else
vgs="Permission denied"
pvs="Permission denied"
lvs="Permission denied"
fi
md_name=$(cat /proc/mdstat | sed -n 2p | awk '{print $1}')
if [ $md_name != "unused" ]
then
mdadm=$(mdadm -D /dev/$md_name 2> /dev/null)
md_info=$md_name
mdadm_check=$(mdadm -D /dev/$md_name 2> /dev/null | wc -l)
else
md_info=$(echo "No arrays")
mdadm_check="1"
fi
if [ $mdadm_check -gt "1" ]
then
md_level=$(printf "%s\n" "${mdadm[@]}" | grep -Ei "level :" | awk -F ": " '{print $2}')
md_status=$(printf "%s\n" "${mdadm[@]}" | grep -Ei "state :" | awk -F ": " '{print $2}')
md_info=$(echo "$md_name $md_level/$md_status")
md_active=$(printf "%s\n" "${mdadm[@]}" | grep "Active Devices" | awk -F ": " '{print $2}')
md_work=$(printf "%s\n" "${mdadm[@]}" | grep "Working Devices" | awk -F ": " '{print $2}')
md_fail=$(printf "%s\n" "${mdadm[@]}" | grep "Failed Devices" | awk -F ": " '{print $2}')
md_spare=$(printf "%s\n" "${mdadm[@]}" | grep "Spare Devices" | awk -F ": " '{print $2}')
md_state=$(echo "$md_active/$md_work/$md_fail/$md_spare")
elif [ $mdadm_check -le "1" ] && [ $md_name != "unused" ]
then
md_state="Permission denied"
fi
int=($(ls /sys/class/net | sed "s/lo//" | grep -Evi "veth|br-"))
interface=$(echo ${int[@]} | sed "s/ /, /g")
net_driver=()
for i in ${int[@]}
do
driver=$(ethtool -i $i 2> /dev/null | grep driver | sed "s/driver: //")
speed=$(ethtool $i 2> /dev/null | grep -i speed | sed -E "s/.+: //")
net_driver+=($(echo "$i ($driver/$speed),"))
done
net_driver=$(echo ${net_driver[@]} | sed "s/,$//")
resolv_conf=$(cat /etc/resolv.conf | grep -E "^nameserver" | sed "s/nameserver //")
resolv_conf=$(echo $resolv_conf | sed "s/ /, /g")
resolv_link=$(ls -la /etc/resolv.conf | awk '{print $NF}' | sed "s/^..//")
resolve=$(systemd-resolve --status 2> /dev/null | grep "Current DNS" | sed -n 1p | awk -F ": " '{print $2}')
if [ ${#resolve} -eq 0 ]
then
dns_current=$(resolvectl status | grep "Current DNS" | awk -F ": " '{print $2}')
else
dns_current=$resolve
fi
dnslist=$(networkctl status | grep -A 5 "DNS:" | grep -oE "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")
dnslist=$(echo $dnslist | sed "s/ /, /g")
hosts_file=$(cat /etc/hosts | grep -E [0-9]+\.[0-9]+\.[0-9]+\.[0-9] | wc -l)
#ipv6=$(sysctl net.ipv6.conf.all.disable_ipv6 | awk -F "= " '{print $2}')
ipv6=$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6)
ipv6=$(if (( $(echo "$ipv6 == 1" | bc) )); then echo "true"; else echo "false"; fi)
#route_ip_forward=$(sysctl net.ipv4.ip_forward | awk -F "= " '{print $2}'')
route_ip_forward=$(cat /proc/sys/net/ipv4/ip_forward)
route_ip_forward=$(if (( $(echo "$route_ip_forward == 1" | bc) )); then echo "true"; else echo "false"; fi)
#icmp_ignore_bc=$(sysctl net.ipv4.icmp_echo_ignore_broadcasts | awk -F "= " '{print $2}')
icmp_ignore_bc=$(cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts)
icmp_ignore_bc=$(if (( $(echo "$icmp_ignore_bc == 1" | bc) )); then echo "true"; else echo "false"; fi)
#icmp_ignore_all=$(sysctl net.ipv4.icmp_echo_ignore_all | awk -F "= " '{print $2}')
icmp_ignore_all=$(cat /proc/sys/net/ipv4/icmp_echo_ignore_all)
icmp_ignore_all=$(if (( $(echo "$icmp_ignore_all == 1" | bc) )); then echo "true"; else echo "false"; fi)
#icmp_accept=$(sysctl net.ipv4.conf.all.accept_redirects | awk -F "= " '{print $2}')
icmp_accept=$(cat /proc/sys/net/ipv4/conf/all/accept_redirects)
icmp_accept=$(if (( $(echo "$icmp_accept == 1" | bc) )); then echo "true"; else echo "false"; fi)
#icmp_send=$(sysctl net.ipv4.conf.all.send_redirects | awk -F "= " '{print $2}')
icmp_send=$(cat /proc/sys/net/ipv4/conf/all/send_redirects)
icmp_send=$(if (( $(echo "$icmp_send == 1" | bc) )); then echo "true"; else echo "false"; fi)
#tcp_syncookies=$(sysctl net.ipv4.tcp_syncookies | awk -F "= " '{print $2}')
tcp_syncookies=$(cat /proc/sys/net/ipv4/tcp_syncookies)
tcp_syncookies=$(if (( $(echo "$tcp_syncookies == 1" | bc) )); then echo "true"; else echo "false"; fi)
#tcp_fastopen=$(sysctl net.ipv4.tcp_fastopen | awk -F "= " '{print $2}')
tcp_fastopen=$(cat /proc/sys/net/ipv4/tcp_fastopen)
#tcp_max_syn_backlog=$(sysctl net.ipv4.tcp_max_syn_backlog 2> /dev/null | awk -F "= " '{print $2}')
tcp_max_syn_backlog=$(cat /proc/sys/net/ipv4/tcp_max_syn_backlog)
#somaxconn=$(sysctl net.core.somaxconn 2> /dev/null | awk -F "= " '{print $2}')
somaxconn=$(cat /proc/sys/net/core/somaxconn)
#tcp_syn_retries=$(sysctl net.ipv4.tcp_syn_retries | awk -F "= " '{print $2}')
tcp_syn_retries=$(cat /proc/sys/net/ipv4/tcp_syn_retries)
#tcp_synack_retries=$(sysctl net.ipv4.tcp_synack_retries | awk -F "= " '{print $2}')
tcp_synack_retries=$(cat /proc/sys/net/ipv4/tcp_synack_retries)
#tcp_keepalive=$(sysctl -a 2> /dev/null | grep net.ipv4.tcp_keepalive | grep -Po "(?<=\=\s)[0-9]+")
tcp_keepalive=$(cat /proc/sys/net/ipv4/tcp_keepalive*)
keep_print=$(echo $tcp_keepalive | awk '{print $3"+("$1"*"$2")"}')
keep_sum=$(echo $tcp_keepalive | awk '{print $3+($1*$2)}')
#tcp_max_orphans=$(sysctl net.ipv4.tcp_max_orphans | awk -F "= " '{print $2}')
tcp_max_orphans=$(cat /proc/sys/net/ipv4/tcp_max_orphans)
#tcp_orphan_retries=$(sysctl net.ipv4.tcp_orphan_retries | awk -F "= " '{print $2}')
tcp_orphan_retries=$(cat /proc/sys/net/ipv4/tcp_orphan_retries)
#tcp_fin_timeout=$(sysctl net.ipv4.tcp_fin_timeout | awk -F "= " '{print $2}')
tcp_fin_timeout=$(cat /proc/sys/net/ipv4/tcp_fin_timeout)
#tcp_no_metrics_save=$(sysctl net.ipv4.tcp_no_metrics_save | awk -F "= " '{print $2}')
tcp_no_metrics_save=$(cat /proc/sys/net/ipv4/tcp_no_metrics_save)
tcp_no_metrics_save=$(if (( $(echo "$tcp_no_metrics_save == 0" | bc) )); then echo "true"; else echo "false"; fi) # conversely
#tcp_mem=$(sysctl net.ipv4.tcp_mem | awk '{print $3"/"$4"/"$5}')
tcp_mem=$(cat /proc/sys/net/ipv4/tcp_mem | awk '{print $1"/"$2"/"$3}')
#rmem_min=$(sysctl net.ipv4.tcp_rmem | awk '{print $3}')
#wmem_min=$(sysctl net.ipv4.tcp_wmem | awk '{print $3}')
rmem_min=$(cat /proc/sys/net/ipv4/tcp_rmem | awk '{print $1}')
wmem_min=$(cat /proc/sys/net/ipv4/tcp_wmem | awk '{print $1}')
#rmem_default=$(sysctl net.ipv4.rmem_default | awk -F "= " '{print $2}') # tcp_rmem higher priority
#wmem_default=$(sysctl net.ipv4.wmem_default | awk -F "= " '{print $2}') # tcp_wmem higher priority
#rmem_default=$(sysctl net.ipv4.tcp_rmem | awk '{print $4}')
#wmem_default=$(sysctl net.ipv4.tcp_wmem | awk '{print $4}')
rmem_default=$(cat /proc/sys/net/ipv4/tcp_rmem | awk '{print $2}')
wmem_default=$(cat /proc/sys/net/ipv4/tcp_wmem | awk '{print $2}')
#rmem_max=$(sysctl net.core.tcp_rmem 2> /dev/null | awk '{print $5}') # core.rmem_max higher priority
#wmem_max=$(sysctl net.core.tcp_wmem 2> /dev/null | awk '{print $5}') # core.wmem_max higher priority
#rmem_max=$(sysctl net.core.rmem_max 2> /dev/null | awk -F "= " '{print $2}')
#wmem_max=$(sysctl net.core.wmem_max 2> /dev/null | awk -F "= " '{print $2}')
rmem_max=$(cat /proc/sys/net/core/rmem_max)
wmem_max=$(cat /proc/sys/net/core/wmem_max)
#tcp_max_tw_buckets=$(sysctl net.ipv4.tcp_max_tw_buckets |  awk -F "= " '{print $2}')
tcp_max_tw_buckets=$(cat /proc/sys/net/ipv4/tcp_max_tw_buckets)
#port_range=$(sysctl net.ipv4.ip_local_port_range | awk '{print $3"-"$4}')
port_range=$(cat /proc/sys/net/ipv4/ip_local_port_range | awk '{print $1"-"$2}')
#netdev_max_backlog=$(sysctl net.core.netdev_max_backlog 2> /dev/null | awk -F "= " '{print $2}')
netdev_max_backlog=$(cat /proc/sys/net/core/netdev_max_backlog)
#rp_filter=$(sysctl net.ipv4.conf.all.rp_filter | awk -F "= " '{print $2}')
rp_filter=$(cat /proc/sys/net/ipv4/conf/all/rp_filter)
#aio=$(sysctl fs.aio-nr | awk -F "= " '{print $2}')
#aio_max=$(sysctl fs.aio-max-nr | awk -F "= " '{print $2}')
aio=$(cat /proc/sys/fs/aio-nr)
aio_max=$(cat /proc/sys/fs/aio-max-nr)
#use=$(sysctl fs.file-nr | awk '{print $3}')
use=$(cat /proc/sys/fs/file-nr | awk '{print $1}')
#descriptor=$(sysctl fs.file-max 2> /dev/null | awk -F "= " '{print $2}')
descriptor=$(cat /proc/sys/fs/file-max)
#proc_file=$(sysctl fs.nr_open | awk -F "= " '{print $2}')
proc_file=$(cat /proc/sys/fs/nr_open)
lsof=$(lsof 2> /dev/null | sed 1d)
lsof_reg=$(printf "%s\n" "${lsof[@]}" | grep REG | wc -l )
lsof_all=$(printf "%s\n" "${lsof[@]}" | wc -l)
#du=$(du -a / 2> /dev/null | wc -l) # slow
limits=$(cat /etc/security/limits.conf | grep -Ev "^$|^#" | wc -l)
ss=$(ss -tun | wc -l)
ports=$(ss -tun | sed 1d | awk '{print $5}' | awk -F ":" '{print $NF","}' | sort | uniq)
ports=$(echo $ports | sed -r "s/,$//")
ufw_status=$(ufw status 2> /dev/null | sed -n 1p | awk '{print $2}')
if [ ${#ufw_status} -eq 0 ]
then
ufw_status="Permission denied or no installed"
elif [ $ufw_status == "active" ]
then
ufw_allow=$(ufw status | grep -i allow | wc -l)
ufw_deny=$(ufw status | grep -i deny | wc -l)
ufw_state=$(echo $ufw_allow/$ufw_deny)
fi
fwd_status=$(firewall-cmd --state 2> /dev/null)
if [ ${#fwd_status} -eq 0 ]
then
fwd_status="Permission denied or no installed"
elif [ $fwd_status == "running" ]
then
fwd_ports=$(firewall-cmd --list-port | wc -w)
fwd_service=$(firewall-cmd --list-service | wc -w)
fwd_rules=$(echo $fwd_ports/$fwd_service)
fi
iptables=$(iptables -L 2> /dev/null | grep -E "tcp|udp" | wc -l)
hosts_allow=$(cat /etc/hosts.allow | grep -Pv "^$|^#" | wc -l)
hosts_deny=$(cat /etc/hosts.deny | grep -Pv "^$|^#" | wc -l)
units=$(systemctl list-unit-files)
#unit_startup=$(systemctl list-unit-files --state=enabled | grep -Po "[0-9]+(?= unit files listed)") # slow
unit_startup=$(printf "%s\n" "${units[@]}" | grep -E "enabled\s.+" | wc -l)
unit_all=$(printf "%s\n" "${units[@]}" | grep -Po "[0-9]+(?= unit files listed)")
cron_current=$(crontab -l 2> /dev/null | sed "/^#\|^$/d" | wc -l)
users=($(cat /etc/passwd | awk -F ":" '{print $1}'))
cron_all=0
for u in ${users[@]}
do
cron_all=$(( $count + $(crontab -l -u $u 2> /dev/null | sed "/^#\|^$/d" | wc -l) ))
done
apt_list=$(apt list --installed 2> /dev/null | sed 1d | wc -l)
showauto=$(apt-mark showauto | wc -l)
showmanual=$(apt-mark showmanual | wc -l)
last_update=$(ls -l /var/cache/apt/pkgcache.bin | awk '{print $7,$6,$8}')
list_update=$(apt list --upgradable 2> /dev/null | sed 1d |  wc -l)
dpkg=$(dpkg -l | wc -l)
snap=$(snap list | sed 1d | wc -l)
user=$(cat /etc/passwd | wc -l)
group=$(cat /etc/group | wc -l )
user_passwd=($(cat /etc/shadow 2> /dev/null | grep -Ev "^.+\:\*:|^.+\:\!+" | awk -F: '{print $1}'))
if [ ${#user_passwd} -eq 0 ]
then
user_passwd="Permission denied"
else
user_passwd=$(echo ${user_passwd[@]} | sed "s/ /, /g")
fi
home=($(ls /home))
home=$(echo ${home[@]} | sed "s/ /, /g")
sudo_path=$(cat /etc/sudoers 2> /dev/null | grep -Po "(?<=includedir ).+")
if [ ${#sudo_path} -eq 0 ]
then
sudo_count="Permission denied"
else
sudo_conf_count=$(cat /etc/sudoers 2> /dev/null | grep -Ev "^#|^$|^Defaults" | wc -l)
sudo_files_count=$(cat $sudo_path/* 2> /dev/null | grep -Ev "^#|^$|^Defaults" | wc -l)
sudo_count=$(( $sudo_conf_count + $sudo_files_count ))
fi
login_min_days=$(cat /etc/login.defs | awk '/^PASS_MIN_DAYS/ {print $2}')
login_max_days=$(cat /etc/login.defs | awk '/^PASS_MAX_DAYS/ {print $2}')
#login_min_len=$(cat /etc/login.defs | awk '/PASS_MIN_LEN/ {print $2}')
#login_max_len=$(cat /etc/login.defs | awk '/PASS_MAX_LEN/ {print $2}')
ssh_port=$(cat /etc/ssh/sshd_config | awk '/Port / {print $2}')
ssh_pass=$(cat /etc/ssh/sshd_config | awk '/PasswordAuthentication / {print $2}')
ssh_root=$(cat /etc/ssh/sshd_config | grep -E "PermitRootLogin " -m 1 | awk '{print $2}')
bash=$(bash --version | sed -n 1p | sed -E "s/.+version //; s/\(.+//")
python=$(python3 --version 2> /dev/null || python2 --version 2> /dev/null)
python=$(echo $python | sed "s/Python //")
ansible=$(ansible --version 2> /dev/null | sed -n 1p | sed "s/ansible //")
if [ ${#ansible} -eq 0 ]
then
ansible="No installed"
fi
docker_version=$(docker --version 2> /dev/null | sed -r "s/Docker version //; s/,.+//")
if [ ${#docker_version} -ne 0 ]
then
docker_root_check=$(docker volume ls 2> /dev/null | wc -l)
else
docker_v="No installed"
fi
if [ $docker_root_check -ne 0 ]
then
docker_compose_version=$(docker-compose --version 2> /dev/null | sed -r "s/.+ version v//")
docker_volume=$(docker volume ls | sed 1d | wc -l)
docker_images=$(docker images | sed 1d | awk '{print $1}')
docker_images=$(echo ${docker_images[@]} | sed "s/ /, /g")
docker_images_count=$(echo $docker_images | wc -w)
docker_ps=$(docker ps | sed 1d | awk '{print $NF}')
docker_ps=$(echo ${docker_ps[@]} | sed "s/ /, /g")
docker_ps_count=$(echo $docker_ps | wc -w)
docker_ps_all=$(docker ps -a | sed 1d | wc -l)
docker_v=$(echo "$docker_version/$docker_compose_version")
docker_i=$(echo "$docker_volume/$docker_images_count") # ($docker_images)
docker_p=$(echo "$docker_ps_count/$docker_ps_all") # ($docker_ps)
#docker_host_port=$(docker inspect $(docker ps -q) --format='{{.NetworkSettings.Ports}}' | grep -Po "[0-9]+(?=}])")
docker_host_port=$(
for ps in $(docker ps -q)
do
docker port $ps | sed -n 2p | awk -F ":" '{print $NF}'
done
)
docker_host_port=$(echo ${docker_host_port[@]} | sed "s/ /, /g")
else
docker_host_port="Permission denied"
docker_v="Permission denied"
docker_i="Permission denied"
docker_p="Permission denied"
fi
zabbix_service=$(systemctl status zabbix-agent 2> /dev/null)
zabbix_status=$(printf "%s\n" "${zabbix_service[@]}" | grep Active | awk -F ": " '{print $2}')
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
echo "Hostname                   : $hn"
echo "Uptime                     : $uptime"
echo "Startup                    : $startup"
#echo "GRUB boot parameters      : $grub_boot_param"
echo "Local Time                 : $time"
echo "Time Zone                  : $tz"
echo "NTP service/synchronized   : $ntp_sync/$ntp_service"
echo "NTP systemd service status : $ntp_status"
echo "NTP systemd server sync    : $ntp_server"
echo "NTPD status                : $ntpd_status"
echo "NTPD conf server/pool      : $ntpd_sp"
echo "NTPD current server sync   : $ntpd_current_server"
echo "Syslog service             : $syslog_status"
#echo "Syslog local server       : $syslog_local_server"
echo "Syslog remote server       : $syslog_remote_server"
echo "Syslog today/all error     : $syslog_error_today/$syslog_error_all"
echo "Journal today/all error    : $journalctl_today/$journalctl_all"
echo "OS                         : $os"
echo "Kernel                     : $kernel"
echo "Systemd version            : $systemd_ver"
echo "Hypervisor                 : $vm"
echo "CPU                        : $cpu"
echo "Core                       : $core"
echo "Architecture               : $arch"
echo "L2                         : $l2"
echo "L3                         : $l3"
echo "Motherboard                : $mb"
echo "BIOS                       : $bios"
echo "BIOS Version               : $ver"
echo "BIOS Release               : $rel"
echo "Process Started count      : $ps"
echo "Running/All Process        : $run"
echo "CPU avg 1/5/15 min         : $avg"
echo -e "CPU avg usr/sys/wa/idle    : $us_avg\t$sy_avg\t$wa_avg\t$id_avg"
echo -e "CPU cur usr/sys/wa/idle    : $us_cur\t$sy_cur\t$wa_cur\t$id_cur"
echo -e "IOps avg in/out            : $bi_avg\t$bo_avg"
echo -e "IOps current in/out        : $bi_cur\t$bo_cur"
echo "MEM use/all/cache          : $mem_use/$mem_all/$mem_cache MB"
echo "MEM cache/buffer/dirty     : $cache/$buf/$dirty KB"
echo "SWAP use/all               : $swap_use/$swap_all MB"
echo "SWAP Mount                 : $mount"
echo "SWAP Running free mem      : $swaprun %"
echo "Cache background/ratio     : $back_ratio/$ratio %"
echo "Cache expire/writeback     : $expire/$writeback hundredths sec"
echo "Ethernet Adapter           : $eth"
echo "VGA controller             : $video"
echo "Audio controller           : $audio"
echo "SCSI controller            : $scsi"
echo "SATA controller            : $sata"
echo "All Disk and Volume        : $sd"
echo "Disk size                  : $lsblk"
echo "Disk Running Model         : $diskmodel"
echo "Mount Filesystem free/all  : $df"
echo "Mount fstab count          : $fstab"
echo "LVM Volume Group           : $vgs"
echo "LVM Physical Volume        : $pvs"
echo "LVM Logical Volume         : $lvs"
echo "MD RAID Level/Status       : $md_info"
echo "MD Active/Work/Fail/Spare  : $md_state"
echo "Network Interfaces         : $interface"
echo "Network Driver/Speed       : $net_driver"
echo "DNS Resolv configutation   : $resolv_conf"
echo "DNS Resolv conf link       : $resolv_link"
echo "DNS Server systemd current : $dns_current"
echo "DNS Server systemd list    : $dnslist"
echo "Hosts file count addreses  : $hosts_file"
echo "IPv6 disable               : $ipv6"
echo "Route ip forward           : $route_ip_forward"
echo "ICMP ignore broadcast/all  : $icmp_ignore_bc/$icmp_ignore_all"
echo "ICMP accept/send redirect  : $icmp_accept/$icmp_send"
echo "TCP SYN use cookies        : $tcp_syncookies"
echo "TCP fastopen data connect  : $tcp_fastopen"
echo "TCP SYN max backlog        : $tcp_max_syn_backlog"
echo "TCP SYN-ACK max backlog    : $somaxconn"
echo "TCP SYN/SYN-ACK retries    : $tcp_syn_retries/$tcp_synack_retries"
echo "TCP Keepalive Time Live    : $keep_print=$keep_sum sec"
echo "TCP orphan max socket      : $tcp_max_orphans"
echo "TCP orphan retries count   : $tcp_orphan_retries"
echo "TCP FIN timeout socket     : $tcp_fin_timeout sec"
echo "TCP metrics save           : $tcp_no_metrics_save"
echo "TCP mem min/load/max page  : $tcp_mem"
echo "Socket in/out buffer min   : $rmem_min/$wmem_min byte"
echo "Socket in/out default      : $rmem_default/$wmem_default byte"
echo "Socket in/out buffer max   : $rmem_max/$wmem_max byte"
echo "Socket TIME-WAIT max       : $tcp_max_tw_buckets"
echo "Socket local port range    : $port_range"
echo "Net Kernel max backlog     : $netdev_max_backlog"
echo "Net reverse path filter    : $rp_filter"
echo "Async IO request curr/max  : $aio/$aio_max"
echo "Descriptor Files use/max   : $use/$descriptor"
echo "Descriptor max for process : $proc_file"
echo "List Open Files/All count  : $lsof_reg/$lsof_all"
#echo "All dir and files count   : $du"
echo "Limits count               : $limits"
echo "Socket ESTAB count         : $ss"
echo "Socket LISTEN unique port  : $ports"
echo "UFW Status                 : $ufw_status"
echo "UFW Rule allow/deny count  : $ufw_state"
echo "FWD Status                 : $fwd_status"
echo "FWD Rule ports/services    : $fwd_rules"
echo "Iptables rule count        : $iptables"
echo "Hosts allow/deny services  : $hosts_allow/$hosts_deny"  
echo "Unit Startup/All count     : $unit_startup/$unit_all"
echo "Cron tasks curr/all users  : $cron_current/$cron_all"
echo "APT show auto/manual       : $apt_list ($showauto/$showmanual)"
echo "APT Last Update            : $last_update"
echo "APT List Upgrade count     : $list_update"
echo "DPKG Packet count          : $dpkg"
echo "SNAP Packet count          : $snap"
echo "User/Group count           : $user/$group"
echo "User using password        : $user_passwd "
echo "User directories           : $home"
echo "Sudo all conf user count   : $sudo_count"
echo "Login pass min/max days    : $login_min_days/$login_max_days"
echo "ssh port/login pass/root   : $ssh_port/$ssh_pass/$ssh_root"
echo "Bash version               : $bash"
echo "Python version             : $python"
echo "Ansible version            : $ansible"
echo "Docker/Compose version     : $docker_v"
echo "Docker Volumes/Images      : $docker_i"
echo "Docker Running/All         : $docker_p"
echo "Docker LISTEN host ports   : $docker_host_port"
echo "Zabbix Agent status        : $zabbix_status"
echo "Zabbix Agent version       : $zabbix_ver"
echo "Zabbix config              : $zabbix_conf"
echo "Zabbix server              : $zabbix_server"
echo
}

hwstat