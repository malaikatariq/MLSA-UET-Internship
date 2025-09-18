
# Week 1 — Operating Systems & Cybersecurity Fundamentals

**Course:** MLSA UET Peshawar – Seekho Aur Barho Internship

**Session:** Week 1

**Overview**
This README summarizes the Week 1 class and labs. It covers basic operating system types, virtualization sizing, hacker categories, core cybersecurity definitions (hacking vs ethical hacking), storage fundamentals (HDD / SSD / USB), client–server basics, the CIA triad, networking concepts (DNS, ports, packets, HTTP errors), cookies & cache, and simple hands-on tasks (Kali Linux install). Use this document as a quick reference and checklist for the week’s learning outcomes.

---

## Learning objectives

By the end of Week 1 you should be able to:

* Differentiate between Windows, UNIX-based, and Linux-based operating systems (examples: Kali, Ubuntu, Parrot).
* Choose reasonable CPU clock and VM sizing for small lab VMs (e.g., 2–2.5 GHz for 1–2 VMs depending on cores/RAM).
* Explain types of hackers and legal/ethical boundaries.
* Define hacking, ethical hacking, and responsible testing practices.
* Describe how data is stored on HDDs and SSDs and the basics of data recovery.
* Explain client vs server architecture, packets, DNS, ports, and basic HTTP responses (e.g., 400 range errors).
* Understand the CIA triad and basic Wi‑Fi frequency concepts.
* Perform a basic Kali Linux installation and start simple hands-on labs.

---

## Table of contents

1. Operating Systems
2. VM sizing (CPU / clock speed)
3. Types of hackers
4. Hacking vs Ethical Hacking
5. Storage fundamentals (HDD, SSD, USB)
6. Client vs Server
7. CIA triad
8. Wi‑Fi frequencies and routers
9. Threat vs Vulnerability, Exploit, Bug
10. Client–Server architecture & three‑way handshake
11. Networking basics: packets, DNS, ports, HTTP errors
12. Cache & Cookies
13. Lab task: Install Kali Linux
14. Practical exercises & checklist
15. References & further reading

---

## 1) Operating Systems (OS)

* **Windows OS**: A widely used commercial OS family with strong desktop support and many proprietary drivers and tools.
* **UNIX‑based OS**: The original family of operating systems following the UNIX philosophy. Many modern OSes are UNIX‑like.
* **Linux‑based OS**: Open source kernels with many distributions (distros). Examples:

  * **Kali Linux** — penetration testing and security tools preinstalled.
  * **Ubuntu** — user‑friendly distro for desktop and servers.
  * **Parrot OS** — privacy and security focused distro.

**Tip:** For security labs, Kali or Parrot are common. For general development and daily use, Ubuntu is beginner-friendly.

---

## 2) VM sizing: clock speed & resources

* **Clock speed** (GHz): 2.0–2.5 GHz is a reasonable single‑core frequency for running 1–2 light VMs in a lab, but real performance depends on the number of CPU cores, hypervisor overhead, and available RAM.
* **Recommendation:** For 1–2 VMs: allocate at least 2 CPU cores and 4–6 GB RAM per VM for Kali/Ubuntu in a typical laptop environment. Increase resources for heavier workloads.

---

## 3) Types of hackers

* **Black Hat**: Malicious actors who break into systems without permission.
* **White Hat**: Ethical security professionals who test with permission (penetration testers, red teamers) and follow the law.
* **Gray Hat**: Actors whose actions fall between legal and illegal depending on context (may violate rules but not acting purely maliciously).

---

## 4) What is hacking vs ethical hacking

* **Hacking (in this context):** Unauthorized access to an internet‑enabled device or system. Illegal when done without consent.
* **Ethical Hacking:** Security testing performed **with explicit permission** to find and fix vulnerabilities. This is legal and done according to rules of engagement.

---

## 5) Storage fundamentals: HDD, SSD, USB

* **HDD (Hard Disk Drive):** Uses magnetic platter(s). Data is stored in *sectors* as magnetic patterns. When you delete files, the file system marks sectors as free; the underlying magnetic data can remain until overwritten — making recovery often possible.

  * Key terms: sectors, blocks, magnetic patterns.
* **SSD (Solid State Drive):** Uses flash memory (NAND). Storage units often expressed in **GiB** (Gibibytes) or GB. SSDs use wear‑leveling and TRIM which can make recovery more difficult after data overwrite or TRIM invocation.
* **USB pendrive:** When files are deleted, the file system behavior depends on the device type (FAT32/NTFS/exFAT) and whether new data overwrote old sectors. Deleted data can often be recovered unless overwritten or securely wiped.

