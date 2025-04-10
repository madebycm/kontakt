#!/bin/bash

# Script to find missing libraries and create artwork
# This script compares XML files in the source directory with directories in the user directory
# For each missing library, it creates a directory and generates a professional gradient artwork
# Added marker file and reverse mode to undo changes

# Define the paths
SOURCE_DIR="/Library/Application Support/Native Instruments/Service Center/"
USER_DIR="/Users/Shared/NI Resources/image/"
MARKER_FILE="cm_img_script.txt"

# Check for reverse mode
REVERSE_MODE=false
if [ "$1" == "-reverse" ]; then
  REVERSE_MODE=true
  echo "Running in REVERSE mode - will delete directories created by this script"
fi

# Set up ImageMagick command based on version
if command -v magick &> /dev/null; then
  IMAGEMAGICK_CMD="magick"
elif command -v convert &> /dev/null; then
  IMAGEMAGICK_CMD="convert"
else
  echo "ImageMagick is not installed. Please install it using: brew install imagemagick"
  exit 1
fi

# Function to remove directories created by this script
remove_created_directories() {
  echo "Searching for directories to remove..."
  
  # Find all marker files and get their parent directories
  find "$USER_DIR" -name "$MARKER_FILE" | while read -r marker; do
    dir_to_remove=$(dirname "$marker")
    dir_name=$(basename "$dir_to_remove")
    
    echo "Removing: $dir_name"
    rm -rf "$dir_to_remove"
  done
  
  echo "Cleanup completed!"
  exit 0
}

# If in reverse mode, remove directories and exit
if [ "$REVERSE_MODE" = true ]; then
  remove_created_directories
fi

echo "Starting to check for missing libraries..."

# Process each file in the source directory
find "$SOURCE_DIR" -name "*.xml" -type f | while IFS= read -r source_file; do
  # Extract the base name and convert to lowercase
  base_name=$(basename "$source_file" .xml | tr '[:upper:]' '[:lower:]')
  
  # Check if this item exists in the user directory
  if [ ! -d "$USER_DIR/$base_name" ]; then
    echo "Missing: $base_name"
    
    # Create the directory
    mkdir -p "$USER_DIR/$base_name"
    
    # Create marker file to indicate this directory was created by the script
    echo "Created by findMissingLibraries.sh on $(date)" > "$USER_DIR/$base_name/$MARKER_FILE"
    
    # Select a high-quality gradient preset
    # 1: Green to Black (like example)
    # 2: Blue to Purple
    # 3: Orange to Red
    # 4: Teal to Blue
    gradient_type=$((1 + RANDOM % 4))
    
    case $gradient_type in
      1)
        # Green to Black like example
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#00FF00"-"#000000" \
          -brightness-contrast 0x20 \
          -blur 0x0.5 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      2)
        # Blue to Purple
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#0055FF"-"#5500FF" \
          -brightness-contrast 0x20 \
          -blur 0x0.5 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      3)
        # Orange to Red
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#FF9500"-"#FF0000" \
          -brightness-contrast 0x20 \
          -blur 0x0.5 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      4)
        # Teal to Blue
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#00DDDD"-"#0000AA" \
          -brightness-contrast 0x20 \
          -blur 0x0.5 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
    esac
    
    # Determine font size based on text length to prevent cutoff
    text_length=${#base_name}
    font_size=15
    
    if [ "$text_length" -gt 20 ] && [ "$text_length" -le 30 ]; then
      font_size=12
    elif [ "$text_length" -gt 30 ]; then
      font_size=10
      
      # For very long text, split into two lines
      if [ "$text_length" -gt 40 ]; then
        # Find a space near the middle to split
        middle=$((text_length / 2))
        
        # Look for a space near the middle
        for i in $(seq $middle 1 $text_length); do
          if [ "${base_name:$i:1}" = " " ]; then
            first_part="${base_name:0:$i}"
            second_part="${base_name:$((i+1))}"
            
            # Add text with line break
            $IMAGEMAGICK_CMD "$USER_DIR/$base_name/MST_artwork.png" \
              -gravity center \
              -font "Arial-Bold" \
              -pointsize "$font_size" \
              -fill black \
              -annotate +0-3 "$first_part" \
              -annotate +0+8 "$second_part" \
              -blur 0x1 \
              "$USER_DIR/$base_name/MST_artwork.png"
            
            $IMAGEMAGICK_CMD "$USER_DIR/$base_name/MST_artwork.png" \
              -gravity center \
              -font "Arial-Bold" \
              -pointsize "$font_size" \
              -fill "#C0FFC0" \
              -annotate +0-4 "$first_part" \
              -annotate +0+7 "$second_part" \
              "$USER_DIR/$base_name/MST_artwork.png"
            
            break
          fi
        done
        
        echo "Created directory and artwork for: $base_name (with wrapped text)"
        continue
      fi
    fi
    
    # Add text overlay with glow effect (for text that doesn't need splitting)
    # First create a slightly blurred black text for a shadow/glow effect
    $IMAGEMAGICK_CMD "$USER_DIR/$base_name/MST_artwork.png" \
      -gravity center \
      -font "Arial-Bold" \
      -pointsize "$font_size" \
      -fill black \
      -annotate +0+1 "$base_name" \
      -blur 0x1 \
      "$USER_DIR/$base_name/MST_artwork.png"
    
    # Then overlay a sharper text on top
    $IMAGEMAGICK_CMD "$USER_DIR/$base_name/MST_artwork.png" \
      -gravity center \
      -font "Arial-Bold" \
      -pointsize "$font_size" \
      -fill "#C0FFC0" \
      -annotate +0+0 "$base_name" \
      "$USER_DIR/$base_name/MST_artwork.png"
    
    echo "Created directory and artwork for: $base_name"
  fi
done

echo "Process completed!"
echo "To undo these changes, run this script with the -reverse parameter"
