
# ⚡ Module 2: Describe Azure Compute and Networking Services  

## 📌 Introduction  
This module introduces the **compute** and **networking services** of Azure.  
You’ll learn about compute options like **Virtual Machines (VMs)**, **Containers**, and **Azure Functions**, as well as networking features like **Virtual Networks**, **Azure DNS**, and **ExpressRoute**.  

---

## 🎯 Learning Objectives  
After completing this module, you’ll be able to:  
- Compare compute types: container instances, VMs, and functions.  
- Describe VM options: VMs, scale sets, availability sets, and Azure Virtual Desktop.  
- Explain resources required for VMs.  
- Compare application hosting options: App Service, containers, and VMs.  
- Describe virtual networking: Virtual Networks, subnets, peering, Azure DNS, VPN Gateway, and ExpressRoute.  
- Define public and private endpoints.  

---

## 🔹 Azure Virtual Machines (VMs)  
Azure VMs provide **Infrastructure as a Service (IaaS)**, offering full control over the OS, software, and hosting configuration.  

### ✅ When to Use VMs  
- Full control over OS & environment.  
- Running **custom software** or hosting configurations.  
- Extending datacenter to the cloud.  
- Disaster recovery solutions.  
- **Lift-and-shift migration** from on-prem to cloud.  

### ✅ Scaling VMs  
- **Scale Sets** → Create/load balance groups of identical VMs, auto-scale with demand.  
- **Availability Sets** → Group VMs across update domains and fault domains for high availability.  

### 🗂 VM Resources  
- **Size** (CPU/RAM)  
- **Storage disks** (HDD, SSD)  
- **Networking** (VNet, Public IP, ports)  

---

## 🧪 Exercise: Create an Azure VM & Install Nginx  
Using Azure CLI:  

```bash
# Create a VM
az vm create \
  --resource-group "[sandbox resource group name]" \
  --name my-vm \
  --public-ip-sku Standard \
  --image Ubuntu2204 \
  --admin-username azureuser \
  --generate-ssh-keys  

# Install Nginx via Custom Script Extension
az vm extension set \
  --resource-group "[sandbox resource group name]" \
  --vm-name my-vm \
  --name customScript \
  --publisher Microsoft.Azure.Extensions \
  --version 2.1 \
  --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-welcome-to-azure/master/configure-nginx.sh"]}' \
  --protected-settings '{"commandToExecute": "./configure-nginx.sh"}'
```
This installs Nginx and configures a welcome page on your VM.

# ⚡ Azure Compute & Networking (Extended Notes)

---

## 🔹 Azure Virtual Desktop
A cloud-hosted **Windows desktop and app virtualization service**.  

- Access **Windows 10/11 Enterprise multi-session**.  
- Works across devices, browsers, and apps.  
- Enhanced **security with Entra ID + MFA**.  
- User sessions are isolated for better compliance.  

---

## 🔹 Azure Containers  

### ✅ What Are Containers?
- Lightweight virtualization → run multiple apps without managing OS.  
- More agile than VMs, great for **microservices architectures**.  
- Restart quickly on crash/hardware failure.  

### ✅ Azure Container Options
- **Container Instances (ACI)** → Fast, simple, PaaS-based containers.  
- **Container Apps** → Adds load balancing, autoscaling, and event-driven scaling.  
- **Azure Kubernetes Service (AKS)** → Full container orchestration, lifecycle & scaling.  

---

## 🔹 Azure Functions (Serverless)
Event-driven, serverless compute that scales automatically.  

### ✅ Benefits
- No infrastructure management.  
- Triggered by events (**HTTP, timers, messages, etc.**).  
- Pay only for execution time.  
- Supports **stateless** and **Durable Functions** (stateful workflows).  

---

## 🔹 Application Hosting Options  

### ✅ Azure App Service
A fully managed **PaaS hosting** for Web Apps, APIs, Mobile Apps, and WebJobs.  

- Supports multiple languages: **.NET, Java, Python, Node.js, PHP, Ruby**.  
- Autoscaling, load balancing, CI/CD integration.  

**Types of App Services**:  
- **Web Apps** → Host websites.  
- **API Apps** → Build REST APIs with Swagger support.  
- **WebJobs** → Run background tasks.  
- **Mobile Apps** → Backend for iOS/Android with push notifications & authentication.  

---

## 🔹 Azure Networking Services  

### 🌐 Virtual Networks (VNet)
Enable Azure resources (VMs, Apps, DBs) to communicate securely.  

- **Isolation & segmentation** with subnets.  
- **Public endpoints** → internet accessible via Public IP.  
- **Private endpoints** → internal only within VNet.  
- **Peering** → connect VNets across regions with private traffic.  

### 🔄 Communication Options
- **Point-to-site VPN** → Device → VNet.  
- **Site-to-site VPN** → On-prem network → Azure.  
- **ExpressRoute** → Private dedicated link to Azure.  

### 🔐 Traffic Control
- **NSGs (Network Security Groups)** → Allow/Deny rules (e.g., HTTP on port 80).  
- **Route Tables & BGP** → Custom traffic routing.  
- **NVAs (Network Virtual Appliances)** → Firewalls/WAN optimization.  

