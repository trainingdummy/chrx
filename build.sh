#!/bin/bash
#
# build.sh - Creates the chrx distribution package
#
# This script packages chrx for distribution via the one-command install:
#   curl [url]/dist.tar.gz | sudo tar xzfC - /usr/local && chrx
#

set -e

DIST_DIR="chrx-dist"
OUTPUT_FILE="dist.tar.gz"

# Check if chrx-install script exists
if [ ! -f "chrx-install" ]; then
    echo -e "${RED}Error: chrx-install script not found!${NC}"
    echo "Make sure you're running this from the repository root."
    exit 1
fi

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Building chrx distribution package...${NC}\n"

# Check if chrx-install script exists
if [ ! -f "chrx-install" ]; then
    echo -e "${RED}Error: chrx-install script not found!${NC}"
    echo "Make sure you're running this from the repository root."
    exit 1
fi

# Clean previous build
if [ -d "$DIST_DIR" ]; then
    echo -e "${YELLOW}Cleaning previous build...${NC}"
    rm -rf "$DIST_DIR"
fi

if [ -f "$OUTPUT_FILE" ]; then
    rm -f "$OUTPUT_FILE"
fi

# Create directory structure
echo "Creating directory structure..."
mkdir -p "$DIST_DIR/bin"
mkdir -p "$DIST_DIR/etc"

# Copy main script
echo "Copying chrx-install script..."
cp chrx-install "$DIST_DIR/bin/chrx"
chmod +x "$DIST_DIR/bin/chrx"

# Copy repartitioning script
echo "Copying chrx-install script..."
cp chrx-setup-storage "$DIST_DIR/bin/chrx"
chmod +x "$DIST_DIR/bin/chrx"

# Copy optional files if they exist
if [ -f "chrx-devices" ]; then
    echo "Copying chrx-devices database..."
    cp chrx-devices "$DIST_DIR/etc/"
else
    echo -e "${YELLOW}Note: chrx-devices not found (optional)${NC}"
fi

# Create the tarball
echo "Creating tarball..."
cd "$DIST_DIR"
tar czf "../$OUTPUT_FILE" bin/ etc/
cd ..

# Cleanup
echo "Cleaning up..."
rm -rf "$DIST_DIR"

# Get file size
if command -v du >/dev/null 2>&1; then
    SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
else
    SIZE=$(ls -lh "$OUTPUT_FILE" | awk '{print $5}')
fi

echo -e "\n${GREEN}✓ Build complete!${NC}"
echo -e "  Output: ${YELLOW}$OUTPUT_FILE${NC}"
echo -e "  Size: $SIZE"

# Generate installation instructions
echo -e "\n${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Installation Instructions${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo "1. Upload dist.tar.gz to your GitHub repository"
echo ""
echo "2. Share this installation command with users:"
echo ""
echo -e "${YELLOW}curl -L https://tinyurl.com/td-chrx-tar | sudo tar xzfC - /usr/local && chrx${NC}"
echo ""
echo "3. Users run the same command twice:"
echo "   - First run: Creates partition"
echo "   - Second run: Installs Linux"
echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"

# Test the tarball
echo -e "\n${YELLOW}Testing tarball contents...${NC}"
tar tzf "$OUTPUT_FILE" | head -20

echo -e "\n${GREEN}Build successful!${NC}"
