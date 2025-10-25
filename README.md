# 🎥 1. Movie Recommendation Engine with Kubernetes for Auto-Scaling

## 🌟 Project Overview

This project implements a **Content-Based Movie Recommendation Engine** using Python, containerized with **Docker**, and deployed on **Kubernetes (K8s)** to demonstrate a production-ready, highly available, and **auto-scaling** solution.

The engine uses machine learning techniques like **Cosine Similarity** to recommend movies via a lightweight **Flask API**. The Kubernetes setup, particularly the **Horizontal Pod Autoscaler (HPA)**, ensures the application can automatically scale resources to handle increasing user load efficiently.

### Key Technologies

| Category | Tools / Libraries |
| :--- | :--- |
| **Backend/Core** | Python, **Flask**, **Gunicorn** (Production WSGI) |
| **Data Science** | **Pandas**, **NumPy**, **Scikit-learn** (for Cosine Similarity) |
| **Containerization** | **Docker** |
| **Orchestration** | **Kubernetes** (K8s), **HPA** |

---

## 🛠️ Setup & Local Deployment

Is section mein **dependency compatibility issues** (jo pehle aaye the) ke liye zaroori fixes shamil hain, aur ismein application ko local machine par run karne ke steps diye gaye hain.

### 1. Production-Ready `requirements.txt`

Yeh file libraries ki versions ko compatible rakhti hai taaki compilation errors se bacha ja sake:

**(File: `requirements.txt`)**
```text
Flask
gunicorn
pandas
numpy
scipy
scikit-learn
joblib
click==7.1.2
itsdangerous==1.1.0
Jinja2==2.11.2
MarkupSafe==1.1.1
Werkzeug==1.0.1
python-dateutil
pytz

---

### 2. Production-Ready Dockerfile (Fixes Included)
Is Dockerfile mein zaroori build tools (gcc, python3-dev) shamil kiye gaye hain (aur baad mein hata diye gaye hain) aur production ke liye Gunicorn ka upyog kiya gaya hai.

# Base Image: Official lightweight Python image
FROM python:3.9-slim

# Install system dependencies needed for compiling ML libraries (e.g., NumPy/Pandas)
# This step fixes the "ModuleNotFoundError: No module named 'distutils.msvccompiler'"
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Working Directory
WORKDIR /app

# Copy requirements and install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Cleanup: Remove build tools to keep the final image size small
RUN apt-get purge -y gcc python3-dev && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Copy all application code
COPY . /app

# Port
EXPOSE 5000

# Startup Command: Use Gunicorn for production-grade serving
# Assumes the Flask app instance is named 'app' in 'app.py'
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]

---

### 3. Build and Run Commands
# Image build karen
docker build -t kubernetes-test-app:latest .

# Container chalaayen
docker run -d -p 5000:5000 --name movie-recommender-app kubernetes-test-app:latest

---

### Application & Deployment Snapshots
Movie Recommender Interface
The simple web interface where users can select a movie and view recommendations.

Kubernetes Dashboard View
A view confirming the application's successful deployment and monitoring on the K8s cluster.

---

Project Roadmap (Mainmap)Yeh roadmap project ke alag-alag phases (development se le kar final auto-scaled deployment tak) ko darshata hai.PhaseDescriptionKey TasksStatusPhase 1: Local DevelopmentCore Recommendation Engine aur Flask API ka development.Data Cleaning, Cosine Similarity Model Creation, Flask API endpoints.✅ CompletedPhase 2: Containerization & OptimizationApplication ko Dockerize karna aur production ke liye tayyar karna.Dockerfile Creation, Dependency Fixes, Gunicorn Integration.✅ CompletedPhase 3: Kubernetes DeploymentBasic application ko K8s cluster par deploy karna.Deployment & Service YAML creation, Initial deployment test.⏳ In ProgressPhase 4: Auto-Scaling ImplementationHPA aur resource requests/limits set karke scalability add karna.HPA Configuration (CPU target), Resource Limit definition, Load Testing.⏳ In ProgressPhase 5: Refinement & MonitoringLive system ki performance ko monitor aur optimize karna.Prometheus/Grafana Monitoring, Log Aggregation.⬜ To Do

---

### Contribution & Contact
Contributions are welcome! Please feel free to fork the repository and submit a Pull Request.

Contact: osamashabih6960@gmail.com

Project Link: 1.-Movie-Recommendation-Engine--Using-Kubernetes-For-Auto-Scaling-Data-Processing



