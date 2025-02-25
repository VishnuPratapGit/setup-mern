#!/bin/bash

# Frontend Setup

npx create-vite@latest frontend --template react
cd frontend

# Install frontend dependencies

npm install @reduxjs/toolkit react-redux react-router-dom lucide-react
npm install tailwindcss @tailwindcss/vite

# Add the @tailwindcss/vite plugin to your Vite configuration.

cat > vite.config.js <<EOL
import react from "@vitejs/plugin-react";
import { defineConfig } from "vite";
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
    plugins: [react(), tailwindcss()],
});
EOL

# Add Tailwind directives to CSS

echo "@import 'tailwindcss';" > src/index.css
cd ..

# Backend Setup

mkdir backend
cd backend
npm init -y

# Install backend dependencies

npm install express cors dotenv mongoose
npm install -D nodemon

# Create environment file

echo "PORT=5000" > .env
echo "NODE_ENV=development" >> .env

# Create server file

cat > server.js <<EOL
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

dotenv.config();
const app = express();
const port = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(urlencoded({extended:true}));

// Routes
app.get('/api', (req, res) => {
res.json({ message: 'Hello from backend!' });
});

// Start server
app.listen(port, () => {
    console.log(\`Server running in \${process.env.NODE_ENV} mode on port \${port}\`);
});
EOL

# Update package.json for ES modules

npm pkg set type="module"
npm pkg set scripts.start="node server.js"
npm pkg set scripts.dev="nodemon server.js"

cd ..

echo "Setup complete!"
echo "Frontend: cd frontend && npm run dev"
echo "Backend: cd backend && npm run dev"
