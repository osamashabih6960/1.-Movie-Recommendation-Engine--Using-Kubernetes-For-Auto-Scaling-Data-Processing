# Use a lightweight base image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Copy dependencies first
COPY requirements.txt /app/
#RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY app.py /app/
COPY templates /app/templates
# COPY static /app/model  # ← Commented out if not needed

# Expose port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
