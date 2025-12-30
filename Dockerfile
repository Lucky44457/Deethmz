FROM anasty17/mltb:latest

WORKDIR /app
RUN chmod 777 /app

# Create virtual environment
RUN python3 -m venv mltbenv

# Upgrade pip and setuptools in venv
RUN mltbenv/bin/pip install --upgrade pip setuptools wheel

# Copy dependencies and install in venv
COPY requirements.txt .
RUN mltbenv/bin/pip install --no-cache-dir -r requirements.txt

# Copy app code and healthcheck
COPY . .

# Start healthcheck and bot using venv
CMD ["bash", "-c", "source mltbenv/bin/activate && python3 healthcheck.py && bash start.sh"]
