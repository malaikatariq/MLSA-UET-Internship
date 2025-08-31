# Module 4: Azure Identity, Access, and Security

This module introduces Azure identity, access, and security services and tools. You’ll learn about directory services, authentication methods, access control, Zero Trust, defense in depth, and Microsoft Defender for Cloud.

---

## Learning Objectives
After completing this module, you will be able to:

- Describe Azure directory services, including Microsoft Entra ID and Microsoft Entra Domain Services.
- Describe authentication methods in Azure, including Single Sign-On (SSO), Multifactor Authentication (MFA), and passwordless authentication.
- Describe external identities and guest access in Azure.
- Describe Microsoft Entra Conditional Access.
- Describe Azure Role-Based Access Control (RBAC).
- Describe the concept of Zero Trust.
- Describe the purpose of the defense in depth model.
- Describe Microsoft Defender for Cloud.

---

## Azure Directory Services

### Microsoft Entra ID
- Cloud-based identity and access management service.
- Supports sign-in for Microsoft cloud apps and custom cloud apps.
- Integrates with on-premises Active Directory to detect suspicious sign-in attempts.
- Key users:
  - **IT administrators** – control access to applications and resources.
  - **App developers** – integrate SSO and authentication into apps.
  - **Users** – manage identities and self-service password reset.
  - **Online service subscribers** – authenticate into Microsoft 365, Azure, and Dynamics CRM Online.

**Core features:**
- **Authentication** – verify identity, support MFA, self-service password reset, smart lockout.
- **Single Sign-On (SSO)** – access multiple applications with one credential.
- **Application Management** – manage SaaS and on-premises apps via Entra ID.
- **Device Management** – register and manage devices using Microsoft Intune.

### Microsoft Entra Domain Services
- Managed domain services: domain join, group policy, LDAP, Kerberos/NTLM authentication.
- Benefits:
  - Run legacy applications in the cloud without maintaining on-premises AD DS.
  - Integrates with your Microsoft Entra tenant for seamless access using existing credentials.
- Works via a replica set of domain controllers in Azure, managed by the platform.
- Synchronization: one-way from Microsoft Entra ID to Domain Services.

---

## Azure Authentication Methods

### Overview
Authentication verifies identity for users, services, or devices. Azure supports:

- **Passwords** – traditional, but less secure.
- **Single Sign-On (SSO)** – one login for multiple apps; simplifies identity management.
- **Multifactor Authentication (MFA)** – adds extra verification (something you know, have, or are).
- **Passwordless Authentication** – uses devices or biometrics for secure, convenient access.

### Single Sign-On (SSO)
- Users sign in once to access multiple applications.
- Reduces password management issues and helpdesk requests.
- Security depends on the initial authenticator.

### Multifactor Authentication (MFA)
- Adds extra verification beyond passwords.
- Examples: code via phone, biometric verification.
- Protects against compromised credentials.

### Microsoft Entra MFA
- Provides MFA capabilities using phone calls, mobile app notifications, or hardware.

### Passwordless Authentication
- Replaces passwords with device-based or biometric authentication.
- Options:
  - **Windows Hello for Business** – PC-tied credentials with SSO support.
  - **Microsoft Authenticator App** – converts phones into passwordless credentials.
  - **FIDO2 Security Keys** – unphishable hardware or platform-based keys.

---

## Azure External Identities

### Overview
External identities refer to users, devices, or services outside your organization. Microsoft Entra External ID enables secure collaboration and interaction with external users.

### Key Capabilities
- **Business to Business (B2B) Collaboration** – external users use their preferred identity to access your apps.
- **B2B Direct Connect** – mutual trust between Entra tenants, including Teams shared channels.
- **Business to Customer (B2C)** – manage consumer-facing apps and customers’ identity experiences.

### Features
- Guests can be invited and access managed via Microsoft Entra ID.
- Access reviews ensure appropriate permissions and recertification.

---
# Azure Identity, Access, and Security – Module Summary

This module covers essential Azure security concepts, including Conditional Access, Role-Based Access Control (RBAC), Zero Trust, and Defense-in-Depth. It explains how to protect resources, manage access, and implement security best practices in the cloud.

---

## Azure Conditional Access

Conditional Access is a tool in **Microsoft Entra ID** that grants or denies access to resources based on identity signals, such as:

- Who the user is  
- Where the user is signing in from  
- What device the user is using  

**Benefits for IT Administrators:**

- Empower users to be productive anywhere, anytime  
- Protect organizational assets  

**How it works:**

