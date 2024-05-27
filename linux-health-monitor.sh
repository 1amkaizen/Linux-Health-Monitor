#!/bin/bash

# Fungsi untuk mencetak teks berwarna
print_color() {
    printf "\e[1;32m$1\e[0m\n"
}

# Fungsi untuk mencetak teks berwarna kuning
print_color_yellow() {
    printf "\e[1;33m$1\e[0m\n"
}

# Fungsi untuk mencetak teks berwarna merah
print_color_red() {
    printf "\e[1;31m$1\e[0m\n"
}

# Fungsi untuk mencetak diagram batang berwarna dengan persentase
print_bar_chart() {
    local label=$1
    local used=$2
    local total=$3
    local unit=$4
    local color=$5
    local width=50
    local percent=$(echo "scale=2; $used / $total * 100" | bc)
    local filled=$(printf "%.0f" $(echo "scale=2; $percent / 100 * $width" | bc))
    local unfilled=$((width - filled))
    local bar=$(printf "\e[1;${color}m%s\e[0m" $(printf '■%.0s' $(seq 1 $filled)))
    local space=$(printf ' %.0s' $(seq 1 $unfilled))
    printf "%-15s [%s%s] %.1f%% (%s %s / %s %s)\n" "$label" "$bar" "$space" "$percent" "$used" "$unit" "$total" "$unit"
}

# Fungsi untuk mencetak diagram batang untuk suhu
print_temp_bar_chart() {
    local temp=$1
    local color=$2
    local width=50
    local max_temp=85  # Misalkan suhu maksimum yang aman adalah 85 derajat Celsius
    local percent=$(echo "scale=2; $temp / $max_temp * 100" | bc)
    local filled=$(printf "%.0f" $(echo "scale=2; $percent / 100 * $width" | bc))
    local unfilled=$((width - filled))
    local bar=$(printf "\e[1;${color}m%s\e[0m" $(printf '■%.0s' $(seq 1 $filled)))
    local space=$(printf ' %.0s' $(seq 1 $unfilled))
    printf "%-15s [%s%s] %.1f%% (%s°C)\n" "Temperature" "$bar" "$space" "$percent" "$temp"
}

# Memantau suhu CPU
print_color "=== Monitor Sistem ==="
print_color "Suhu CPU:"
if command -v vcgencmd &> /dev/null; then
    cpu_temp=$(vcgencmd measure_temp | sed "s/temp=//" | sed "s/'C//")
else
    cpu_temp=$(sensors | grep -i 'cpu temp' | awk '{print $3}' | sed 's/+//; s/°C//')
fi
print_temp_bar_chart $cpu_temp 31

# Informasi tentang CPU
print_color "Informasi CPU:"
cpu_info=$(cat /proc/cpuinfo | grep -E 'model name|processor|cpu MHz')
echo "$cpu_info"

# Penggunaan CPU dan informasi tentang threads dan core
print_color "Penggunaan CPU dan Informasi Threads/Core:"
cpu_idle=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/")
cpu_usage=$(echo "scale=2; 100 - $cpu_idle" | bc)
print_bar_chart "CPU Usage" $cpu_usage 100 "" 32

# Memantau penggunaan memori
print_color "Penggunaan Memori:"
mem_info=$(free -m | awk 'NR==2{print $3, $4, $2}')
mem_used=$(echo $mem_info | awk '{print $1}')
mem_free=$(echo $mem_info | awk '{print $2}')
mem_total=$(echo $mem_info | awk '{print $3}')
print_bar_chart "Memory Used" $mem_used $mem_total "MB" 34
print_bar_chart "Memory Free" $mem_free $mem_total "MB" 32

# Memantau ruang disk
print_color "Penggunaan Disk:"
disk_info=$(df -m / | awk 'NR==2')
disk_total=$(echo $disk_info | awk '{print $2}')
disk_used=$(echo $disk_info | awk '{print $3}')
disk_free=$((disk_total - disk_used))
print_bar_chart "Disk Used" $disk_used $disk_total "MB" 36
print_bar_chart "Disk Free" $disk_free $disk_total "MB" 32

# Informasi penggunaan disk dan threads/core
print_color "Informasi Disk dan Threads/Core:"
df -h | grep '^/dev/' | awk '{printf "Filesystem: %-20s Size: %-8s Used: %-8s Avail: %-8s Use%%: %-6s Mounted on: %s\n", $1, $2, $3, $4, $5, $6}'
threads=$(lscpu | grep "Thread(s) per core" | awk '{print $4}')
cores=$(lscpu | grep "Core(s) per socket" | awk '{print $4}')
sockets=$(lscpu | grep "Socket(s):" | awk '{print $2}')
echo "Threads per Core: $threads"
echo "Cores per Socket: $cores"
echo "Sockets: $sockets"

# Informasi tentang jaringan Wi-Fi
print_color "Informasi Jaringan Wi-Fi:"
wifi_ssid=$(iwgetid -r)
if [ -z "$wifi_ssid" ]; then
    echo "Tidak terhubung ke jaringan Wi-Fi."
else
    echo "SSID: $wifi_ssid"
fi

# Memantau proses yang menggunakan sumber daya secara intensif
print_color_red "Proses yang Menggunakan Sumber Daya Secara Intensif:"
ps -eo pid,user,pcpu,pmem,cmd --sort=-pcpu,-pmem | head -n 6 | awk '{printf "PID: %-6s USER: %-8s CPU: %-5s%% MEM: %-5s%% CMD: %s\n", $1, $2, $3, $4, $5}'

# Informasi tambahan tentang sistem
print_color "Informasi Sistem Tambahan:"
hostname=$(hostname)
os_version=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2- | tr -d '"')
uptime_info=$(uptime -p)
print_color "Hostname: $hostname"
print_color "OS Version: $os_version"
print_color "Uptime: $uptime_info"

