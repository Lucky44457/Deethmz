FROM anasty17/mltb:latest

WORKDIR /app
RUN chmod 777 /app

# Create virtual environment
RUN python3 -m venv mltbenv

# Install dependencies
COPY requirements.txt .
RUN ./mltbenv/bin/pip install --upgrade pip setuptools wheel
RUN ./mltbenv/bin/pip install --no-cache-dir -r requirements.txt

# Copy bot code
COPY . .

# Make start.sh executable
RUN chmod +x start.sh

# Start bot via start.sh (bash)
CMD ["bash", "start.sh"]
