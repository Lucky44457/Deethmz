FROM anasty17/mltb:latest

WORKDIR /app
RUN chmod 777 /app

COPY requirements.txt .

# 🔥 PEP 668 override (IMPORTANT)
RUN pip3 install --upgrade pip --break-system-packages \
    && pip3 install --no-cache-dir -r requirements.txt --break-system-packages

COPY . .

# fake healthcheck + bot start
CMD ["bash", "-c", "python3 healthcheck.py & bash start.sh"]
