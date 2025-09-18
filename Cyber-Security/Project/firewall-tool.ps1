<#
.SYNOPSIS
    Windows Firewall Configuration Tool
.DESCRIPTION
    An interactive PowerShell script to manage Windows Defender Firewall rules.
    Allows quick configuration of basic and advanced inbound rules for network security.
.DISCLAIMER
    For educational purposes only. Use on systems you have permission to configure.
#>

function Show-Menu {
    Clear-Host
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "    Windows Firewall Tool" -ForegroundColor Cyan
    Write-Host "===============================" -ForegroundColor Cyan
    Write-Host "BASIC RULES:" -ForegroundColor Yellow
    Write-Host "1. Allow RDP (3389) / SSH (22)" 
    Write-Host "2. Block HTTP (80)"
    Write-Host "3. Allow HTTPS (443)"
    Write-Host "4. Block ICMP (Ping)"
    Write-Host "5. Allow DNS (53)"
    Write-Host "ADVANCED RULES:" -ForegroundColor Yellow
    Write-Host "6. Block all incoming, allow outgoing"
    Write-Host "7. Allow SSH only from Trusted IP"
    Write-Host "8. Block a specific malicious IP"
    Write-Host "9. Block Edge application"
    Write-Host "10. Block ports 135-139 (NetBIOS)"
    Write-Host "11. Allow RDP only on Private profile"
    Write-Host "0. Exit" -ForegroundColor Red
}

# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script requires Administrator privileges. Please run PowerShell as Administrator!" -ForegroundColor Red
    exit
}

do {
    Show-Menu
    $choice = Read-Host "`nEnter your choice"

    switch ($choice) {
        # BASIC RULES
        1 { 
            New-NetFirewallRule -DisplayName "Allow_RDP_SSH" -Direction Inbound -Protocol TCP -LocalPort 3389, 22 -Action Allow -Profile Any
            Write-Host "[+] RDP (3389) and SSH (22) allowed!" -ForegroundColor Green
        }
        2 { 
            New-NetFirewallRule -DisplayName "Block_HTTP" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Block -Profile Any
            Write-Host "[+] HTTP (80) blocked!" -ForegroundColor Green
        }
        3 { 
            New-NetFirewallRule -DisplayName "Allow_HTTPS" -Direction Inbound -Protocol TCP -LocalPort 443 -Action Allow -Profile Any
            Write-Host "[+] HTTPS (443) allowed!" -ForegroundColor Green
        }
        4 { 
            New-NetFirewallRule -DisplayName "Block_ICMP" -Protocol ICMPv4 -IcmpType 8 -Direction Inbound -Action Block -Profile Any
            Write-Host "[+] ICMP (Ping) blocked!" -ForegroundColor Green
        }
        5 { 
            New-NetFirewallRule -DisplayName "Allow_DNS_Out" -Direction Outbound -Protocol UDP -LocalPort 53 -Action Allow -Profile Any
            Write-Host "[+] DNS (53) outbound allowed!" -ForegroundColor Green
        }

        # ADVANCED RULES
        6 { 
            Set-NetFirewallProfile -Profile Domain, Public, Private -DefaultInboundAction Block -DefaultOutboundAction Allow
            Write-Host "[+] All incoming connections blocked, outgoing allowed!" -ForegroundColor Green
        }
        7 { 
            $ip = Read-Host "Enter trusted IP for SSH (e.g., 192.168.1.100)"
            New-NetFirewallRule -DisplayName "Allow_SSH_Trusted_IP" -Direction Inbound -Protocol TCP -LocalPort 22 -RemoteAddress $ip -Action Allow
            Write-Host "[+] SSH allowed only from $ip!" -ForegroundColor Green
        }
        8 { 
            $ip = Read-Host "Enter malicious IP to block (e.g., 10.0.0.100)"
            New-NetFirewallRule -DisplayName "Block_Malicious_IP" -Direction Inbound -RemoteAddress $ip -Action Block
            Write-Host "[+] Blocked malicious IP: $ip!" -ForegroundColor Green
        }
        9 { 
            $edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
            if (Test-Path $edgePath) {
                New-NetFirewallRule -DisplayName "Block_Edge_Browser" -Direction Outbound -Program $edgePath -Action Block
                Write-Host "[+] Microsoft Edge browser blocked!" -ForegroundColor Green
            } else {
                Write-Host "[!] Edge browser path not found." -ForegroundColor Red
            }
        }
        10 { 
            New-NetFirewallRule -DisplayName "Block_NetBIOS_Ports" -Direction Inbound -Protocol TCP -LocalPort 135-139 -Action Block -Profile Any
            Write-Host "[+] NetBIOS ports (135-139) blocked!" -ForegroundColor Green
        }
        11 { 
            New-NetFirewallRule -DisplayName "Allow_RDP_Private" -Direction Inbound -Protocol TCP -LocalPort 3389 -Profile Private -Action Allow
            Write-Host "[+] RDP allowed on Private network profile only!" -ForegroundColor Green
        }

        0 { 
            Write-Host "Exiting... Thank you for using the Firewall Tool!" -ForegroundColor Cyan
            break 
        }
        default { 
            Write-Host "[!] Invalid choice! Please try again." -ForegroundColor Red 
        }
    }
    if ($choice -ne '0') {
        Write-Host "`nPress Enter to continue..."
        $null = Read-Host
    }
} while ($choice -ne '0')
