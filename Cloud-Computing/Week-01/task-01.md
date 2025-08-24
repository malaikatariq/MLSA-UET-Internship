## 📄 Resume (HTML & CSS)

Here is my resume built using **HTML & CSS**:

- [View Resume (index.html)](https://github.com/malaikatariq/resume-webapp/blob/main/index.html)   

Deployed Version: [Live on Azure Static Web App](https://happy-tree-02fe32610.2.azurestaticapps.net/) 


# 🌐 Cloud Computing Internship – Task 01  

### 📌 Objective  
Deploy a personal **Resume Website** as a Static Web App using **Microsoft Azure**.  

---

## 🔹 Step 1: Create a Resource Group  
1. Log in to the [Azure Portal](https://portal.azure.com/).  
2. In the search bar, type **Resource groups** and select it.  
3. Click **+ Create**.  
4. Fill in the details:  
   - **Subscription**: Free student subscription.  
   - **Resource group name**: `MLSA-Cloud_Intern`.  
   - **Region**: Choose nearest region (e.g., East US).  
5. Click **Review + Create** → **Create**.  

✅ Resource Group created successfully!  
![Resource Group](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cloud-Computing/Week-01/assets/Resource_Group.png)

---

## 🔹 Step 2: Create a Static Web App  
1. In the search bar, type **Static Web Apps**.  
2. Click **+ Create**.  
3. Fill in details:  
   - **Subscription**: Free subscription.  
   - **Resource group**: `MLSA-Cloud_Intern`.  
   - **Name**: `resume-webapp`.  
   - **Hosting plan**: **Free (F1)**.  
   - **Region**: South India & Central US.
   -  Connect with **GitHub Account**
   -  Select the Repo and Branch 
4. **Deployment details**:  
   - Select **GitHub**.   
5. Click **Review + Create** → **Create**.  

✅ Static Web App created!
![Select Static WebAPP Service](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cloud-Computing/Week-01/assets/App_Service.png)
![Create of Static WebApp](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cloud-Computing/Week-01/assets/Static_WebApp.png)
![Deployment of WebApp](https://github.com/malaikatariq/MLSA-UET-Internship/blob/main/Cloud-Computing/Week-01/assets/Deploy_WebApp.png)

---

## 🔹 Step 3: Prepare Resume Files  
- Ensure your resume files are ready:
  - `index.html` → main page

- **Why I add a `package.json` file:**  
  Azure Static Web Apps uses a build system called **Oryx** to detect and build applications.  
  Even for a simple static HTML site, Oryx expects a **build script** in your `package.json`. Without it, deployment may fail with this error:
**`Error: Could not find either 'build' or 'build:azure' node under 'scripts' in package.json.`**
  
- **Solution:** Add a `package.json` file in the project root with a minimal build script:

```json
{
  "name": "my-static-app",
  "version": "1.0.0",
  "scripts": {
    "build": "echo 'No build required for static HTML'"
  }
}



---

## 🔹 Step 4: Run Your Web App  
1. Once deployment is complete, Azure generates a public URL:  


### 🎯 Outcome  
- Learned about cloud basics, deployment & service models.  
- Gained hands-on experience with **Azure Static Web Apps**.  
- Successfully deployed my **Resume website** on Azure.  