---

## 🧪 Exercise: Configure Network Access  

### 1️⃣ Get VM Public IP
```bash
IPADDRESS="$(az vm list-ip-addresses \
  --resource-group "IntroAzureRG" \
  --name my-vm \
  --query "[].virtualMachine.network.publicIpAddresses[*].ipAddress" \
  --output tsv)"
```
### 2️⃣ Try Accessing Web Server
```bash
curl --connect-timeout 5 http://$IPADDRESS
```
### 3️⃣ Check NSG Rules
```bash
az network nsg rule list \
  --resource-group "IntroAzureRG" \
  --nsg-name my-vmNSG \
  --query '[].{Name:name, Priority:priority, Port:destinationPortRange, Access:access}' \
  --output table
```
### 4️⃣ Create HTTP Rule
```bash
az network nsg rule create \
  --resource-group "IntroAzureRG" \
  --nsg-name my-vmNSG \
  --name allow-http \
  --protocol tcp \
  --priority 100 \
  --destination-port-range 80 \
  --access Allow
```
### 5️⃣ Verify Access
```
curl http://$IPADDRESS

```
### ✅ Expected Output:
```
<html><body><h2>Welcome to Azure! My name is my-vm.</h2></body></html>
```
# 🌐 Azure Networking Services

---

## 🔹 Azure VPN Gateway
A secure encrypted tunnel between networks.  

### ✅ Connectivity Options
- **Site-to-site** → Datacenter ↔ VNet  
- **Point-to-site** → Device ↔ VNet  
- **VNet-to-VNet** → Cross-subscription VNet linking  

### ✅ Features
- Supports **Policy-based** and **Route-based VPNs** (preferred).  
- **High Availability Options**:  
  - Active/Standby (default)  
  - Active/Active (BGP enabled)  
  - VPN as ExpressRoute failover  
  - Zone-redundant gateways  

---

## 🔹 Azure ExpressRoute
A **private dedicated connection** between on-premises and Microsoft cloud.  

### ✅ Benefits
- Higher reliability, faster speeds, lower latency  
- Private (not over the internet)  
- Connects to **Azure, Microsoft 365, Dynamics 365**  
- Supports **Global Reach** → connect multiple on-premises locations via Azure backbone  

### ✅ Connectivity Models
- CloudExchange colocation  
- Point-to-point Ethernet  
- Any-to-any IP VPN  
- Direct ExpressRoute sites  

---

## 🔹 Azure DNS
Cloud-based **DNS domain hosting**.  

### ✅ Benefits
- **Global anycast network** → reliable & fast resolution  
- **RBAC security** with Azure AD  
- Manage DNS with same Azure tools/APIs  
- **Alias records** → simplify domain-to-service mapping  

---
# 📝 Module Assessment: Azure Compute & Networking

Test your knowledge with this module assessment. Choose the best response for each question.

---

## ✅ Check Your Knowledge

1. **Which Azure Virtual Machine feature staggers updates across VMs based on their update domain and fault domain?**  
   - **Availability sets** 

2. **Which Azure service allows users to use a cloud-hosted version of Windows from any location and connect from most modern browsers?**  
   - **Azure Virtual Desktop**  

3. **If you need connections between virtual networks, point-to-site connections, multisite connections, or coexistence with an Azure ExpressRoute gateway, which type of VPN gateway should you use?**    
   - **Route-based VPN gateway**  

---

## 📚 Summary

In this module, you learned about **compute and networking services in Azure**, including:

- Virtual Machines (VMs) and related options such as **scale sets** and **availability sets**.  
- Networking capabilities including **virtual networks (VNets)**, **ExpressRoute**, and **VPN gateways**.

---

## 🎯 Learning Objectives

After completing this module, you should be able to:

- Compare compute types, including **container instances, virtual machines, and functions**.  
- Describe virtual machine options: **VMs, VM scale sets, VM availability sets, and Azure Virtual Desktop**.  
- Identify the **resources required for virtual machines**.  
- Describe **application hosting options**, including **Azure Web Apps, containers, and virtual machines**.  
- Explain **virtual networking**, including:  
  - Azure Virtual Networks & subnets  
  - VNet peering  
  - Azure DNS  
  - VPN Gateway  
  - ExpressRoute  
- Define **public and private endpoints**.
  
---
# 📚 Resources

This document provides quick access to official documentation for key Azure services.  

---

## 💻 Compute Services
- [Azure Virtual Machines](https://learn.microsoft.com/azure/virtual-machines/)  
- [Azure Container Instances](https://learn.microsoft.com/azure/container-instances/)  
- [Azure Functions](https://learn.microsoft.com/azure/azure-functions/)  

---

## 🌐 Networking Services
- [Azure Virtual Network (VNet)](https://learn.microsoft.com/azure/virtual-network/virtual-networks-overview)  
- [Azure ExpressRoute](https://learn.microsoft.com/azure/expressroute/)  
- [Azure DNS](https://learn.microsoft.com/azure/dns/dns-overview)  

---
