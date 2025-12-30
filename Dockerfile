FROM python:3.10-slim

WORKDIR /app
RUN chmod 777 /app

# Create virtual environment
RUN python3 -m venv mltbenv

# Upgrade pip, setuptools, wheel
RUN mltbenv/bin/pip install --upgrade pip setuptools wheel

# Copy dependencies and install
COPY requirements.txt .
RUN mltbenv/bin/pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Start fake healthcheck and bot
CMD ["bash", "-c", "source mltbenv/bin/activate && python3 healthcheck.py && bash start.sh"]