**Is data always recoverable?** No. Recoverability depends on storage type, whether sectors were overwritten, and whether secure erase/TRIM has been performed. HDD recoverability is higher until data is overwritten; SSD recoverability is lower after TRIM/garbage collection.

---

## 6) Client vs Server

* **Client:** Any device or application that requests resources or services (e.g., your browser).
* **Server:** A device or service that fulfills client requests (e.g., web server, database server).

---

## 7) CIA: Confidentiality, Integrity, Availability

* **Confidentiality (C):** Keep sensitive data secret from unauthorized users.
* **Integrity (I):** Ensure data is accurate and unaltered. (A ↔ B: data remains consistent and correct.)
* **Availability (A):** Ensure authorized users can access data and services when needed.

This triad is the backbone of cybersecurity.

---

## 8) Wi‑Fi frequencies

* **2.4 GHz:** Longer range, better wall penetration, more interference (crowded).
* **5 GHz:** Higher throughput, shorter range, often less interference (good for faster local connections).

**Note:** The post mentioned frequencies reversed; remember 2.4 GHz is the longer‑range band while 5 GHz is higher speed with shorter range.

---

## 9) Threat vs Vulnerability, Exploit, Bug

* **Threat:** Any potential activity or actor that can cause harm (e.g., malware, attacker).
* **Vulnerability:** A weakness or flaw in a system that can be exploited.
* **Exploit:** Code or technique used to take advantage of a vulnerability to gain unauthorized access or control.
* **Bug:** A software defect; some bugs are vulnerabilities if they enable exploitation.

---

## 10) Client–Server architecture & three‑way handshake

* TCP three‑way handshake:

  1. **SYN** — client requests connection.
  2. **SYN‑ACK** — server acknowledges and agrees.
  3. **ACK** — client acknowledges server, connection established.

**Data transfer:** Clients send requests; data travels as **packets** (binary chunks) across the network.

---

## 11) Networking basics

* **Packets:** Small units of data routed between devices.
* **DNS (Domain Name System):** Converts human‑friendly domain names to IP addresses.
* **Ports:** Logical gates on a host (e.g., port 80 for HTTP, 443 for HTTPS).
* **HTTP status codes:** 400–499 range are client errors (e.g., 400 Bad Request). 500–599 are server errors.

---

## 12) Cache & Cookies

* **Cache:** Temporary storage that speeds up repeated requests (pages, resources).
* **Cookies:** Small pieces of data stored by browsers to maintain sessions, preferences, or track users. Stored on disk (e.g., in Windows: `C:\Users\<User>\AppData\...` for Chrome profiles).

  * **Magic cookie:** Historical term for an authentication/session token.
  * **HTTP cookie:** Modern browser cookies used for sessions and state.
  * **Persistent cookies:** Cookies with expiration dates (remain across sessions).

**Security note:** Cookies can be abused for tracking or session hijacking if not protected properly (use `HttpOnly`, `Secure`, and proper SameSite attributes).

---

## 13) Lab Task (Week 1): Install Kali Linux

**Goal:** Install Kali Linux in a VM and perform initial checks.

**Suggested steps (VirtualBox/VMware):**

1. Download Kali ISO from the official site.
2. Create new VM: OS type Linux, allocate 2 CPUs, 4–6 GB RAM (adjust to host capacity), 20+ GB disk.
3. Mount the ISO and install Kali.
4. Post‑install checks:

```bash
# check kernel and OS
uname -a
# check CPU info
lscpu
# check disk layout
lsblk
```

**Safety:** Perform all security exercises inside isolated VMs or lab networks. Never attack systems without explicit permission.

---

## 14) Practical exercises & checklist

* [ ] Identify your host CPU cores and clock speed (`lscpu`).
* [ ] Install Kali Linux in a VM and take a screenshot of the desktop.
* [ ] List files in browser profile path and locate cookies (for study only).
* [ ] Use `nmap` to scan your own lab VM (with permission) and observe open ports.
* [ ] Research TRIM and SSD secure erase behavior and write 3–4 bullet notes.

---

## 15) References & further reading

* Kali Linux official docs
* Linux `lscpu`, `lsblk`, `uname` man pages
* OWASP Top 10 (web vulnerabilities)
* Intro to Networking (TCP/IP model)

---

## Glossary (short)

* **VM:** Virtual Machine
* **TRIM:** SSD command to inform the drive which blocks are no longer in use
* **NAND:** Flash memory technology used in SSDs and USB drives
* **SYN / ACK:** TCP control flags used in handshake

---

**If you want:** I can convert this README into a shorter **LinkedIn summary**, generate `README.md` file content for your GitHub repo (ready to copy/paste), or create a Week‑by‑Week README series for the whole internship. Just tell me which format you prefer.
