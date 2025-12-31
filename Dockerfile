# Base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    aria2 \
    qbittorrent-nox \
    ffmpeg \
    git \
    curl \
    wget \
    build-essential \
    python3-dev \
    libffi-dev \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Create Python virtual environment
RUN python3 -m venv mltbenv

# Upgrade pip, setuptools, wheel inside venv
RUN mltbenv/bin/pip install --upgrade pip setuptools wheel

# Install Python dependencies inside venv
RUN mltbenv/bin/pip install --no-cache-dir -r requirements.txt

# Install qbittorrent-api from GitHub if needed
RUN mltbenv/bin/pip install git+https://github.com/qbittorrent/qbittorrent-api.git

# Copy bot files
COPY . .

# Make scripts executable (if any)
RUN chmod +x ./aria.sh

# Expose Aria2 RPC port
EXPOSE 6800

# Set default environment variables
ENV PATH="/app/mltbenv/bin:$PATH"
ENV PYTHONUNBUFFERED=1

# Start command
CMD ["bash", "start.sh"]