1. **Collect signals:** Identity, device, location, and application  
2. **Decision:** Allow, deny, or require multifactor authentication (MFA) based on risk  
3. **Enforce:** Carry out the decision by granting access or challenging for MFA  

**Use Cases:**

- Require MFA depending on user role or location  
- Limit access to approved client applications  
- Restrict access to managed devices  
- Block access from untrusted sources  

---

## Azure Role-Based Access Control (RBAC)

Azure RBAC allows organizations to control access to cloud resources using the **principle of least privilege**.

**Key Concepts:**

- **Roles:** Built-in or custom roles define access permissions  
- **Scope:** The set of resources the role applies to (Management Group, Subscription, Resource Group, or Resource)  
- **Inheritance:** Permissions granted at a parent scope are inherited by child scopes  

**Example:**

- Assign the **Owner** role at the management group scope → Access to all subscriptions/resources within it  
- Assign the **Reader** role at subscription scope → View-only access for all resources  

**Enforcement:**

- RBAC uses an allow model via **Azure Resource Manager**  
- Permissions are effective for all actions initiated against a resource through the portal, CLI, PowerShell, or APIs  

---

## Zero Trust Model

Zero Trust assumes that **no network or device is automatically trusted**. Every access request must be verified.

**Principles:**

- **Verify explicitly:** Authenticate and authorize based on all available signals  
- **Use least privilege:** Apply Just-In-Time (JIT) and Just-Enough-Access (JEA) policies  
- **Assume breach:** Minimize attack surface, segment access, and monitor activity  

**Zero Trust vs Traditional Security:**

- Traditional networks trust internal devices  
- Zero Trust requires authentication and continuous verification for all requests  

---

## Defense-in-Depth

Defense-in-Depth is a layered security strategy designed to **protect data and resources** by implementing multiple controls at different levels.

**Layers of Defense:**

1. **Physical:** Secure datacenter hardware and facilities  
2. **Identity & Access:** Enforce SSO, MFA, and audit sign-ins  
3. **Perimeter:** Use firewalls and DDoS protection  
4. **Network:** Limit communication, deny by default, secure connectivity  
5. **Compute:** Protect VMs, patch systems, and deploy endpoint protection  
6. **Application:** Secure software development lifecycle, manage secrets securely  
7. **Data:** Ensure confidentiality, integrity, and availability of stored information  

**Goal:** If one layer is breached, subsequent layers provide continued protection and alerts for security teams.  

---

## Microsoft Defender for Cloud

**Purpose:**  
Defender for Cloud provides security monitoring, threat protection, and posture management for Azure, hybrid, and multicloud environments.

**Key Capabilities:**

- **Protection everywhere:** Monitors Azure, on-premises, and other cloud resources  
- **Azure-native protections:** Detect threats for PaaS, data services, and networks  
- **Hybrid and multicloud:** Extend threat protection to on-premises and AWS/GCP  
- **Assess, Secure, Defend:**
  - **Continuously assess:** Vulnerability assessments for VMs, containers, SQL  
  - **Secure:** Harden resources using Azure Security Benchmark and security policies  
  - **Defend:** Security alerts, advanced threat protection, just-in-time access  

**Advanced Features:**

- **Security alerts:** Provide affected resource details, remediation steps, and optional automation  
- **Threat protection:** Includes VM, SQL, container, web app, and network defenses  

---

## Module Assessment – Correct Answers

1. **Which Microsoft Entra tool can vary credentials needed to log in based on signals, such as location?**  
   **Answer:** Conditional Access  

2. **Which security model assumes the worst-case scenario and protects resources accordingly?**  
   **Answer:** Zero Trust  

3. **A user is assigned multiple roles in RBAC (Role 1: read, Role 2: write, Role 3: read/write). What are their actual permissions?**  
   **Answer:** Read and write  

---

## Summary

In this module, you learned about:

- Azure authentication methods (SSO, MFA, Passwordless)  
- Conditional Access for granular access control  
- Role-Based Access Control (RBAC) for least-privilege management  
- Zero Trust and Defense-in-Depth security models  
- Microsoft Defender for Cloud for assessing, securing, and defending resources  

---

## Additional Resources

- [Microsoft Certified: Security, Compliance, and Identity Fundamentals](https://learn.microsoft.com/en-us/certifications/security-compliance-and-identity-fundamentals/)  
- [Azure Security Documentation](https://learn.microsoft.com/en-us/azure/security/)  
- [Microsoft Defender for Cloud Documentation](https://learn.microsoft.com/en-us/azure/defender-for-cloud/)

