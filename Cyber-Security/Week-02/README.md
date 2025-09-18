# Week 2 — Reconnaissance / Footprinting / Information-Gathering (Ethical & Defensive)

> **⚠️ Legal & Ethical Notice — Educational Use Only**
> The techniques described here are intended solely for **legal, ethical, and educational** purposes. Perform any scans, packet captures, or information-gathering **only** on systems you own or on targets for which you hold **explicit written authorization** (Rules of Engagement).
This README focuses on responsible, defensive learning and safe practice.


---

## Overview — What this week covers

This README summarizes core reconnaissance concepts and practical, **ethical** exercises for learning how to map targets and collect technical information:

* VM networking modes (bridge vs NAT)
* Network fundamentals: Internet → Router → Hops, default gateway, TTL (conceptual)
* Reconnaissance vs footprinting vs information gathering
* Tools & techniques (Whois, traceroute, Wappalyzer, BuiltWith, ARIN, tcpdump, nmap, Zenmap) — defensive usage only
* Port concepts and common ports (well-known, registered, dynamic) and the significance of port 22 (SSH)
* Detection, logging, and how to responsibly report findings

---

## Key concepts:

### Reconnaissance / Footprinting / Information gathering

* **Reconnaissance**: The process of collecting publicly available and technical information about a target to understand its attack surface. In security testing, this helps plan defenses and prioritized testing.
* **Footprinting**: Creating a detailed profile of a target (domains, IP ranges, open services, technologies used). This is primarily passive information collection (e.g., WHOIS, public DNS, web tech lookups).
  
* **Active vs Passive**:

  * *Passive* — collecting public info without touching the target (WHOIS, public registries, search engines).
  * *Active* — probing the target (DNS queries, port scans) — **only with permission**.

### Network fundamentals

* **Internet → Router → Hops**: Packets travel across routers; each router is a “hop.” Tools such as `traceroute` reveal the hop path and latency to a destination.
* **Default gateway**: The local router IP used to reach other networks (your network’s first hop).
* **TTL (Time To Live)**: A packet header field decremented by every hop; when TTL hits zero, routers drop the packet. `traceroute` uses incremental TTLs to force intermediate routers to reveal themselves. TTL manipulation can be abused in attacks — never perform TTL-manipulation attacks against third parties.

---

## VM networking: Bridge vs NAT

* **NAT (Network Address Translation)**: VM shares host’s IP; VMs are behind a virtual NAT. Good for isolation and quick internet access. By default, inbound connections from the external network to the VM are blocked (unless port forwarding is set).
* **Bridged mode**: VM gets an IP on the same network as the host. The VM is directly reachable from other devices on the LAN (useful when you need the VM to be addressable by other hosts).
* Choose NAT for safer, isolated labs; choose Bridge when you need the VM to be reachable from other machines in your lab network (still only in controlled labs).

---

## Ports & port categories

* **Well-known ports (0–1023)** — commonly used services (HTTP 80, HTTPS 443, FTP 21, SMTP 25, SSH 22).

  * **22/tcp** — SSH (Secure Shell) — used for secure remote shell access and file transfer (SFTP/ SCP).
* **Registered ports (1024–49151)** — used by applications and services registered with IANA.
* **Dynamic/private ports (49152–65535)** — ephemeral ports used by clients for short-lived connections.

---

## Common tools (defensive focus)

> Use these tools **only** on authorized targets (your lab, local test apps, or systems with written permission).

### WHOIS (domain registration info)

* Purpose: Find domain registrant, registrar, registration/expiration dates, and name servers. Useful for footprinting and responsible reporting.

### Wappalyzer / BuiltWith (technology fingerprinting)

* Wappalyzer (browser extension) helps identify server-side and client-side technologies used by a site (CMS, analytics, frameworks). BuiltWith is a paid service with deeper insights. Use these to understand tech stacks for defensive assessment and inventory.

### ARIN / Regional Internet Registries (RIRs)

* Purpose: Look up IP address ownership, netblocks, and contact info for networks (useful to map IP ranges and find appropriate abuse contacts). Use ARIN, RIPE, APNIC, etc., depending on the region.

### traceroute / visual traceroute

