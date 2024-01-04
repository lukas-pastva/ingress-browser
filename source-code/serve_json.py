# serve_json.py
import http.server
import socketserver
import os

class MyHttpRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/ingresses.json':
            self.path = '/tmp/ingresses.json'
        return http.server.SimpleHTTPRequestHandler.do_GET(self)

handler_object = MyHttpRequestHandler
PORT = 8080
my_server = socketserver.TCPServer(("", PORT), handler_object)

# Start the server
print("Serving /tmp/ingresses.json at port", PORT)
my_server.serve_forever()
