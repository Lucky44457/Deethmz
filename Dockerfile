# Use official Python base image
FROM python:3.13-slim

# Set working directory
WORKDIR /usr/src/app

# --- Install system dependencies ---
RUN apt-get update && apt-get install -y \
    git \
    aria2 \
    qbittorrent-nox \
    curl \
    wget \
    build-essential \
    libmagic1 \
    && rm -rf /var/lib/apt/lists/*

# --- Create virtual environment ---
RUN python -m venv /usr/src/app/mltbenv
ENV PATH="/usr/src/app/mltbenv/bin:$PATH"

# --- Upgrade pip and install essential Python packages ---
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

# --- Install qbittorrent-api from PyPI (avoid GitHub cloning issue) ---
RUN pip install --upgrade qbittorrent-api

# --- Copy bot files ---
COPY . .

# --- Environment variables (optional, adjust if needed) ---
ENV PORT=6800
ENV BASE_URL=""

# --- Expose ports ---
EXPOSE 6800 6881 6881/udp

# --- Start bot ---
CMD ["bash", "start.sh"]
