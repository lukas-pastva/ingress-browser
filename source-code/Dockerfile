# Use a Node.js base image
FROM node:14

# Create app directory in the container
WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY source-code/package*.json ./

# Install dependencies in the container
RUN npm install express

# Copy the Node.js server script and other necessary files into the container
COPY source-code/server.js ./
COPY source-code/package.json ./
COPY source-code/list_ingress.sh ./list_ingress.sh
COPY source-code/public/ ./public/

RUN chmod +x ./list_ingress.sh

EXPOSE 8080

CMD [ "npm", "start" ]
