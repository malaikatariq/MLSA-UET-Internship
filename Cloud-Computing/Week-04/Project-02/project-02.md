# **Image to Text Extraction Web App using Azure Computer Vision**

## **Project Overview**

This project demonstrates a **Static Web Application** that allows users to upload an image and extract text from it using **Azure Computer Vision API**. The extracted text is displayed on the web page in real-time.

The solution leverages **Azure Function App** for backend processing and **Azure Static Web Apps** for hosting the frontend.

---

## **Features**

* Upload an image directly from the browser.
* Extract text from images using **Azure Computer Vision**.
* Display extracted text dynamically on the web page.
* Fully hosted on **Azure Static Web Apps**.
* Minimal configuration required for deployment.

---

## **Architecture**

```text
User (Browser)
     │
     ▼
Frontend (HTML + JS)  ──>  Azure Function App ──>  Azure Computer Vision API
     │                                          │
     ▼                                          ▼
Display extracted text                     Text extracted from image
```

**Components:**

1. **Frontend:** HTML, CSS, JavaScript
2. **Azure Function App:** Receives image, calls Computer Vision API, returns extracted text.
3. **Azure Computer Vision API:** Performs OCR and returns extracted text in JSON.

---

## **Technologies Used**

| Technology            | Purpose                                    |
| --------------------- | ------------------------------------------ |
| HTML, CSS, JavaScript | Frontend interface and logic               |
| Azure Static Web Apps | Hosting frontend                           |
| Azure Function App    | Backend serverless function                |
| Azure Computer Vision | OCR and text extraction                    |
| GitHub                | Code version control and CI/CD integration |

---

## **Setup and Deployment**

### **1. Azure Computer Vision**

1. Create **Azure Cognitive Services Resource**.
2. Note down:

   * **Endpoint URL**
   * **API Key**

### **2. Azure Function App**

1. Create a **Function App** in Azure.
2. Add a **Function** to handle POST requests.
3. Implement the function to call the Computer Vision API:

```javascript
const axios = require('axios');

module.exports = async function (context, req) {
    const imageUrl = req.body.imageUrl;
    const response = await axios.post(
        'https://<your-computer-vision-endpoint>/vision/v3.2/ocr',
        { url: imageUrl },
        { headers: { 'Ocp-Apim-Subscription-Key': '<your-key>' } }
    );
    context.res = {
        status: 200,
        body: response.data
    };
};
```

4. Copy the **Function URL** with code parameter.

---

### **3. Frontend (HTML + JS)**

* Upload image using `<input type="file">`.
* Convert image to FormData.
* Call Azure Function URL via `fetch`.
* Display extracted text dynamically.

```javascript
const functionUrl = "https://<your-function-app>.azurewebsites.net/api/<function-name>?code=<function-key>";

async function extractText(file) {
    const formData = new FormData();
    formData.append("image", file);

    const response = await fetch(functionUrl, {
        method: "POST",
        body: formData
    });

    const data = await response.json();
    document.getElementById("result").innerText = data.text || "No text detected";
}
```

**HTML Example:**

```html
<input type="file" id="imageInput" />
<button onclick="uploadImage()">Extract Text</button>
<div id="result"></div>

<script>
function uploadImage() {
    const file = document.getElementById("imageInput").files[0];
    if (file) extractText(file);
}
</script>
```

---

### **4. Hosting with Azure Static Web Apps**

1. Create a **Static Web App** in the Azure Portal.
2. Link it to your **GitHub repository** containing frontend code.
3. Set the build configuration:

   * **App location:** `/`
   * **Output location:** `/`
4. Push your frontend code to GitHub.
5. Azure automatically deploys the web app.
6. Access the live URL provided by Azure Static Web Apps. Users can now upload images and see extracted text in real-time.

---


## **Links**  
![Repo Url](https://github.com/malaikatariq/image-analyzer)
![Web App Url](https://yellow-mushroom-0f3e5fb03.1.azurestaticapps.net/)


---

## **Usage Instructions**

1. Open the web app in a browser.
2. Upload an image containing text.
3. Wait for the extracted text to appear below the upload button.

---
## Screenshots:

![Computer Vision](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cloud-Computing/Week-04/Project-02/assets/Computer%20Vision.png)
![Function App](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cloud-Computing/Week-04/Project-02/assets/Function%20App.png)
![HTTP Function](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cloud-Computing/Week-04/Project-02/assets/HTTP%20Function.png)
![Web UI](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cloud-Computing/Week-04/Project-02/assets/Web%20UI.png)

---
