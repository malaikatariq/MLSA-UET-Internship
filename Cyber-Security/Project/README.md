# **Project: Configuring Firewall Rules for Network Security**

## **Author & Details**

*   **Name:** Malaika Tariq
*   **Date:** October 9, 2025
*   **Program:** Cybersecurity Intern - MLSA UET Peshawar
*   **Mentor:** Sir Noor-ul-Haq

## **⚠️ Disclaimer: For Educational & Testing Purposes Only**

**This project was conducted in a controlled, isolated lab environment.**
*   All firewall configurations and tests were performed on **my own personal virtual machines**.
*   No corporate, public, or external networks were affected in any way.
*   The rules implemented, especially those that block traffic, are for demonstration purposes and illustrate security principles.

**The goal of this project is purely educational. It aims to:**
*   Provide hands-on experience with core network security concepts.
*   Demonstrate the functionality and importance of host-based firewalls.
*   Develop skills in automation for security tasks.

**Modifying firewall rules on production systems or networks without explicit authorization is disruptive and may be a violation of policy. Always ensure you have permission before performing any security testing.**

---

## **1. Introduction**

A firewall is a fundamental network security device or software that acts as a barrier between trusted internal networks and untrusted external networks (like the internet). It monitors and controls incoming and outgoing network traffic based on a set of predefined security rules. By selectively allowing or blocking data packets, firewalls protect systems from unauthorized access, malware, and a wide array of network-based attacks.

This project provides a practical exploration of configuring and automating host-based firewalls on both Windows and Linux platforms.

## **2. Project Objective**

The primary goal of this project was to gain practical, hands-on experience in configuring firewall rules to control network traffic effectively. The specific objectives were:

*   To understand and create basic firewall rules for common protocols (HTTP, HTTPS, SSH, RDP, ICMP, DNS).
*   To implement advanced rules for granular control, such as rules based on IP addresses, application paths, and network profiles.
*   To automate the firewall configuration process using scripting in **PowerShell (Windows)** and **Bash (Linux)**.
*   To rigorously test each rule to verify its functionality and understand its impact on network connectivity.

## **3. Tools & Technologies Used**

| Category | Tool / Technology |
| :--- | :--- |
| **Operating Systems** | Windows 10, Kali Linux |
| **Firewall Systems** | Windows Defender Firewall with Advanced Security, `iptables` |
| **Scripting Languages** | PowerShell, Bash |
| **Testing & Validation** | `ping` (ICMP), Web Browser (HTTP/HTTPS), `nslookup` (DNS), Remote Desktop Client (RDP), SSH Client |

## **4. Implementation & Methodology**

The project was executed in two parallel streams: one for Windows and one for Linux.

### **4.1. Windows Firewall Configuration (via PowerShell)**

The Windows portion utilized the `NetSecurity` module in PowerShell to interact with the Windows Defender Firewall.

**Key Rules Implemented:**
*   **Block HTTP (Port 80):** Prevents outbound web traffic to unencrypted websites.
*   **Allow HTTPS (Port 443):** Permits outbound traffic to secure websites.
*   **Block ICMP (Ping Requests):** Prevents the system from responding to ping commands, making it less visible on the network.
*   **Advanced Rules:** Included allowing RDP only on a Private network profile, blocking a specific malicious IP address, and blocking traffic for a specific application (Microsoft Edge).

**Execution:**
1.  The PowerShell script (`firewall-tool.ps1`) was saved and executed in an **Administrator** PowerShell session.
2.  The execution policy was temporarily set to `RemoteSigned` to allow the script to run.
3.  An interactive menu was presented for users to select which rule to create.

**Screenshot: Windows PowerShell script output showing the interactive menu.**

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Project/assets/PowerShell.png)

**Screenshot: Result of `ping` command before and after implementing the 'Block ICMP' rule.**
**Before**

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Project/assets/Before%20ICMP.png)

**After**

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Project/assets/After%20ICMP%20Block.png)


### **4.2. Linux Firewall Configuration (via iptables)**

The Linux portion used the `iptables` utility, the classic command-line interface for managing netfilter, the Linux kernel's built-in firewall.

**Key Rules Implemented:**
*   **Allow/Block HTTP/HTTPS:** Demonstrates how to open and close web traffic ports.
*   **Allow/Block ICMP:** Controls echo requests (pings).
*   **Allow DNS (Port 53 UDP):** Permits domain name resolution.
*   **Advanced Rules:** Included blocking all incoming traffic by default, allowing SSH only from a trusted IP, and blocking a range of ports (135-139) commonly associated with Windows NetBIOS vulnerabilities.

**Execution:**
1.  The Bash script (`firewall-tool.sh`) was made executable with `chmod +x`.
2.  Existing rules were flushed to ensure a clean state for testing.
3.  The script was run with `sudo` privileges to modify firewall rules.

**Screenshot: Terminal output after running the Linux bash script, showing the new iptables rules.**

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Project/assets/IPTABLE.png)

**Screenshot: Web browser failing to load an HTTP site after the rule is applied.**
**Before**

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Project/assets/Before%20HTTP.png)

**After**

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Project/assets/After%20HTTP%20Block.png)

## **5. Automation Scripts**

A core achievement of this project was the development of interactive automation scripts.

*   **Windows (`firewall-tool.ps1`):** This PowerShell script features a user-friendly menu system using a `switch` statement within a `do-while` loop. It allows users to easily select from a list of basic and advanced rules, which are then executed with precise `New-NetFirewallRule` cmdlets.

*   **Linux (`firewall-tool.sh`):** This Bash script uses a `case` statement to present a menu of options. It directly manipulates the `iptables` ruleset, providing immediate feedback and listing the current rules after execution.

These scripts demonstrate the power of automation in cybersecurity, allowing for rapid, consistent, and repeatable configuration deployment.

## **6. Challenges & Learnings**

*   **Platform Differences:** Configuring firewalls on Windows (stateful, profile-based) versus Linux (`iptables`'s chain-based, stateless default) provided deep insight into different security models.
*   **Rule Precedence:** Understanding the order in which rules are processed was critical, especially in `iptables` where the first matching rule is applied.
*   **Testing is Crucial:** Every rule required thorough testing before and after application to confirm it worked as intended and did not cause unintended connectivity issues (e.g., locking oneself out of a remote system).
*   **The Principle of Least Privilege:** This project was a practical application of this principle, learning to block everything by default and only allow what is explicitly necessary.

## **7. Conclusion**

This project was instrumental in bridging the gap between theoretical knowledge of firewalls and practical implementation skills. I successfully configured, tested, and automated a variety of firewall rules on two major operating systems.

The key takeaways are:
1.  **Firewalls are a critical first line of defense.** Properly configured rules can significantly reduce a system's attack surface.
2.  **Automation is a force multiplier.** Scripting repetitive security tasks ensures consistency, saves time, and reduces human error.
3.  **Understanding both Windows and Linux security is essential.** A skilled cybersecurity professional must be versatile across platforms.

The hands-on experience gained in writing security rules, debugging scripts, and validating outcomes has provided a solid foundation for a career in network security, SOC operations, or security engineering.


## **9. Repository Contents**

*   `firewall-tool.ps1` // PowerShell automation script for Windows Firewall
*   `firewall-tool.sh` // Bash automation script for Linux iptables
*   `README.md` // This project report
*   `/screenshots/` // Directory containing validation screenshots
