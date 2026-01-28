#!/bin/bash
# Switching to node16h
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm use 16 > /dev/null

export NODE_OPTIONS="--no-experimental-fetch"

INPUT_DIR="input"
OUTPUT_DIR="output"

echo "Do you want to resize the images? (y/n)"
read -r DO_RESIZE

RESIZE_FLAG="" 

if [ "$DO_RESIZE" = "y" ] || [ "$DO_RESIZE" = "Y" ]; then
	echo "Note: This will use the 'triangle (bilinear)' method."
    echo "Please enter the Dimensions (Width Height, e.g., 1080 1920):"
    # input = first number -> W and the second -> H
    read -r W H
    
    RESIZE_FLAG="--resize {\"enabled\":true,\"width\":$W,\"height\":$H,\"method\":\"triangle\"}"
fi

# Check for input folder
if [ ! -d "$INPUT_DIR" ]; then
    echo "DumbAss there's no '$INPUT_DIR' folder."
    echo "Hold your horses, let me create one for you..."
    mkdir -p "$INPUT_DIR"
    echo "-- input folder creation Done --"
    echo "Add some images to process"
    exit 1
fi

mkdir -p "$OUTPUT_DIR"

echo ""
echo "Squoosh is processing images... Have a coffee!"
echo ""

# Run the processing
find "$INPUT_DIR" -maxdepth 1 -type f \( \
  -iname "*.png" -o \
  -iname "*.jpg" -o \
  -iname "*.jpeg" -o \
  -iname "*.webp" -o \
  -iname "*.bmp" -o \
  -iname "*.tiff" \
\) -exec squoosh-cli \
  $RESIZE_FLAG \
  --webp '{"quality":75, "effort":6}' \
  -d "$OUTPUT_DIR" {} +

echo ""
echo "My work here is done Done!"
# -> tahmidraven signs out <-