* Use `traceroute <host>` (or `tracert` on Windows) to see the path packets take to a destination. Graphical traceroute tools exist for visualization. This helps with network mapping and diagnosing routing issues. Only perform on your own or authorized endpoints.

### tcpdump (packet capture)

* Used to capture network traffic for analysis. Good for debugging and learning about protocols. Example (authorized, local use):
  `sudo tcpdump -i <interface> -w capture.pcap`
* Open `.pcap` in Wireshark for analysis. Capture only on networks you control.

### nmap (port scanning)

* Use Nmap for discovering open ports and running services on authorized hosts. Scan responsibly and within scope. Basic examples (authorized testing):

  * Host discovery: `nmap -sn <network-range>`
  * Quick TCP scan: `nmap -sT -p 1-1024 <target>`
  * Service/version detection: `nmap -sV <target>`
* **Zenmap** is the Nmap GUI (good for visualizing scan results). Always include explicit permission before scanning third-party targets.

### tcpdump documentation & nmap cheatsheet

* Study the official docs and man pages for `tcpdump` and `nmap`. Practice in a lab; avoid aggressive flags that cause heavy traffic against remote hosts.

---

## Reconnaissance exercises (ethical examples)

Below are activities that cover the same learning goals ethically; perform them only in a lab or with permission.

1. **Passive footprinting (safe)**

   * Run `whois example.com` on public domains to learn how registrar and contact data is presented.
   * Use Wappalyzer on example sites to identify technologies (do not use it to fingerprint targets without permission).

2. **Map your network path**

   * `traceroute <your-host>` or `tracert <your-host>` to see routing hops to a known host (e.g., your own public server or a lab VM). Note default gateway and intermediate hops.

3. **Enumerate IP ranges (publicly available)**

   * Use ARIN/RIPE web lookup to find the netblock that an organization owns (for inventory and reporting). Do not use this for malicious probing.

4. **Authorized port scanning**

   * On a lab VM or your own server, run Nmap scans to discover open services and note port states (open, closed, filtered). Practice `-sV` to see service versions and study how this informs patching priorities.

5. **Packet capture & analysis**

   * Start `tcpdump` on a lab interface, perform benign actions (browse your local test site), and analyze captured packets in Wireshark to understand protocol headers, TTL values, and port numbers.

6. **Documenting findings & reporting**

   * If you discover misconfigurations on systems you administer, document steps to remediate and notify the responsible team. If you find potential compromise or leaked data on public sites, follow the Responsible Reporting Template and contact the owner/abuse contacts.

---

## About DoS / TTL-based attacks & flooding (refusal)

* Course note: **Denial-of-Service (DoS)** attacks intentionally make services unavailable. TTL-manipulation and traffic flooding are examples of techniques that can be exploited.
* I will **not** provide commands or scripts for performing DoS attacks (e.g., traffic flooding, TTL manipulation, or use of `hping3 --flood`) because these actions are illegal without explicit authorization and can cause real harm.
* Instead, focus on **detection** (rate-limit alerts, WAF logs, SIEM rules) and **mitigation** (rate limiting, DDoS protection services, ingress filtering).

---

## Nmap quick reference (ethical use)

* `nmap -sn 192.168.1.0/24` — ping sweep to discover live hosts (lab only).
* `nmap -sT -p 1-1024 <target>` — TCP connect scan of common ports (lab only).
* `nmap -sV <target>` — service/version detection.
* `nmap --script vuln <target>` — run vulnerability scripts (use in controlled environments).

**Note:** Add `-Pn` if the host blocks ping and you have permission; always obtain scope consent.

---

## Defensive monitoring & detection suggestions

* Monitor for **unexpected port scans** or spikes in connection attempts in firewall and IDS logs.
* Alert on **multiple failed connections** to many ports from a single IP (could indicate scanning/recon).
* Use Honeytokens / honeypots to detect reconnaissance attempts on your network.
* Maintain WAF and rate limiting to protect against automated probing.

---

## Further reading & references

* Nmap official documentation & Zenmap GUI docs
* tcpdump & Wireshark documentation
* ARIN / RIPE / APNIC lookup tools
* Wappalyzer & BuiltWith documentation
* Intro to TCP/IP and traceroute behavior (TTL explanation)
* OWASP: Reconnaissance guidelines and ethical testing practices

