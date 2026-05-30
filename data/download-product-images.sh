#!/bin/bash

# Download sample product images from Unsplash
# These are placeholder images - replace with actual product images

IMAGES_DIR="product-images"

echo "Creating images directory..."
mkdir -p "$IMAGES_DIR"

echo "Downloading sample product images..."

# Product 1 - Headphones
curl -L "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&q=80" -o "$IMAGES_DIR/prod-001.jpg"

# Product 2 - Smart Watch
curl -L "https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&q=80" -o "$IMAGES_DIR/prod-002.jpg"

echo ""
echo "Next step: Run upload-images-to-s3.sh to upload to S3"
