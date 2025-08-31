# Project 1: News Headlines Dashboard

This project demonstrates a simple **Azure-based news fetching system**. It uses **Azure Functions**, **Blob Storage**, and a **frontend UI** to automatically fetch, store, and display the latest news headlines.

---

## Project Goal

The system flow is as follows:

1. **Time Trigger Function** → Automatically runs every X minutes to fetch news.
2. **Fetch News from NewsAPI** → Retrieves the latest headlines.
3. **Store News in Blob Storage** → Saves news JSON files for persistent access.
4. **UI (Web Page)** → Reads news from Blob Storage (directly or via HTTP Function) and displays it to users.

This setup combines a **backend (Azure Functions)**, **storage**, and **frontend (UI)**.

---

## Step 1: Azure Setup

### 1.1 Function App

A **Function App** is a container for all your Azure Functions.

**Steps:**
1. Go to **Azure Portal → Create Function App**
2. Settings:
   - **Runtime**: Node.js (simpler for beginners)
   - **Hosting Plan**: Consumption (scales automatically, cost-effective)
   - **Region**: Choose the nearest one
3. Review + Create → Wait for deployment

### 1.2 Storage Account

Azure Functions require storage to work.

**Steps:**
1. Go to **Azure → Storage Account → Create**
2. Note the following:
   - **Connection string** → Used in your code to save/read blob files
   - **Container name** → Where JSON files will live (e.g., `newscontainer`)

---

## Step 2: Time Trigger Function

### 2.1 What is it?

A **time-triggered function** automatically runs on a schedule, e.g., every 30 minutes or 1 hour.

### 2.2 Schedule

Azure uses CRON expressions:
```

- Runs every 30 minutes  
- Format: `second minute hour day month day-of-week`

### 2.3 Sample Code (`FetchNews`)

```javascript
const axios = require('axios'); // NewsAPI calls
const { BlobServiceClient } = require('@azure/storage-blob'); // Save data in blob

module.exports = async function (context, myTimer) {
    const NEWS_API_KEY = "YOUR_NEWSAPI_KEY";
    const BLOB_CONN_STRING = "YOUR_BLOB_CONNECTION_STRING";
    const CONTAINER_NAME = "newscontainer";
    const BLOB_NAME = "headlines.json";

    // Fetch news
    const url = `https://newsapi.org/v2/top-headlines?country=us&apiKey=${NEWS_API_KEY}`;
    let newsData;
    try {
        const response = await axios.get(url);
        newsData = response.data;
        context.log("News fetched successfully!");
    } catch (err) {
        context.log("Error fetching news:", err.message);
        return;
    }

    // Save news to Blob Storage
    try {
        const blobServiceClient = BlobServiceClient.fromConnectionString(BLOB_CONN_STRING);
        const containerClient = blobServiceClient.getContainerClient(CONTAINER_NAME);

        if (!(await containerClient.exists())) await containerClient.create();

        const blockBlobClient = containerClient.getBlockBlobClient(BLOB_NAME);
        await blockBlobClient.upload(JSON.stringify(newsData), Buffer.byteLength(JSON.stringify(newsData)));
        context.log("News saved to blob successfully!");
    } catch (err) {
        context.log("Error saving blob:", err.message);
    }
};
```
---
### Step 3: Optional HTTP Trigger Function
- Purpose

- Allows the frontend UI to easily access the news JSON.

- Serves the blob content as an HTTP response.

- Sample Code (GetNews):
```
const { BlobServiceClient } = require('@azure/storage-blob');

module.exports = async function (context, req) {
    const BLOB_CONN_STRING = "YOUR_BLOB_CONNECTION_STRING";
    const CONTAINER_NAME = "newscontainer";
    const BLOB_NAME = "headlines.json";

    try {
        const blobServiceClient = BlobServiceClient.fromConnectionString(BLOB_CONN_STRING);
        const containerClient = blobServiceClient.getContainerClient(CONTAINER_NAME);
        const blockBlobClient = containerClient.getBlockBlobClient(BLOB_NAME);

        const downloadBlockBlobResponse = await blockBlobClient.download(0);
        const downloaded = await streamToString(downloadBlockBlobResponse.readableStreamBody);

        context.res = { 
            body: downloaded,
            headers: { "Content-Type": "application/json" } 
        };
    } catch (err) {
        context.res = { status: 500, body: "Error fetching news" };
    }
};

async function streamToString(readableStream) {
    return new Promise((resolve, reject) => {
        const chunks = [];
        readableStream.on("data", (data) => chunks.push(data.toString()));
        readableStream.on("end", () => resolve(chunks.join("")));
        readableStream.on("error", reject);
    });
}
```
---
### Step 4: Troubleshooting
**Package Installation**
1- Create package.json in the function folder:
```
{
  "name": "fetch-news-function",
  "version": "1.0.0",
  "description": "Fetch news and save to blob",
  "main": "index.js",
  "dependencies": {
    "axios": "^1.6.0",
    "@azure/storage-blob": "^14.11.0"
  }
}
```
---
2-Install packages using Kudu Console:
```
cd site/wwwroot/FetchNews
npm install
```
---
**3- Verify node_modules exists.**

- HTTP Function Package Fix:
```
{
  "name": "getnews",
  "version": "1.0.0",
  "description": "HTTP trigger for fetching news from blob",
  "main": "index.js",
  "dependencies": {
    "@azure/storage-blob": "12.14.0"
  }
}
```
---
### Step 5: Summary of Flow

- Timer Trigger Function runs every 30 minutes → fetches news → saves to blob.

- HTTP Trigger Function serves JSON from blob.

- UI page calls HTTP function → displays news.

- Tech stack:

 - Node.js for backend

 - Azure Blob Storage for persistent data

 - HTML + JavaScript for frontend
---
### Links

**Web App**[](https://happy-ground-0d5189903.2.azurestaticapps.net)

**UI Code Repository:**[](https://github.com/malaikatariq/mlsa-dashboard-project)

---
### Screenshots:
**News Dashboard**![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cloud-Computing/Week-02/Project-01/assets/News%20Dashboard%20UI.png)
**Static Web App**![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cloud-Computing/Week-02/Project-01/assets/Static%20Web%20App.png)
**Timer Function**![](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cloud-Computing/Week-02/Project-01/assets/Timer%20Funtion.png) 

---
## 📚 Learning Outcomes

- Azure Functions (serverless compute)  
- Blob Storage (storing JSON data)  
- App Service (hosting frontend)  
- Scheduling via Timer Trigger  
- Environment Variables / API Key management  

---

