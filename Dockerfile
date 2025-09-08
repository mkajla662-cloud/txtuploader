# Use lightweight Python image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .

# Upgrade pip and install dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy all app files
COPY . .

# Ensure Python output is unbuffered
ENV PYTHONUNBUFFERED=1

# Run the bot
CMD ["python", "bot.py"]