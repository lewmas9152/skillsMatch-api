# Use Node.js LTS Alpine as base
FROM node:20-alpine

# Install dependencies required for bcrypt
RUN apk add --no-cache python3 make g++

# Create app directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies with rebuild of bcrypt
RUN npm ci --build-from-source

# Copy source code
COPY . .

# Build TypeScript
RUN npm run build

# Expose the port your app runs on
EXPOSE 80

# Start the server
CMD ["node", "dist/index.js"]