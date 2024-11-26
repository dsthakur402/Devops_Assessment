# **Containerizing React-Express-MongoDB Application**

This project demonstrates the process of containerizing a full-stack application consisting of a React frontend, an Express backend, and a MongoDB database using Docker. The setup simplifies deployment and ensures portability.

---

## **Setup Instructions**

### **Prerequisites**
- Docker installed on your system.
- A Docker Hub account (to push the images).

### **Steps to Run the Application**
1. Clone the repository:
   ```bash
   git clone https://github.com/dsthakur402/Devops_Assessment
   cd Devops-Assessment
   ```
### **Verify that the containers are running:**
```bash
docker ps
```

### **Access the application:**
- **Frontend**: [http://localhost:3001](http://localhost:3001)  
- **Backend APIs**: [http://localhost:5000](http://localhost:5000)

## **API Endpoints**

### **GET /api/users**
- Fetches all users from the database.

### **POST /api/users**
- Creates a new user.  
- **Request Body**:
  ```json
  {
    "name": "John Doe",
    "email": "john@example.com"
  }
  ```
## **Download Project Documentation**

You can download the project documentation as a PDF by clicking the link below:
[Containerizing React-Express-MongoDB Application.pdf](https://github.com/user-attachments/files/17917100/Containerizing.React-Express-MongoDB.Application.pdf)

## **Author Divyanshu Singh**  
- **GitHub**: [dsthakur402](https://github.com/dsthakur402)  
- **LinkedIn**: [Divyanshu Singh](https://www.linkedin.com/in/dsthakur402)

