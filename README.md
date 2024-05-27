# Linux-Health-Monitor
Alat untuk memantau kesehatan dan kinerja sistem linux.

### penggunaan:

```bash
git clone https://github.com/1amkaizen/Linux-Health-Monitor/
```

```bash
cd Linux-Health-Monitor
```

```bash
chmod +x linux-health-monitor
```

```bash
./linux-health-monitor
```

### output:

```bash
=== Monitor Sistem ===
Suhu CPU:
Temperature     [■■■■■■■■■■■■■■■■■■■■■■■■■■                        ] 53.0% (45.1°C)
Informasi CPU:
processor	: 0
model name	: ARMv7 Processor rev 4 (v7l)
processor	: 1
model name	: ARMv7 Processor rev 4 (v7l)
processor	: 2
model name	: ARMv7 Processor rev 4 (v7l)
processor	: 3
model name	: ARMv7 Processor rev 4 (v7l)
Penggunaan CPU dan Informasi Threads/Core:
CPU Usage       [■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■                    ] 61.0% (61.3  / 100 )
Penggunaan Memori:
Memory Used     [■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■                    ] 60.0% (552 MB / 920 MB)
Memory Free     [■■■■■■■■                                          ] 15.0% (146 MB / 920 MB)
Penggunaan Disk:
Disk Used       [■■■■■■■■■■■■■■■■■■■■■■                            ] 44.0% (13048 MB / 29122 MB)
Disk Free       [■■■■■■■■■■■■■■■■■■■■■■■■■■■■                      ] 55.0% (16074 MB / 29122 MB)
Informasi Disk dan Threads/Core:
Filesystem: /dev/mmcblk0p7       Size: 29G      Used: 13G      Avail: 15G      Use%: 48%    Mounted on: /
Filesystem: /dev/mmcblk0p6       Size: 509M     Used: 117M     Avail: 393M     Use%: 23%    Mounted on: /boot/firmware
Threads per Core: 1
Cores per Socket: 4
Sockets: 1
Informasi Jaringan Wi-Fi:
SSID: OPPO A57
Proses yang Menggunakan Sumber Daya Secara Intensif:
PID: PID    USER: USER     CPU: %CPU % MEM: %MEM % CMD: CMD
PID: 10852  USER: pi       CPU: 220  % MEM: 0.4  % CMD: ps
PID: 10728  USER: pi       CPU: 103  % MEM: 2.5  % CMD: shellcheck
PID: 9588   USER: pi       CPU: 25.3 % MEM: 17.4 % CMD: /usr/lib/chromium/chromium
PID: 10854  USER: pi       CPU: 25.0 % MEM: 0.2  % CMD: awk
PID: 9456   USER: pi       CPU: 8.7  % MEM: 11.8 % CMD: /usr/lib/chromium/chromium
Informasi Sistem Tambahan:
Hostname: raspberrypi
OS Version: Raspbian GNU/Linux 12 (bookworm)
Uptime: up 4 hours, 14 minutes

```
