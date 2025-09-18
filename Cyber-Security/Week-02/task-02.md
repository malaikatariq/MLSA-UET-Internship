# **Task-02 Report: Defensive Reconnaissance & Vulnerability Assessment**

## **Disclaimer**

**This report and all activities described within are for educational purposes only.** The reconnaissance and scanning activities were conducted against dummy, test, or intentionally-vulnerable websites (e.g., `example.com`, `httpbin.org`) that are designed for this purpose. **Scanning computer systems, networks, or websites without explicit, written permission from the owner is illegal and unethical.** This exercise was performed to understand the methodologies used in defensive security operations, such as penetration testing and vulnerability assessments, with the sole goal of learning how to defend against them.

---

## **Overview**

This weekly task focused on two fundamental pillars of offensive and defensive cybersecurity: **Passive/Active Reconnaissance** and **Network Discovery**. The objective was to gather publicly available information about target websites and perform controlled network scanning to identify potential entry points and vulnerabilities. This mimics the initial stages of a security assessment, providing critical data for both attackers and defenders.

## **Key Objectives**

1.  **Information Gathering:** To collect domain registration details and identify the technology stack of five target websites.
2.  **Vulnerability Research:** To correlate identified technologies and their versions with known, publicly disclosed vulnerabilities.
3.  **Port Scanning:** To practice using Nmap, the industry-standard network mapping tool, to discover open ports and services on target systems.
4.  **Documentation:** To accurately record findings and observations in a clear and professional manner.

## **Tools & Technologies Used**

*   **Information Gathering:**
    *   `whois` (Command-line tool)
    *   **Wappalyzer** (Browser Extension)
    *   Public vulnerability databases (CVE Details, NVD)
*   **Port Scanning:**
    *   **Nmap** (Network Mapper)
    *   Commands Used: `nmap -sS -sV -O <target>`, `nmap -sC -sV <target>`, `nmap -p- <target>`

## **Target Websites**

For this educational exercise, the following publicly-accessible, dummy websites were selected:
1.  `example.com` (Official test site by IANA)
2.  `httpbin.org` (A simple HTTP Request & Response service)
3.  `testphp.vulnweb.com` (A deliberately vulnerable web app by Acunetix)
4.  `demo.testfire.net` (A deliberately vulnerable web app by IBM)
5.  `ptl-9b73c5b4-6c987c98.libcurl.so` (A PentesterLab proxy target)

---

## **Task 1: Information Gathering & Vulnerability Research**

### **Methodology**
1.  Used the `whois` command in the terminal for each domain to retrieve registration information.
2.  Used the Wappalyzer browser extension while navigating to the homepage of each site to detect technologies.
3.  Researched the identified technology versions on databases like **CVE Details** and the **National Vulnerability Database (NVD)**.

### **Findings & Observations**

| Website | Whois Summary (Abridged) | Technology Stack (Wappalyzer) | Potential Vulnerabilities (Research) |
| :--- | :--- | :--- | :--- |
| **example.com** | Registrar: IANA<br>Registrant: Internet Assigned Numbers Authority | Web Server: **nginx**<br>Programming Language: **None detected** | **nginx:** Version not detected. If an old version was present, vulnerabilities like **CVE-2021-23017** (DoS) could be a concern. |
| **httpbin.org** | Registrar: Amazon.com, Inc.<br>Registrant: @CloudFlare | Web Server: **gunicorn/20.1.0**<br>Programming Language: **Python** | **gunicorn:** No critical CVEs for version 20.1.0. Older versions had issues like **CVE-2021-37582** (header parsing). |
| **testphp.vulnweb.com** | Registrar: Namecheap<br>Registrant: REDACTED FOR PRIVACY | Web Server: **Apache/2.4.7**<br>PHP: **5.6.40**<br>Database: **MySQL** | **Apache 2.4.7:** **EOL**, multiple CVEs (e.g., **CVE-2017-3169**).<br>**PHP 5.6.40:** **EOL**, numerous critical CVEs (e.g., **CVE-2019-11043** - RCE). **Extremely Vulnerable.** |
| **demo.testfire.net** | Registrar: MarkMonitor<br>Registrant: IBM Corp. | Web Server: **Microsoft-IIS/7.5**<br>ASP.NET: **4.0.30319**<br>JavaScript: **jQuery 1.4.2** | **IIS 7.5:** Old, potential for CVEs like **CVE-2015-1635** (RCE).<br>**jQuery 1.4.2:** **Extremely old**, vulnerable to XSS and other attacks. |
| **ptl-*.libcurl.so** | Registrar: Not Applicable (Proxy) | Web Server: **Apache/2.4.10**<br>PHP: **5.6.30**<br>OS: **Ubuntu** | **Apache 2.4.10:** Older version, CVEs present.<br>**PHP 5.6.30:** **EOL**, many public exploits available. |

