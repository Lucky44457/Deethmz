FROM anasty17/mltb:latest

WORKDIR /app
RUN chmod 777 /app

# Optional: create virtual environment (skip if not needed)
RUN python3 -m venv mltbenv
# Upgrade pip, setuptools, wheel in venv
RUN mltbenv/bin/pip install --upgrade pip setuptools wheel

# Copy dependencies and install in venv
COPY requirements.txt .
RUN mltbenv/bin/pip install --no-cache-dir -r requirements.txt

# Copy all app code
COPY . .

# Start bot with fake healthcheck
# The healthcheck.py runs in background using a thread
CMD ["bash", "-c", "source mltbenv/bin/activate && python3 healthcheck.py & bash start.sh"]
