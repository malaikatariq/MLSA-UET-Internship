# Frontend

This folder contains the **HTML, CSS, and JavaScript** code for the news dashboard.

---

## 🛠️ Files

- `index.html` → Main dashboard HTML  
- `style.css` → Optional CSS styling  
- `script.js` → JavaScript to fetch JSON from Blob Storage and display news

---

## ⚡ How It Works

1. The dashboard fetches the **latest JSON blob** from Azure Storage  
2. Displays **news title, source, URL, and publish time**  
3. Category filter available (e.g., Business, Tech, Sports)  
4. "Refresh" button triggers re-fetch of data

---

## 🏗️ Deployment

1. Deploy this folder to **Azure App Service** (Free Plan)  
2. Update `script.js` with your **Blob Storage URL**  
3. Open the App Service URL → See your live news dashboard
