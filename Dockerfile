FROM mysterysd/wzmlx:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Copy dependencies and install
COPY requirements.txt .
RUN pip3 install --upgrade setuptools wheel
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy bot code
COPY . .

# healthcheck.py
from http.server import BaseHTTPRequestHandler, HTTPServer
import threading

class HealthHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b'OK')

threading.Thread(target=lambda: HTTPServer(('0.0.0.0', 8000), HealthHandler).serve_forever(), daemon=True).start()

# Start bot with healthcheck
CMD ["bash", "-c", "python3 healthcheck.py && bash start.sh"]
