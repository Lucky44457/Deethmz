FROM anasty17/mltb:latest

WORKDIR /app
RUN chmod 777 /app

# Use virtual environment
RUN python3 -m venv mltbenv

# Install dependencies inside the venv
COPY requirements.txt .
RUN ./mltbenv/bin/pip install --upgrade pip setuptools wheel
RUN ./mltbenv/bin/pip install --no-cache-dir -r requirements.txt

# Copy bot code
COPY . .

# Ensure the venv is used when starting
CMD ["./mltbenv/bin/python3", "start.py"]
