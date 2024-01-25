FROM node:14

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Copy app source code
COPY ./source-code/ .

# Expose port 8080
EXPOSE 8080

# Command to run our application
CMD [ "npm", "start" ]
