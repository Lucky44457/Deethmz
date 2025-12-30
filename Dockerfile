FROM anasty17/mltb:latest

WORKDIR /app
RUN chmod 777 /app

# Install all dependencies globally
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your bot code and healthcheck
COPY . .

# Start fake healthcheck in background and then start bot
CMD ["bash", "-c", "python3 healthcheck.py & bash start.sh"]
