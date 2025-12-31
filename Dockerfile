FROM anasty17/mltb:latest

WORKDIR /app
RUN chmod 777 /app

RUN python3 -m venv mltbenv
RUN mltbenv/bin/pip install --upgrade pip setuptools wheel

COPY requirements.txt .
RUN mltbenv/bin/pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
