FROM anasty17/mltb:latest

WORKDIR /app
RUN chmod 777 /app

RUN python3 -m venv mltbenv

COPY requirements.txt .
RUN mltbenv/bin/pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "-c", "source mltbenv/bin/activate && python3 healthcheck.py & source mltbenv/bin/activate && bash start.sh"]