**Summary of Task 1:** The exercise highlighted the critical security risk of running **End-of-Life (EOL)** software, as seen on the deliberately vulnerable sites. EOL products no longer receive security patches, making them prime targets for attackers.

---

## **Task 2: Port Scanning Practice with Nmap**

### **Methodology**
Standard Nmap commands were executed against the target domains from a controlled environment. The focus was on common switches:
*   `-sS`: TCP SYN stealth scan (default, fast, and relatively quiet).
*   `-sV`: Probe open ports to determine service/version info.
*   `-O`: Enable OS detection.
*   `-sC`: Run default scripts (safe for educational targets).
*   `-p-`: Scan all 65,535 ports.

### **Findings & Observations**

| Website | Command Executed | Key Observations & Results |
| :--- | :--- | :--- |
| **example.com** | `nmap -sS -sV example.com` | **Ports Open:** **80/tcp** (http) - `nginx`<br>**Ports Closed:** 21, 22, 23, etc.<br>**Ports Filtered:** Many. **Conclusion:** A simple, well-hardened web server with only essential HTTP port open. |
| **httpbin.org** | `nmap -sS -sV httpbin.org` | **Ports Open:** **80/tcp** (http) - `CloudFlare http proxy`<br>**Conclusion:** Running behind a reverse proxy (Cloudflare), which obscures the actual backend server details—a common and effective security practice. |
| **testphp.vulnweb.com** | `nmap -sC -sV testphp.vulnweb.com` | **Ports Open:** **80/tcp** (http) - `Apache httpd 2.4.7`<br>**Script Results:** Revealed `robots.txt` disclosing admin paths.<br>**Conclusion:** Exposes a vulnerable Apache version and information through HTTP. |
| **demo.testfire.net** | `nmap -sS -sV demo.testfire.net` | **Ports Open:** **80/tcp** (http) - `Microsoft-IIS 7.5`<br>**Conclusion:** Only port 80 open, running an old version of IIS. The main vulnerabilities are in the web application itself. |
| **ptl-*.libcurl.so** | `nmap -p- -sV <target>` | **Ports Open:** **80/tcp** (http) - `Apache/2.4.10 (Ubuntu)`<br>**Ports Filtered:** All other ports.<br>**Conclusion:** Confirmed the web server and version from Task 1. A full port scan (`-p-`) revealed no other unexpected services. |

**Summary of Task 2:** Nmap is a powerful tool for mapping a network's attack surface. The scans showed that most public websites only need to expose port 80 (HTTP) or 443 (HTTPS). The state of ports (open, closed, filtered) provides crucial information for both securing a system (close unused ports) and attacking it (target open ports).

---

## **Conclusion & Learnings**

This week's tasks provided hands-on experience with the foundational techniques of cybersecurity assessment.

*   **Reconnaissance is Key:** A significant amount of information about a target's potential weaknesses can be gathered from public sources and simple tools before any active interaction occurs.
*   **The Importance of Patch Management:** The most critical finding was the direct correlation between outdated, End-of-Life software and the presence of severe, publicly known vulnerabilities. Keeping systems updated is the single most effective defense.
*   **Understanding Network Posture:** Port scanning is not just for attackers; defenders use the same tools to audit their own networks, ensure compliance with security policies (e.g., "only port 443 should be open"), and identify misconfigurations.
*   **Professional Documentation:** The ability to clearly, accurately, and professionally document technical findings is an essential skill for any cybersecurity professional, whether writing a report for a client or an internal team.

This exercise successfully built proficiency in using essential security tools and reinforced the mindset of thinking like both an attacker and a defender.
