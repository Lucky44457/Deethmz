# Use Python 3.10 base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Give permissions
RUN chmod 777 /app

# Create virtual environment
RUN python3 -m venv mltbenv

# Copy requirements
COPY requirements.txt .

# Upgrade pip and setuptools in the virtual environment
RUN mltbenv/bin/pip install --upgrade pip setuptools wheel

# Install requirements
RUN mltbenv/bin/pip install --no-cache-dir -r requirements.txt

# Ensure important packages exist (avoid pkg_resources / mega errors)
RUN mltbenv/bin/pip install setuptools==65.5.1 mega.py bs4

# Copy all source code
COPY . .

# Set default command
CMD ["bash", "start.sh"]
