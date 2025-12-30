# healthcheck.py
from http.server import BaseHTTPRequestHandler, HTTPServer
import threading

class HealthHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b'OK')

threading.Thread(target=lambda: HTTPServer(('0.0.0.0', 8000), HealthHandler).serve_forever(), daemon=True).start()
