FROM alpine:3.14

# Install required packages
RUN apk add --no-cache curl jq busybox-extras python3

# Copy our scripts and web content into the container
COPY source-code/list_ingress.sh /app/
COPY source-code/index.html /app/
COPY source-code/serve_json.py /app/

# Mark our script as executable
RUN chmod +x /app/list_ingress.sh
RUN chmod +x /app/serve_json.py

# Expose port 80 for our web server
EXPOSE 80

# Command to run our application
CMD ["/bin/sh", "-c", "/app/list_ingress.sh && cd /app && httpd -f -p 80 -h /app && python3 /app/serve_json.py & tail -f /dev/null"]
