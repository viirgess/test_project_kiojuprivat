#!/bin/bash

set -e

echo "Starting development servers..."

if [ ! -d "backend/node_modules" ]; then
    echo "Installing backend dependencies..."
    (cd backend && npm install)
fi

echo "Starting proxy server..."
(cd backend && npm start) &
BACKEND_PID=$!

sleep 2

echo "Starting Flutter web..."
flutter run -d chrome

kill $BACKEND_PID 2>/dev/null
echo "Stopped"
