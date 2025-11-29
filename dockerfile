# Use the official Node.js 18 image
FROM node:18-slim

# Create app directory
WORKDIR /usr/src/app

# Install system dependencies (if needed)
# RUN apt-get update && apt-get install -y --no-install-recommends <packages>

# Copy package files
COPY package*.json ./

# Install app dependencies
RUN npm install --only=production

# Bundle app source
COPY . .

# Environment variables
ENV PORT=8080
ENV NODE_ENV=production

# Expose the port the app runs on
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/api/health || exit 1

# Start the application
CMD [ "node", "index.js" ]