
# Module 3: Azure Storage Services

## Introduction
In this module, you’ll be introduced to **Azure Storage Services**. You’ll learn about the **Azure Storage Account**, different storage services, blob storage tiers, redundancy options, and ways to move data or entire infrastructures to Azure.

---

## Learning Objectives
After completing this module, you should be able to:

- Compare Azure storage services.  
- Describe storage tiers.  
- Describe redundancy options.  
- Describe storage account options and storage types.  
- Identify options for moving files, including **AzCopy**, **Azure Storage Explorer**, and **Azure File Sync**.  
- Describe migration options, including **Azure Migrate** and **Azure Data Box**.  

---

## Azure Storage Accounts
A **storage account** provides a unique namespace for your Azure Storage data that's accessible over HTTP/HTTPS. Storage accounts are secure, highly available, durable, and scalable.

### Types of Storage Accounts
| Type | Supported Services | Redundancy Options | Usage |
|------|------------------|-----------------|-------|
| Standard GPv2 | Blob, Queue, Table, Azure Files | LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS | Recommended for most scenarios. |
| Premium block blobs | Blob Storage | LRS, ZRS | High transaction rate scenarios. |
| Premium file shares | Azure Files | LRS, ZRS | Enterprise or high-performance file shares. |
| Premium page blobs | Page blobs only | LRS | Page blob storage only. |

### Storage Account Endpoints
- **Blob Storage:** `https://<storage-account-name>.blob.core.windows.net`  
- **Data Lake Storage Gen2:** `https://<storage-account-name>.dfs.core.windows.net`  
- **Azure Files:** `https://<storage-account-name>.file.core.windows.net`  
- **Queue Storage:** `https://<storage-account-name>.queue.core.windows.net`  
- **Table Storage:** `https://<storage-account-name>.table.core.windows.net`  

---

## Azure Storage Redundancy
Azure Storage replicates data to protect against failures:

### Primary Region Redundancy
- **Locally redundant storage (LRS):** 3 copies in a single data center (11 nines durability).  
- **Zone-redundant storage (ZRS):** Replicated across 3 availability zones (12 nines durability).  

### Secondary Region Redundancy
- **Geo-redundant storage (GRS):** LRS in primary + asynchronous replication to secondary region (16 nines durability).  
- **Geo-zone-redundant storage (GZRS):** ZRS in primary + LRS in secondary region (16 nines durability).  
- **Read-access options:** RA-GRS and RA-GZRS allow read access from the secondary region.

---

## Azure Storage Services
### 1. Azure Blobs
- Massively scalable object storage for text and binary data.  
- Supports **Data Lake Storage Gen2** for analytics.  
- Ideal for serving files, streaming media, backups, and big data.  

#### Blob Storage Tiers
- **Hot:** Frequent access.  
- **Cool:** Infrequent access, min. 30 days.  
- **Cold:** Rarely accessed, min. 90 days.  
- **Archive:** Rare access, long-term retention, min. 180 days.  

### 2. Azure Files
- Managed file shares accessible via **SMB** or **NFS**.  
- Mountable by cloud or on-premises systems.  
- Supports **Azure File Sync** for bi-directional sync.  

### 3. Azure Queues
- Messaging store for asynchronous communication.  
- Integrates with **Azure Functions** for event-driven actions.  

### 4. Azure Disks
- Block-level storage for VMs.  
- Fully managed, resilient, and high-performance.  

### 5. Azure Tables
- NoSQL structured data storage.  
- Ideal for hybrid or multicloud applications.  

---

# Exercise: Create a Storage Blob in Azure

This exercise will guide you through creating an Azure Storage Account, uploading a blob (file) to a container, changing access permissions, and cleaning up resources.

---

