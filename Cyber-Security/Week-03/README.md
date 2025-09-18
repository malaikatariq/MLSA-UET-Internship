# **Week 3: Understanding System Hacking Techniques & Defenses**

## **⚠️ Disclaimer: For Educational Purposes Only**

**This report is a theoretical and analytical study conducted for educational purposes within a controlled lab environment.** The techniques and tools discussed (e.g., password cracking, keyloggers) are **never to be used against any system, network, or individual without explicit, written permission** from the owner. Unauthorized access is illegal and unethical. The primary goal of this research is to understand malicious attack vectors to build more robust and effective defenses. Knowledge of these techniques is essential for any cybersecurity professional to protect digital assets.

---

## **Overview**

Week 3 focused on **System Hacking**, a phase where an attacker moves from initial access to deepening their control over a target system. This report details the core concepts of authentication attacks, malware, and privilege escalation from a defensive standpoint. The objective was to analyze these methods to better understand how to detect, prevent, and mitigate them.

## **Key Objectives**

*   To understand the theory behind various password-based attacks.
*   To analyze the functionality and threats posed by keyloggers and Remote Access Trojans (RATs).
*   To research methods of privilege escalation and malware persistence.
*   To compile a comprehensive list of defensive strategies and best practices to protect against these techniques.

## **Core Concepts & Technical Analysis**

### **1. Password Attacks**

Password attacks aim to discover a user's credentials to gain unauthorized access.

| Attack Type | How It Works | Defensive Strategy |
| :--- | :--- | :--- |
| **Password Guessing** | Attempting common passwords manually (e.g., `password123`, `admin`). | **Account Lockout Policies:** Lock accounts after 3-5 failed attempts. **Strong Password Policies:** Enforce complexity requirements. |
| **Dictionary Attack** | Using a file (a "dictionary") of common words and passwords to automate guesses. | **Multi-Factor Authentication (MFA):** Renders a stolen password useless. **Monitoring:** Alert on multiple failed login attempts from a single source. |
| **Brute Force Attack** | Systematically trying all possible character combinations until the correct password is found. | **Complex Passwords:** Longer passwords (12+ chars) with variety (upper, lower, number, symbol) exponentially increase the time required to crack. **Account Lockout.** |
| **Hybrid Attack** | Combines a dictionary attack with brute force (e.g., appending numbers to words: `password123`). | The same defenses as Dictionary and Brute Force attacks apply. |
| **Rainbow Table Attack** | Uses precomputed tables of hashes to crack passwords quickly. Avoids the need to compute each hash live. | **Salting:** Adding a unique, random value to each password before hashing makes rainbow tables ineffective. |
| **Password Sniffing** | Intercepting network traffic to capture password hashes or cleartext passwords (e.g., using **Ettercap** for ARP spoofing on unencrypted HTTP traffic). | **Encryption:** Use HTTPS everywhere, VPNs, and encrypted protocols (SSH, SFTP). **Network Segmentation:** Makes lateral movement and sniffing more difficult. |

### **2. Keyloggers**

Keyloggers are tools that record every keystroke made on a compromised system.

*   **Software Keyloggers:** Malicious programs installed through phishing, drive-by downloads, or other malware. They can be:
    *   **Kernel-based:** Operating at a deep level in the OS, making them harder to detect.
    *   **Application-based:** Injecting into browser processes or other applications.
    *   **Form-grabbers:** Specifically capturing data before it is submitted in web forms.
*   **Hardware Keyloggers:** Physical devices plugged in-line between the keyboard and computer (e.g., a USB dongle). These are undetectable by software.

#### **How to Protect Yourself from Keyloggers: Using a Good Antivirus**

A robust, modern antivirus/anti-malware suite is your first and most important line of defense against software keyloggers. Here’s how it helps and what to look for:

