# Function Code

This folder contains the **Azure Function App** code that fetches news headlines from the free **News API** and stores them in **Azure Blob Storage**.

---

## 🛠️ Files

- `index.js` → Main function code (Timer Trigger)  
- `package.json` → Node.js dependencies  
- `.env.example` → Template for environment variables

---

## ⚡ Environment Variables

Make sure to add these **Application Settings** in your Azure Function App:

- `NEWS_API_KEY` → Your News API key from [NewsAPI.org](https://newsapi.org)  
- `AZURE_STORAGE_CONNECTION_STRING` → Connection string from your Azure Storage Account  

---

## 🏗️ How It Works

1. Timer Trigger runs every hour  
2. Fetches latest news JSON from News API  
3. Stores JSON in Blob Storage in path:  
