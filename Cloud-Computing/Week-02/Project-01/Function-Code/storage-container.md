
# Azure Storage Setup (Blob Storage)

This document explains how to set up **Azure Storage (Blob Storage)** for the **News Headlines Dashboard** project.  
Blob Storage is used to save JSON files fetched by the Azure Function every hour.

---

## 📌 Step 1: Create a Storage Account

1. Go to [Azure Portal](https://portal.azure.com) → **Storage Accounts** → **Create**  
2. Fill in the details:
   - **Subscription:** Select your subscription  
   - **Resource Group:** Create new or use existing (e.g., `MLSA-Cloud-Project`)  
   - **Storage account name:** Must be unique (e.g., `project01`)  
   - **Region:** Choose closest to you  
   - **Performance:** Standard  
   - **Redundancy (Replication):** Locally-redundant storage (LRS)  
   - **Primary service (Account kind):** **Blob Storage (StorageV2)**  
   - **Access tier:** Hot  

3. Click **Review + Create** → then **Create**

---

## 📌 Step 2: Create a Blob Container

1. Open your new Storage Account → **Containers**  
2. Click **+ Container**  
   - **Name:** `news-data`  
   - **Public access level:** Private (recommended) or Blob if frontend needs direct access  
3. Click **Create**

Now you have a `news-data` container where JSON files will be stored in the structure:  