## Step 1: Verify Your Account
1. Sign in to the [Azure portal](https://portal.azure.com).

---

## Step 2: Create a Storage Account
1. Select **Create a resource**.  
2. Under **Categories**, select **Storage**.  
3. Under **Storage account**, select **Create**.  
4. On the **Basics** tab, fill in the following:
   | Setting          | Value |
   |-----------------|-------|
   | Subscription    | Select your subscription |
   | Resource group  | Create new → `IntroAzureRG` |
   | Storage account name | Enter a unique name |
   | Region          | Leave default |
   | Performance     | Standard |
   | Redundancy      | Locally redundant storage (LRS) |
5. On the **Advanced** tab:
   - **Allow enabling anonymous access on individual containers:** Checked  
6. Select **Review + Create**, validate the configuration, then click **Create**.  
7. Wait for deployment, then select **Go to resource**.

---

## Step 3: Work with Blob Storage
1. Under **Data storage**, select **Containers**.  
2. Click **+ Container** and configure:
   | Setting               | Value |
   |-----------------------|-------|
   | Name                  | Enter a container name |
   | Anonymous access level | Private (no anonymous access) |
3. Select **Create**.  
4. Prepare an image to upload (from your computer or download from Bing).  
5. Open the container → **Upload** → browse your image → **Upload**.  
6. Click on the uploaded blob → **Properties** → copy the URL and open it in a new browser tab.  
   - You should see a **ResourceNotFound** error because the blob is private.

---

## Step 4: Change Blob Access Level
1. Go back to the container → **Change access level**.  
2. Set **Anonymous access level** → **Blob (anonymous read access for blobs only)**.  
3. Click **OK**.  
4. Refresh the browser tab with the blob URL → your file should now be accessible.

> ✅ You have successfully created a storage account, added a container, uploaded a blob, and enabled anonymous access.

---

## Step 5: Clean Up Resources
1. From the Azure home page → **Resource groups**.  
2. Select **IntroAzureRG** → **Delete resource group**.  
3. Confirm deletion by typing `IntroAzureRG` → **Delete**.  

> This ensures you avoid unnecessary Azure costs.

---

## Notes
- Storage accounts must have **unique names** (3–24 characters, lowercase letters and numbers).  
- Blob access levels:
  - **Private:** No anonymous access.  
  - **Blob:** Anonymous read for blobs only.  
  - **Container:** Anonymous read for blobs and container listing.  
---

## Azure Data Migration Options
### Azure Migrate
- Unified migration hub for assessment and migration.  
- Tools include Discovery, Server Migration, Database Migration, App Service Migration Assistant.  

### Azure Data Box
- Physical device for large-scale offline data transfer.  
- Up to 80 TB per device.  
- Ideal for one-time, periodic, or initial bulk migrations.  

---

## Azure File Movement Options
- **AzCopy:** Command-line utility for copying/synchronizing files and blobs.  
- **Azure Storage Explorer:** GUI tool to manage storage accounts and files.  
- **Azure File Sync:** Centralizes file shares in Azure with local caching and cloud tiering.  

---

## Module Assessment & Answers
1. **Which tool automatically keeps files between an on-premises Windows server and an Azure cloud environment updated?**  
✅ **Answer:** Azure File Sync  

2. **Which storage redundancy option provides the highest degree of durability, with 16 nines of durability?**  
✅ **Answer:** Geo-zone-redundant storage (GZRS)  

3. **Which Azure Storage service supports big data analytics, as well as handling text and binary data types?**  
✅ **Answer:** Azure Blobs  

---

## Summary
In this module, you learned about:

- Azure Storage Accounts and types.  
- Storage redundancy options (LRS, ZRS, GRS, GZRS).  
- Different Azure storage services: Blobs, Files, Queues, Disks, Tables.  
- Data migration and file movement options using **Azure Migrate**, **Data Box**, **AzCopy**, **Storage Explorer**, and **File Sync**.  

---

## Additional Resources
- [Store data in Azure](https://learn.microsoft.com/en-us/training/modules/store-data-in-azure/) – Microsoft Learn course.  
- [Microsoft Certified: Azure Data Fundamentals](https://learn.microsoft.com/en-us/certifications/azure-data-fundamentals/) – Certification and training for Azure data fundamentals.
