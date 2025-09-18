# **Task-03: Network Sniffing & Keylogger Implementation**

## **⚠️ Disclaimer: For Educational Purposes Only**

**This report documents a controlled security exercise performed in a isolated lab environment. All activities were conducted on virtual machines that I own and operate.**
*   **No real networks or systems were targeted.**
*   **No actual user credentials were compromised.**
*   **The keylogger was installed only on a Windows 10 virtual machine created specifically for this test.**

**The purpose of this project is strictly educational. It aims to:**
*   Demonstrate the severe risks of using unencrypted (HTTP) websites.
*   Illustrate the capabilities of malicious software like keyloggers.
*   Highlight the critical importance of encryption (HTTPS), network security, and endpoint protection.

**Unauthorized network sniffing, intercepting data, or installing monitoring software on systems you do not own is illegal and unethical. This knowledge is to be used for defensive security purposes only.**

---

## **Overview**

This task involved two core activities to understand common attack vectors:
1.  **Network Sniffing:** Using ARP poisoning to perform a Man-in-the-Middle (MitM) attack and capture unencrypted login credentials from network traffic.
2.  **Keylogger Implementation:** Installing and testing keylogging software on a target system to understand its data capture capabilities and stealth.

The objective was to gain a practical understanding of these threats to better defend against them.

## **Tools & Technologies Used**

*   **Attacker Machine:** Kali Linux (Virtual Machine)
*   **Tool:** Ettercap-graphical (for ARP poisoning and packet sniffing)
*   **Target Machine:** Windows 10 (Virtual Machine)
*   **Tool:** KidLogger (Keylogger)
*   **Target Websites:**
    1.  `http://demo.testfire.net` (Deliberately vulnerable site)
    2.  `http://testphp.vulnweb.com` (Deliberately vulnerable site)
    3.  `http://httpbin.org/basic-auth/user/passwd` (HTTP Basic Authentication endpoint)

## **Part A: Network Sniffing with Ettercap**

### **Objective**
To demonstrate how easily login credentials can be intercepted on a local network (LAN) when transmitted over unencrypted HTTP protocols.

### **Methodology & Steps**

1.  **Lab Setup:** Configured a virtual network (NAT or Host-only) with the Kali Linux and Windows 10 VMs residing on the same subnet.
2.  **Launch Ettercap:** Opened Ettercap on Kali Linux in graphical mode.
    *   **Sniffing Mode:** Unified sniffing.
    *   **Network Interface:** Selected `eth0` (or the appropriate interface for the lab network).
3.  **Host Discovery:** Scanned the network to populate the host list with active devices, identifying the Windows 10 VM and the default gateway.
4.  **Target Selection:**
    *   Added the **Gateway IP** to `Target 1`.
    *   Added the **Windows 10 VM IP** to `Target 2`.
    *   *This instructs Ettercap to poison the ARP tables of both devices, positioning the Kali machine between them.*
5.  **ARP Poisoning Attack:**
    *   Started the ARP poisoning attack with the "Sniff remote connections" option enabled.
    *   This caused all traffic between the victim and the gateway to be routed through the Kali machine.
6.  **Credential Capture:**
    *   On the Windows 10 VM, navigated to the three target HTTP websites and entered login credentials.
    *   In Ettercap, viewed the intercepted traffic in real-time by navigating to **View > Connections**.

### **Findings & Results**

*   **Successfully Captured Credentials:** Ettercap clearly displayed HTTP POST requests containing the credentials in plain text.
*   **Example Captured Data:** For a login on `testphp.vulnweb.com`, the following was visible in the packet data:
    `uname=test&pass=test`
*   **HTTPS Contrast:** Attempts to login to HTTPS sites (like Gmail) resulted in encrypted, unreadable data, highlighting the effectiveness of encryption.

**Screenshots:** Ettercap interface showing the ARP poisoning targets and active MitM attack.

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Week-03/assets/Ettercap3.png)

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Week-03/assets/Ettercap1.png)

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Week-03/assets/Ettercap2.png)

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Week-03/assets/ARP.png)

**Screenshots:** A captured HTTP packet in Ettercap showing `uname=test&pass=test` in plain text.

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Week-03/assets/Captured1.png)

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Week-03/assets/Captured2.png)

### **Defensive Recommendations**

*   **Use HTTPS Everywhere:** Website owners must enforce HTTPS. Users should always check for the padlock icon in the address bar.
*   **Network Encryption:** Use VPNs to encrypt all traffic on untrusted networks (e.g., Public Wi-Fi).
*   **Static ARP Entries:** In critical environments, static ARP tables can prevent poisoning.
*   **Network Monitoring:** Intrusion Detection Systems (IDS) like Snort can detect ARP spoofing attempts.

---

## **Part B: Keylogger Implementation & Analysis**

### **Objective**
To understand the functionality, stealth, and data collection capabilities of software keyloggers by implementing one in a controlled environment.

### **Methodology & Steps**

1.  **Environment:** Used a dedicated Windows 10 Virtual Machine as the target.
2.  **Installation:**
    *   Downloaded and installed **KidLogger**.
    *   **Windows Defender Bypass:** As expected, Windows Defender correctly identified and quarantined the file. It was temporarily disabled to complete the installation and testing, simulating a scenario where a user ignores security warnings.
3.  **Testing:**
    *   Typed sample text (usernames, passwords, emails) into Notepad and browser login fields.
    *   Opened various applications (Calculator, Chrome).
    *   Visited several websites.
4.  **Data Retrieval:** Accessed the `KidLogger.net` web dashboard to review the collected logs.

### **Findings & Results**

The keylogger successfully captured a wide array of sensitive data:
*   **Keystroke Logging:** Recorded every key pressed, including usernames and passwords typed into any field.
*   **Application Tracking:** Logged all executed applications (e.g., `notepad.exe`, `chrome.exe`).
*   **Website Monitoring:** Recorded URLs of all visited websites.
*   **System Activity:** Captured events like user logon and logoff.

**Screenshots:** The KidLogger dashboard showing a log of captured keystrokes from Notepad.

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Week-03/assets/Notepad.png)

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Week-03/assets/Captured%20D1.png)

**Screenshots:** The KidLogger dashboard showing the list of applications executed and websites visited.

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Week-03/assets/Captured%20D2.png)

![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cyber-Security/Week-03/assets/Captured%20D3.png)

### **Defensive Recommendations**

*   **Use a Reputable Antivirus/Anti-Malware:** This test proved their effectiveness. Windows Defender immediately flagged the keylogger. Keep it enabled and updated.
*   **Enable Behavioral Detection:** Modern Endpoint Detection and Response (EDR) tools can detect keylogging behavior based on how programs interact with the system, not just known signatures.
*   **User Education:** This is the primary defense. Users must be trained to:
    *   Never disable security software.
    *   Be wary of downloading and installing unknown software.
    *   Recognize phishing attempts that deliver such payloads.
*   **Principle of Least Privilege:** Using a standard user account instead of an administrator account can prevent the installation of many keyloggers.

---

## **Conclusion**

This practical exercise provided invaluable insights into two significant cybersecurity threats:

1.  **The critical importance of encryption.** Any data transmitted over HTTP is fundamentally insecure and can be trivially intercepted on a network. HTTPS is not optional; it is essential.
2.   **The pervasive threat of malware.** Keyloggers are highly effective at stealing sensitive data and can be difficult for the average user to detect. This underscores the non-negotiable need for robust, updated endpoint protection and informed user practices.

Understanding these attack methodologies is the first and most crucial step in building effective defenses against them. This knowledge directly applies to roles in security operations, network defense, and incident response.

