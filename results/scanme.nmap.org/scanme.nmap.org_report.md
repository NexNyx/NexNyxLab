# Quick-Scan Report — scanme.nmap.org

_Generated: 2025-10-22 17:50:58_


## Management Summary

- Quick wins: directory indexing, missing X-Frame-Options, open SSH.


## HTTP Headers

```text
HTTP/1.1 200 OK
Date: Tue, 21 Oct 2025 13:11:40 GMT
Server: Apache/2.4.7 (Ubuntu)
Accept-Ranges: bytes
Vary: Accept-Encoding
Content-Type: text/html


```


## Nmap Results

```text
# Nmap 7.80 scan initiated Tue Oct 21 14:11:40 2025 as: nmap -sT -p80,443,22 -sV -oN /home/silvano/NexNyxLab/results/scanme.nmap.org/nmap.txt scanme.nmap.org
Nmap scan report for scanme.nmap.org (45.33.32.156)
Host is up (0.22s latency).
Other addresses for scanme.nmap.org (not scanned): 2600:3c01::f03c:91ff:fe18:bb2f

PORT    STATE  SERVICE VERSION
22/tcp  open   ssh     OpenSSH 6.6.1p1 Ubuntu 2ubuntu2.13 (Ubuntu Linux; protocol 2.0)
80/tcp  open   http    Apache httpd 2.4.7 ((Ubuntu))
443/tcp closed https
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Tue Oct 21 14:11:49 2025 -- 1 IP address (1 host up) scanned in 9.40 seconds

```


## Nikto Findings (excerpt)

```text
- Nikto v2.1.5/2.1.5
+ Target Host: scanme.nmap.org
+ Target Port: 80
+ GET /: The anti-clickjacking X-Frame-Options header is not present.
+ OPTIONS /: Allowed HTTP Methods: GET, HEAD, POST, OPTIONS 
+ -3268: GET /images/: /images/: Directory indexing found.
+ -3268: GET /images/?pattern=/etc/*&sort=name: /images/?pattern=/etc/*&sort=name: Directory indexing found.
+ GET /icons/README: Server leaks inodes via ETags, header found with file /icons/README, fields: 0x13f4 0x438c034968a80 
+ -3233: GET /icons/README: /icons/README: Apache default file found.
- Nikto v2.1.5/2.1.5
+ Target Host: scanme.nmap.org
+ Target Port: 80
+ GET /: The anti-clickjacking X-Frame-Options header is not present.
+ OPTIONS /: Allowed HTTP Methods: GET, HEAD, POST, OPTIONS 
+ -3268: GET /images/: /images/: Directory indexing found.
+ -3268: GET /images/?pattern=/etc/*&sort=name: /images/?pattern=/etc/*&sort=name: Directory indexing found.
+ GET /icons/README: Server leaks inodes via ETags, header found with file /icons/README, fields: 0x13f4 0x438c034968a80 
+ -3233: GET /icons/README: /icons/README: Apache default file found.

```


## Recommendations (high-level)

1. Disable directory indexing (Apache: Options -Indexes).

2. Add security headers (X-Frame-Options, CSP, HSTS).

3. Implement HTTPS and redirect HTTP->HTTPS.

4. Harden SSH: key-based auth, disable root/password login.
