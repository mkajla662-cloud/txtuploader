# Base Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y ffmpeg jq python3-dev \
    libmediainfo-dev zlib1g-dev aria2 && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements.txt
COPY requirements.txt .

# Upgrade pip and install Python dependencies
RUN pip install --no-cache-dir --upgrade pip setuptools wheel \
    && pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY . .

# Set environment variables
ENV COOKIES_FILE_PATH="youtube_cookies.txt"

# Run both gunicorn (for app) and main script
CMD ["bash", "-c", "gunicorn app:app & python3 modules/main.py"]