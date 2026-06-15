# Use the official Node.js 18 image as base
FROM node:18-bullseye-slim

# Create app directory
WORKDIR /usr/src/app

# Install system dependencies (ffmpeg is required for music bots)
RUN apt-get update && \
    apt-get install -y ffmpeg python3 build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Set environment variables (should be provided at runtime via docker run or docker-compose)
ENV NODE_ENV=production

# Start the bot
CMD [ "npm", "start" ]
