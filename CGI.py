#!/usr/bin/env python

from http.server import BaseHTTPRequestHandler, HTTPServer
import subprocess

class F1Handler(BaseHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header('Content-type', 'text/html')
    self.end_headers()

    # Get user input from URL parameters (optional)
    # You can modify this section to handle form data if needed
    start_year = self.path.split("=")[1].split("&")[0]  # Assuming format like "/?startYear=2020&endYear=2023"
    end_year = self.path.split("=")[2]

    # Welcome message and menu
    html_content = f"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Formula 1 Data Aggregator</title>
    </head>
    <body>
        <h1>Welcome to the Formula 1 Data Aggregator!</h1>
        <p>Looking at the year range {start_year} to {end_year}, I can provide the following data:</p>
        <ul>
            <li><a href="?menu=1">Constructor's Championship Table (1)</a></li>
            <li><a href="?menu=2">World Driver's Championship Table (2)</a></li>
            <li><a href="?menu=3">Driver List (3)</a></li>
            <li><a href="?menu=4">Constructor List (4)</a></li>
            <li><a href="?menu=5">General Info about Formula 1 (5)</a></li>
        </ul>
    </body>
    </html>
    """
    self.wfile.write(html_content.encode())

  def do_POST(self):  # Handle form data if needed (optional)
    pass

def main():
  port = 8000  # Change this if needed
  httpd = HTTPServer(('', port), Formula1DataHandler)
  print(f"Serving on port {port}")
  httpd.serve_forever()

if __name__ == '__main__':
  main()
