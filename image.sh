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
    
    # Select one of 30 high-quality gradient presets
    gradient_type=$((1 + RANDOM % 30))
    
    case $gradient_type in
      1)
        # Deep Blue to Teal
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#0F2027"-"#2C5364" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      2)
        # Sunset Orange to Purple
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#FF512F"-"#DD2476" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      3)
        # Smooth Midnight Blue
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#141E30"-"#243B55" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      4)
        # Clean Emerald Green
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#134E5E"-"#71B280" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      5)
        # Subtle Violet
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#6A3093"-"#A044FF" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      6)
        # Deep Space Blue
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#000428"-"#004e92" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      7)
        # Royal Purple
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#4568DC"-"#B06AB3" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      8)
        # Elegant Crimson
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#3A1C71"-"#D76D77" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      9)
        # Ocean Blue
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#1A2980"-"#26D0CE" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      10)
        # Forest Green
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#134E5E"-"#71B280" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      11)
        # Modern Indigo
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#0B486B"-"#F56217" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      12)
        # Night Sky Purple
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#2B32B2"-"#1488CC" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      13)
        # Soft Coral
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#EE9CA7"-"#FFDDE1" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      14)
        # Deep Slate
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#304352"-"#485563" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      15)
        # Vibrant Raspberry
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#8E2DE2"-"#4A00E0" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      16)
        # Cinematic Blue
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#1E3C72"-"#2A5298" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      17)
        # Amber Sunrise
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#FF512F"-"#F09819" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      18)
        # Deep Aqua
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#1A2980"-"#26D0CE" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      19)
        # Muted Plum
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#614385"-"#516395" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      20)
        # Electric Violet
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#4776E6"-"#8E54E9" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      21)
        # Twilight Blue
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#0F2027"-"#203A43" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      22)
        # Soft Peach
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#FFC371"-"#FF5F6D" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      23)
        # Midnight Slate
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#283048"-"#859398" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      24)
        # Royal Blue
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#396afc"-"#2948ff" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      25)
        # Deep Mahogany
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#5A3F37"-"#2C7744" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      26)
        # Glacier Blue
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#00C9FF"-"#92FE9D" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      27)
        # Aurora Purple
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#3C1053"-"#AD5389" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      28)
        # Moody Cyan
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#003973"-"#E5E5BE" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      29)
        # Sleek Charcoal
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#232526"-"#414345" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
      30)
        # Deep Cobalt
        $IMAGEMAGICK_CMD -size 134x66 \
          gradient:"#000046"-"#1CB5E0" \
          -brightness-contrast 0x10 \
          "$USER_DIR/$base_name/MST_artwork.png"
        ;;
    esac
    
    echo "Created directory and artwork for: $base_name"
  fi
done

echo "Process completed!"
