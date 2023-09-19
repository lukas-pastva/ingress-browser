FROM alpine:3.14

# Install required packages
RUN apk add --no-cache curl jq busybox-extras

# Copy our scripts and web content into the container
COPY source-code/list_ingress.sh /app/
COPY source-code/index.html /app/

# Mark our script as executable
RUN chmod +x /app/list_ingress.sh

# Expose port 80 for our web server
EXPOSE 80

# Command to run our application
CMD ["/bin/sh", "-c", "cd /app && httpd -f -p 80 -h /app && tail -f /dev/null"]
