
# ☁️ Module 1: Describe the Core Architectural Components of Azure  

## 📌 Introduction  
In this module, you’ll be introduced to the **core architectural components of Azure**.  
You’ll learn about both the **physical organization** of Azure (datacenters, availability zones, and regions) and the **management organization** (resources, resource groups, subscriptions, and management groups).  

---

## 🎯 Learning Objectives  
After completing this module, you’ll be able to:  
- Describe **Azure regions**, **region pairs**, and **sovereign regions**.  
- Explain **Availability Zones**.  
- Describe **Azure datacenters**.  
- Understand **Azure resources** and **Resource Groups**.  
- Describe **subscriptions**.  
- Describe **management groups**.  
- Explain the **hierarchy of resource groups, subscriptions, and management groups**.  

---

## 🔹 What is Microsoft Azure?  
Azure is a **continually expanding set of cloud services** that enables organizations to build, manage, and deploy applications globally using favorite tools and frameworks.  

### ✅ What Azure Offers
- **Bring ideas to life** → Build with industry-leading AI and cloud services.  
- **Seamlessly unify** → Manage infrastructure, data, analytics, and AI across an integrated platform.  
- **Innovate on trust** → Security and compliance from Microsoft as a trusted partner.  

### ✅ What You Can Do with Azure
- Run applications on **Virtual Machines (VMs)**.  
- Use **AI & ML services** for speech, vision, and decision-making.  
- Leverage **dynamic storage solutions** for massive datasets.  
- Deploy **serverless and containerized applications**.  

---

## 🔹 Azure Accounts & Subscriptions  
- **Azure account** → Required to start using services.  
- **Azure subscription** → Links to an account and organizes resources.  
- **Free account includes**:  
  - 12 months of free popular products  
  - $200 credit for the first 30 days  
  - 25+ always free services  

- **Free student account includes**:  
  - $100 credit  
  - Free developer tools  
  - No credit card required  

---

## 🔹 Azure Physical Infrastructure  

### 🏢 Datacenters  
- Secure facilities with power, cooling, and networking.  
- Grouped into **Regions** and **Availability Zones**.  

### 🌍 Regions  
- Geographical areas with one or more datacenters.  
- Some services are **region-specific**, while others are **global**.  

### 🛡 Availability Zones  
- Physically separate datacenters within a region.  
- Each has independent power, cooling, and networking.  
- Services supported:  
  - **Zonal services** (pinned to a specific zone)  
  - **Zone-redundant services** (auto-replicated across zones)  
  - **Non-regional services** (resilient to region-wide outages)  

### 🔄 Region Pairs  
- Regions are paired within the same geography, at least **300 miles apart**.  
- Advantages:  
  - Disaster recovery  
  - Rolling updates  
  - Data residency compliance  

### 🏛 Sovereign Regions  
- Isolated instances for compliance (e.g., **US Gov, China 21Vianet**).  

---

## 🔹 Azure Management Infrastructure  

### 📦 Resources & Resource Groups  
- **Resource** = Any deployable Azure item (VM, DB, etc.).  
- **Resource Group** = Logical container for resources.  
  - Actions applied to group → apply to all resources inside.  
  - Resources belong to only **one group at a time**.  

### 📑 Subscriptions  
- Unit of **management, billing, and access**.  
- Boundaries:  
  - **Billing boundary** → Controls cost management.  
  - **Access boundary** → Controls RBAC & governance.  
- Multiple subscriptions can exist under one account.  

### 🗂 Management Groups  
- Container for organizing multiple subscriptions.  
- Policies and access control flow **top → down**.  
- Scale:  
  - Up to **10,000 groups per directory**  
  - Up to **6 levels deep**  

---

## 🧪 Exercises  

### 🔹 Exercise 1: Explore Azure Interaction (10 min – 100 XP)  
- Access the [Azure Portal](https://portal.azure.com).  
- Launch **Cloud Shell** and explore:  
  - **PowerShell** → Run `Get-Date`, check CLI version: `az version`.  
  - **Bash** → Run `date`, check CLI upgrade: `az upgrade`.  
- Try **Interactive Mode**: `az interactive`.  

---

### 🔹 Exercise 2: Create an Azure Resource (VM Deployment)  
**Task 1: Create a Virtual Machine**  
1. Go to **Azure Portal → Create a Resource → Compute → Virtual Machine**.  
2. Configure:  
   - RG Name → `IntroAzureRG`  
   - VM Name → `my-VM`  
   - Username → `azureuser`  
   - Password → `your-password`  
   - Public Inbound Ports → None  
3. Click **Review + Create → Create**.  

**Task 2: Verify Resource Group**  
- Navigate: **Home → Resource Groups → IntroAzureRG**.  
- Verify associated resources created (VM, disk, network, etc.).  

**Task 3: Cleanup**  
- Delete `IntroAzureRG` to remove all resources.  

---

## 📝 Knowledge Check  

1. **How many resource groups can a resource belong to at once?**  
✅ One  

2. **What happens to resources when a setting is applied at the Resource Group level?**  
✅ The setting is applied to both current and future resources.  

3. **Which Azure feature replicates resources across regions 300 miles apart?**  
✅ Region pairs  

---

## 📌 Summary  
In this module, you learned:  
- The relationship between **datacenters, regions, and availability zones**.  
- The concept of **region pairs** and **sovereign regions**.  
- How resources are organized into **resource groups, subscriptions, and management groups**.  
- Practical experience with **Azure Portal, CLI, and VM creation**.  

---

## 📚 Resources  
- 🌍 [Azure Global Infrastructure](https://infrastructure.azure.com/)  
- 📖 [Azure Documentation](https://learn.microsoft.com/azure/)  
- 🎓 [Free Student Account](https://azure.microsoft.com/free/students/)  
