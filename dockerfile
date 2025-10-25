# Base Image: Official lightweight Python image ka upyog karen
FROM python:3.9-slim

# Working Directory: Container ke andar /app folder mein chale jayenge
WORKDIR /app

# Dependencies: requirements.txt file ko copy karen aur saari libraries install karen
# "--no-cache-dir" se installation tez ho jaati hai
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Application Code: Baaki saara code (app.py, model files, datasets, etc.) copy karen
COPY . /app

# Port: Container ka port 5000 expose karen (jaisa ki aapke 'docker run' command mein tha)
EXPOSE 5000

# Startup Command: Application shuru karne ka command (assuming app.py is the main file)
# Agar aap Gunicorn ya koi aur WSGI server use kar rahe hain, toh command badal jayega
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]