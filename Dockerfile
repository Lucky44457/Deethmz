# --- Base Image ---
FROM python:3.13-slim

# --- Set working directory ---
WORKDIR /usr/src/app

# --- Install system dependencies ---
RUN apt-get update && apt-get install -y \
    git \
    aria2 \
    qbittorrent-nox \
    curl \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# --- Copy requirements ---
COPY requirements.txt .

# --- Setup virtual environment ---
RUN python -m venv mltbenv
RUN mltbenv/bin/pip install --upgrade pip setuptools wheel

# --- Install Python dependencies ---
RUN mltbenv/bin/pip install -r requirements.txt

# --- Install qbittorrent-api from PyPI (avoid GitHub clone issue) ---
RUN mltbenv/bin/pip install qbittorrent-api==2025.11.1

# --- Copy bot files ---
COPY . .

# --- Make scripts executable ---
RUN chmod +x start.sh
RUN chmod +x aria.sh

# --- Set environment variables for ports (changeable) ---
ENV ARIA2_PORT=6800
ENV QBITTORRENT_PORT=8080

# --- Expose ports ---
EXPOSE ${ARIA2_PORT}
EXPOSE ${QBITTORRENT_PORT}

# --- Start command ---
CMD ["bash", "start.sh"]
