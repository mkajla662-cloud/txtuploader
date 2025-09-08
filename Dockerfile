# ===== Use official Python image =====
FROM python:3.11-slim

# ===== Set environment variables =====
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# ===== Install system dependencies =====
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        libffi-dev \
        ffmpeg \
        git \
        curl \
        wget && \
    rm -rf /var/lib/apt/lists/*

# ===== Set working directory =====
WORKDIR /app

# ===== Upgrade pip =====
RUN pip install --upgrade pip

# ===== Copy project files =====
COPY . /app

# ===== Install Python dependencies =====
RUN pip install --no-cache-dir --trusted-host pypi.org --trusted-host files.pythonhosted.org -r requirements.txt

# ===== Expose port (if using webhooks) =====
EXPOSE 8080

# ===== Run your bot =====
CMD ["python", "bot.py"]