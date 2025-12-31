FROM anasty17/mltb:latest

WORKDIR /app
RUN chmod 777 /app

COPY requirements.txt .
RUN pip3 install --upgrade pip \
    && pip3 install --no-cache-dir -r requirements.txt

COPY . .

# healthcheck.py background me + bot start
CMD ["bash", "-c", "python3 healthcheck.py & bash start.sh"]
