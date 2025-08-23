
# Project 1: News Headlines Dashboard

This is a **serverless news dashboard** built on **Azure** using free-tier services.  
It fetches top headlines from a free **News API** every hour, stores them in **Azure Blob Storage**, and displays them in a simple web dashboard with category filters.

---

## 📂 Repo Structure

- [`function-code/`](function-code/) → Azure Function backend (fetches news & stores JSON in Blob)  
- [`frontend/`](frontend/) → HTML, CSS, and JS for the news dashboard  
- [`images/`](images/) → Optional screenshots for documentation or dashboard  
- [`docs/`](docs/) → Optional architecture diagrams or project notes  

---

## ⚡ Features

- Hourly fetch of top news headlines  
- Stores JSON files in `news-data/{yyyy}/{MM}/{dd}/{HH}/headlines.json`  
- Frontend displays latest headlines with links and publish time  
- Category filter (Business, Tech, Sports, etc.)  
- Manual "Refresh Now" button using HTTP trigger function  

---

## 🏗️ Setup Instructions

### 1️⃣ Azure Function (Backend)

1. Go to **Azure Portal → Function App → Create**  
   - Runtime: Node.js or Python  
   - Hosting: Consumption Plan (Free)  
   - Storage: Your Storage Account  

2. Add **Timer Trigger Function** (runs hourly)  

3. Add your **Environment Variables** (Application Settings):
   - `NEWS_API_KEY` → Your News API Key from [NewsAPI.org](https://newsapi.org)  
   - `AZURE_STORAGE_CONNECTION_STRING` → Connection string from your Azure Storage  

4. Deploy the code from [`function-code/`](function-code/)

---

### 2️⃣ Azure Storage

1. Create a **container** in your storage account called `news-data`  
2. The Function will save JSON files in this container automatically  

---

### 3️⃣ Frontend Dashboard

1. Open [`frontend/`](frontend/) folder  
2. Update `script.js` with the URL to the **latest blob**  
3. Deploy `frontend/` to **Azure App Service** (Free Plan)  
   - Deployment options: GitHub, ZIP, or VS Code deployment  

---

### 4️⃣ Optional Enhancements

- Add **HTTP Trigger Function** for manual refresh  
- Store API Key in **Azure Key Vault**  
- Add **pagination** for large number of headlines  

---

## 📷 Screenshots

![Example Dashboard](images/example-screenshot.png)

---

## 📚 Learning Outcomes

- Azure Functions (serverless compute)  
- Blob Storage (storing JSON data)  
- App Service (hosting frontend)  
- Scheduling via Timer Trigger  
- Environment Variables / API Key management  

---

## 🔗 Quick Links

- [Function Code](function-code/)  
- [Frontend Dashboard](frontend/)  
- [Images](images/)  
- [Documentation / Architecture](docs/)
