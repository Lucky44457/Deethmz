FROM anasty17/mltb:latest

WORKDIR /app
RUN chmod 777 /app

COPY requirements.txt .

# ✅ ONLY install requirements (NO pip upgrade)
RUN pip3 install --no-cache-dir -r requirements.txt --break-system-packages

COPY . .

# fake healthcheck + bot start
CMD ["bash", "-c", "python3 healthcheck.py & bash start.sh"]
