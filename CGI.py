#!/usr/bin/env python

# Provides foundation for creating HTTP request handler. Defines methods for creating request types and getting 
#responses. HTTPServer listens for incoming requests on a specific port. Handles incoming requests and sends responses.
from http.server import BaseHTTPRequestHandler, HTTPServer
import subprocess

# Defines custom handler class to work with the HTTP server to process GET requests for data. After recieving the
#GET request, the initial response is a HTML page with status 200.
class F1Handler(BaseHTTPRequestHandler):
  def do_GET(self):
    self.send_response(200)
    self.send_header('Content-type', 'text/html')
    self.end_headers()
    

    # Get user input from URL parameters. Extracts start year from URL path and sets default if extraction fails.
   try:
    start_year = self.path.split("=")[1].split("&")[0].split("=")[1]
  except IndexError:
    start_year = 2019 
    end_year = self.path.split("=")[2]

    # Creates HTML page with welcome message and menu. Contains data range, categories using hyperlinks, and formats 
    #page with title.
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
    # Sends generated HTML content to web browser
    self.wfile.write(html_content.encode())

   # Extend script's functionality to handle data submission from other applications that use 
   #the POST method (sending data in the request body of the HTTP request).
  def do_POST(self):  
    pass

# Creates a simple HTTP server that listens for requests on port 8000 and uses the handler class for those requests.
def main():
  port = 8000 #standard port for HTTP web traffic is 80, this port is for testing purposes to avoid web traffic  
  httpd = HTTPServer(('', port), F1Handler)
  print(f"Serving on port {port}")
  httpd.serve_forever()

# Runs main function only when script is directly executed and not imported as a module.
if __name__ == '__main__':
  main()
