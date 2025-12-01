FROM node:20-alpine

RUN apk --no-cache add curl

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --include=dev

# Copy the rest of the application
COPY . .

# Expose the Vite dev server port
EXPOSE 5173

# Start the development server
CMD ["npm", "run", "dev", "--", "--hostname", "0.0.0.0", "--port", "5173"]
