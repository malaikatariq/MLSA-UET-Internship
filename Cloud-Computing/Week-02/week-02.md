
# Azure Cloud Learning & News Fetcher Project

This repository contains the summary of **Week 2 Azure concepts** and a **project to deploy a news-fetching web application** using Azure services.

---

## Week 2 Overview

### 1. Azure Architectural Components
- **Regions**: Geographical locations where Azure data centers are located. Choose regions close to your users for low latency.
- **Availability Zones**: Physically separate locations within a region to ensure high availability.
- **Subscriptions**: Logical containers for billing and management of Azure resources.
- **Resource Groups**: Logical grouping of resources to manage them as a unit, simplifying deployment, monitoring, and access control.

### 2. Compute and Networking
- **Compute Types**:
  - Virtual Machines (VMs)
  - App Services
  - Azure Functions
- **Application Hosting**: Host web apps, APIs, and microservices.
- **Virtual Networking**: Create isolated networks, configure subnets, and manage network security.

### 3. Storage
- **Storage Services**:
  - Blob Storage
  - File Storage
  - Table Storage
  - Queue Storage
- **Redundancy Options**:
  - LRS (Locally Redundant Storage)
  - ZRS (Zone-Redundant Storage)
  - GRS (Geo-Redundant Storage)
  - RA-GRS (Read-Access Geo-Redundant Storage)
- **File Management & Migration**: Tools for uploading, downloading, and moving data across storage accounts.

### 4. Identity, Access, and Security
- **Directory Services**: Azure Active Directory (AAD) for identity management.
- **Authentication Methods**: Passwords, Multi-Factor Authentication (MFA), OAuth, and SSO.
- **Security Models**: Role-Based Access Control (RBAC) to assign permissions to users and groups.

---

## Project: Azure News Fetcher Web App

This project demonstrates a **full-stack Azure solution** with automatic news fetching, storage, and display.

### Project Goal

1. **Time Trigger Function** → Automatically runs every X minutes.
2. **Fetch News from NewsAPI** → Retrieves the latest headlines.
3. **Store News in Blob Storage** → Ensures data is accessible anytime.
4. **UI (Web Page)** → Reads news from Blob Storage (directly or via HTTP Function) and displays it.

**Stack Overview**:
- **Backend**: Azure Functions (Node.js)
- **Storage**: Azure Blob Storage
- **Frontend**: HTML + JavaScript UI

---

### Flow Diagram

1. **Timer Trigger Function** runs on schedule → fetches news → saves JSON to Blob Storage.
2. **HTTP Trigger Function** (optional) → serves JSON from Blob Storage to frontend.
3. **UI Web Page** → calls HTTP function → displays latest news headlines to users.

---

### Links

- [**Web App:**](https://happy-ground-0d5189903.2.azurestaticapps.net) 
- [**UI Code Repository:**](https://github.com/malaikatariq/mlsa-dashboard-project)  

---

---

