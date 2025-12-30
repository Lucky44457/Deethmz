FROM anasty17/mltb:latest

WORKDIR /app

# Install system dependencies required for building some Python packages
RUN apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies globally
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

# Copy bot code and healthcheck
COPY . .

# Start fake healthcheck in background and then bot
CMD ["bash", "-c", "python3 healthcheck.py & bash start.sh"]
