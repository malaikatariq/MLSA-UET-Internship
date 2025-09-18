#!/bin/bash

# =============================================================================
# Title: Kali Linux Firewall Tool (iptables)
# Description: Interactive menu to manage iptables firewall rules.
# Disclaimer: For educational use only on authorized systems.
# =============================================================================

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root. Use sudo: sudo ./$0"
    exit 1
fi

# Function to display menu
show_menu() {
    echo ""
    echo "==============================="
    echo "   Kali Linux Firewall Tool"
    echo "==============================="
    echo "1. Allow SSH (22)"
    echo "2. Block HTTP (80)"
    echo "3. Allow HTTP (80)"
    echo "4. Block HTTPS (443)"
    echo "5. Allow HTTPS (443)"
    echo "6. Block ICMP (Ping)"
    echo "7. Allow ICMP (Ping)"
    echo "8. Allow DNS (53 UDP)"
    echo "9. Block DNS (53 UDP)"
    echo "10. Block All Incoming (Default Deny)"
    echo "11. Allow SSH from Trusted IP"
    echo "12. Block Malicious IP"
    echo "13. Block NetBIOS Ports (135-139)"
    echo "14. Flush All Rules (Reset)"
    echo "0. Exit"
    echo "==============================="
}

# Function to show current rules
show_rules() {
    echo ""
    echo "Current iptables rules:"
    echo "-----------------------"
    iptables -L -v --line-numbers
    echo "-----------------------"
}

# Main loop
while true; do
    show_menu
    read -p "Select an option [0-14]: " choice

    case $choice in
        1)
            iptables -A INPUT -p tcp --dport 22 -j ACCEPT
            echo "[+] SSH (22) allowed."
            ;;
        2)
            iptables -A INPUT -p tcp --dport 80 -j DROP
            echo "[+] HTTP (80) blocked."
            ;;
        3)
            iptables -D INPUT -p tcp --dport 80 -j DROP 2>/dev/null
            iptables -A INPUT -p tcp --dport 80 -j ACCEPT
            echo "[+] HTTP (80) allowed."
            ;;
        4)
            iptables -A INPUT -p tcp --dport 443 -j DROP
            iptables -A INPUT -p udp --dport 443 -j DROP
            echo "[+] HTTPS (443) blocked."
            ;;
        5)
            iptables -D INPUT -p tcp --dport 443 -j DROP 2>/dev/null
            iptables -D INPUT -p udp --dport 443 -j DROP 2>/dev/null
            iptables -A INPUT -p tcp --dport 443 -j ACCEPT
            iptables -A INPUT -p udp --dport 443 -j ACCEPT
            echo "[+] HTTPS (443) allowed."
            ;;
        6)
            iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
            echo "[+] ICMP (Ping) blocked."
            ;;
        7)
            iptables -D INPUT -p icmp --icmp-type echo-request -j DROP 2>/dev/null
            echo "[+] ICMP (Ping) allowed."
            ;;
        8)
            iptables -A INPUT -p udp --dport 53 -j ACCEPT
            echo "[+] DNS (53) allowed."
            ;;
        9)
            iptables -A INPUT -p udp --dport 53 -j DROP
            echo "[+] DNS (53) blocked."
            ;;
        10)
            iptables -P INPUT DROP
            iptables -P FORWARD DROP
            iptables -P OUTPUT ACCEPT
            echo "[+] Default policy set: DROP all incoming, ACCEPT all outgoing."
            ;;
        11)
            read -p "Enter trusted IP for SSH: " ip
            iptables -A INPUT -p tcp --dport 22 -s "$ip" -j ACCEPT
            echo "[+] SSH allowed from $ip."
            ;;
        12)
            read -p "Enter malicious IP to block: " ip
            iptables -A INPUT -s "$ip" -j DROP
            echo "[+] Blocked malicious IP: $ip."
            ;;
        13)
            iptables -A INPUT -p tcp --dport 135:139 -j DROP
            echo "[+] NetBIOS ports (135-139) blocked."
            ;;
        14)
            iptables -F
            iptables -X
            iptables -P INPUT ACCEPT
            iptables -P OUTPUT ACCEPT
            iptables -P FORWARD ACCEPT
            echo "[+] All iptables rules flushed and reset to default ACCEPT."
            ;;
        0)
            echo "Exiting. Displaying final firewall rules:"
            show_rules
            echo "Thank you for using the firewall tool!"
            exit 0
            ;;
        *)
            echo "[!] Invalid option. Please choose between 0-14."
            ;;
    esac

    # Show rules after each operation
    show_rules
    read -p "Press Enter to continue..."
done