1.  **Real-Time Scanning:** A good AV continuously monitors your system for suspicious activity and scans files as they are downloaded or executed, blocking known keyloggers before they can install.
2.  **Behavioral Analysis (Heuristics):** Advanced AV solutions don't just rely on known signatures. They analyze program behavior. If a program tries to hook keyboard APIs or record keystrokes without a legitimate reason, the AV can flag and block it, even if it's a brand new (zero-day) keylogger.
3.  **Automatic Updates:** Antivirus databases are updated multiple times a day. This ensures you are protected against the latest threats identified by the vendor's security researchers.
4.  **Additional Features:** Many suites include:
    *   **Firewalls** to block unauthorized network traffic from a RAT.
    *   **Web protection** to block access to malicious websites that distribute keyloggers.
    *   **Anti-phishing** protection.

**Recommendations:** Use reputable antivirus software from vendors like **Bitdefender, Kaspersky, Norton, or Malwarebytes**. Do not rely on free, outdated, or unknown antivirus programs. Keep it updated.

**Important Note:** **No antivirus can detect a hardware keylogger.** Physical security is the only defense: be aware of your devices in public spaces and check for unauthorized hardware.

### **3. Remote Access Trojans (RATs)**

RATs are sophisticated malware that provides an attacker with full control over a victim's machine, as if they were sitting in front of it.

*   **Capabilities:** File browsing, uploading/downloading, keylogging, microphone/webcam activation, and executing commands.
*   **Distribution:** Often disguised as legitimate software (cracks, keygens, free games) or delivered via phishing emails.
*   **Defense:** **Antivirus/EDR** solutions, **network firewalls** alerting on unexpected outbound connections, and user education to avoid downloading untrusted software.

### **4. Privilege Escalation**

This is the act of exploiting a bug or misconfiguration to gain higher-level privileges (e.g., moving from a standard user to an Administrator or `root`).

*   **Vertical Escalation:** Gaining more rights for the same user (e.g., user -> admin).
*   **Horizontal Escalation:** Gaining the rights of another user at the same privilege level.
*   **Defense:** **Principle of Least Privilege (PoLP):** Ensure users and applications only have the minimum permissions needed to function. **Regular patching** of OS and software to fix privilege escalation vulnerabilities.

### **5. Malware Persistence (Hiding)**

Attackers ensure their malware survives reboots by installing itself in persistence mechanisms.
*   **Methods:** Registry run keys, scheduled tasks, service installation, startup folder, bootkit.
*   **Defense:** **Antivirus/EDR** tools, **system monitoring** for changes to startup locations, and using tools like **Autoruns** from Sysinternals to audit auto-starting programs.

## **Lab Environment & Practical Analysis**

**Note:** All practical analysis was conducted in a isolated, virtualized lab environment using intentionally vulnerable systems (e.g., Metasploitable, Windows 10 VMs with known vulnerabilities) and tools like **Hashcat** (for password cracking) and **Ettercap** (for analyzing network sniffing risks).

**Example Workflow:**
1.  **Dumped password hashes** from a lab VM.
2.  Used **Hashcat** with a wordlist (**rockyou.txt**) to perform a dictionary attack on the hashes, successfully cracking weak passwords.
3.  **Observation:** Simple passwords were cracked in seconds, while complex passwords (`S&cur1ty!Rul3s#`) remained secure, demonstrating the critical importance of password strength.

## **Conclusion & Key Takeaways**

Understanding system hacking techniques is not about enabling attacks, but about building effective fortifications.

1.  **Passwords are Inherently Weak:** They are the primary target. **MFA is non-negotiable** for securing any important account.
2.  **Layered Defense (Defense in Depth):** No single tool is enough. Combine strong passwords + MFA + updated antivirus/EDR + firewalls + user training.
3.  **Encryption is a Shield:** Using HTTPS and VPNs protects your data in transit from sniffing attacks.
4.  **Patching and Least Privilege:** These are the most effective ways to minimize the attack surface and prevent privilege escalation.
5.  **User Awareness is Critical:** The most sophisticated security tool can be bypassed by a user clicking a malicious link. Continuous education is vital.
