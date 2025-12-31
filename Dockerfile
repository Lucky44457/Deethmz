FROM python:3.10-slim

WORKDIR /app

RUN chmod 777 /app

# Install system packages including qbittorrent-nox
RUN apt-get update && apt-get install -y \
    qbittorrent-nox \
    curl \
    ffmpeg \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python3 -m venv mltbenv

# Copy requirements
COPY requirements.txt .

# Upgrade pip and setuptools
RUN mltbenv/bin/pip install --upgrade pip setuptools wheel

# Install Python packages
RUN mltbenv/bin/pip install --no-cache-dir -r requirements.txt

# Ensure important packages exist
RUN mltbenv/bin/pip install setuptools==65.5.1 mega.py bs4

# Copy all source code
COPY . .

CMD ["bash", "start.sh"]
