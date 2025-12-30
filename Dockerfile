# Use Python 3.10 for compatibility
FROM python:3.10-slim

# Set working directory
WORKDIR /app
RUN chmod 777 /app

# Create virtual environment
RUN python3 -m venv mltbenv

# Upgrade pip, setuptools, wheel in venv
RUN mltbenv/bin/pip install --upgrade pip setuptools wheel

# Copy requirements and install in venv
COPY requirements.txt .
RUN mltbenv/bin/pip install --no-cache-dir -r requirements.txt

# Copy the bot code and healthcheck
COPY . .

# Start fake healthcheck and bot using venv
CMD ["bash", "-c", "source mltbenv/bin/activate && python3 healthcheck.py && bash start.sh"]
