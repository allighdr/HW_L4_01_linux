#!/usr/bin/env python3

from http.server import HTTPServer, SimpleHTTPRequestHandler
import os

PORT = 8080

os.chdir(os.path.dirname(os.path.abspath(__file__)))

handler = SimpleHTTPRequestHandler

httpd = HTTPServer(("0.0.0.0", PORT), handler)

print(f"Server running on http://localhost:{PORT}")
print("Press Ctrl+C to stop the server")

try:
    httpd.serve_forever()
except KeyboardInterrupt:
    print("\nServer stopped.")
    httpd.shutdown()
