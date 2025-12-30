FROM anasty17/mltb:latest

WORKDIR /app
RUN chmod 777 /app

RUN python3 -m venv mltbenv

COPY requirements.txt .
RUN mltbenv/bin/pip install --no-cache-dir -r requirements.txt

COPY . .

# Start bot with healthcheck
CMD ["bash", "-c", "python3 healthcheck.py && bash start.sh"]
