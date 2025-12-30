FROM anasty17/mltb:latest

WORKDIR /app

# Install system dependencies needed for some Python packages
RUN apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy dependencies and install globally
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

# Copy your bot code
COPY . .

# Start fake healthcheck in background and then bot
CMD ["bash", "-c", "python3 healthcheck.py & bash start.sh"]
