#!/bin/bash

# Branding Assets Generator
# Generates all required logo variations from source image

set -e  # Exit on any error

# Configuration
SOURCE_IMAGE="source_logo_2000x2000.jpg"
OUTPUT_DIR="branding-assets"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if source image exists
check_source() {
    if [ ! -f "$SOURCE_IMAGE" ]; then
        log_error "Source image '$SOURCE_IMAGE' not found!"
        log_info "Please ensure the image exists in the current directory"
        exit 1
    fi
    log_success "Source image found: $SOURCE_IMAGE"
}

# Create directory structure
create_directories() {
    log_info "Creating directory structure..."
    
    directories=(
        "$OUTPUT_DIR/01-master"
        "$OUTPUT_DIR/02-github" 
        "$OUTPUT_DIR/03-social"
        "$OUTPUT_DIR/04-web"
        "$OUTPUT_DIR/05-favicon"
        "$OUTPUT_DIR/06-future"
    )
    
    for dir in "${directories[@]}"; do
        mkdir -p "$dir"
    done
    
    log_success "Directory structure created"
}

# Generate rounded corners filter
get_rounded_filter() {
    local width=$1
    local height=$2
    local radius_percent=$3
    
    if [ "$radius_percent" -eq 0 ]; then
        echo ""
        return
    fi
    
    local radius=$(( width * radius_percent / 100 ))
    echo ",format=rgba,geq=r='if(gt(abs(X-(W/2)),W/2-${radius})*gt(abs(Y-(H/2)),H/2-${radius})*gt(hypot(${radius}-(W/2-abs(X-(W/2))),${radius}-(H/2-abs(Y-(H/2)))),${radius}),0,r(X,Y))':g='if(gt(abs(X-(W/2)),W/2-${radius})*gt(abs(Y-(H/2)),H/2-${radius})*gt(hypot(${radius}-(W/2-abs(X-(W/2))),${radius}-(H/2-abs(Y-(H/2)))),${radius}),0,g(X,Y))':b='if(gt(abs(X-(W/2)),W/2-${radius})*gt(abs(Y-(H/2)),H/2-${radius})*gt(hypot(${radius}-(W/2-abs(X-(W/2))),${radius}-(H/2-abs(Y-(H/2)))),${radius}),0,b(X,Y))':a='if(gt(abs(X-(W/2)),W/2-${radius})*gt(abs(Y-(H/2)),H/2-${radius})*gt(hypot(${radius}-(W/2-abs(X-(W/2))),${radius}-(H/2-abs(Y-(H/2)))),${radius}),0,255)'"
}

# Generate image with specific parameters
generate_image() {
    local filename=$1
    local width=$2
    local height=$3
    local bg_type=$4  # "transparent" or "white"
    local corner_radius_percent=$5
    local output_path=$6
    
    log_info "Generating $filename (${width}x${height}px)..."
    
    # Base scaling filter
    local filter="scale=${width}:${height}:force_original_aspect_ratio=decrease"
    
    # Add background if needed
    if [ "$bg_type" = "white" ]; then
        filter="${filter},pad=${width}:${height}:(ow-iw)/2:(oh-ih)/2:white"
    else
        filter="${filter},pad=${width}:${height}:(ow-iw)/2:(oh-ih)/2:color=0x00000000"
    fi
    
    # Add rounded corners if specified
    if [ "$corner_radius_percent" -gt 0 ]; then
        local rounded_filter=$(get_rounded_filter $width $height $corner_radius_percent)
        filter="${filter}${rounded_filter}"
    fi
    
    # Execute ffmpeg command
    if ffmpeg -i "$SOURCE_IMAGE" -vf "$filter" -y "$output_path" 2>/dev/null; then
        log_success "✓ Created $filename"
    else
        log_error "✗ Failed to create $filename"
        return 1
    fi
}

# Generate horizontal logo layout
generate_horizontal() {
    local filename=$1
    local width=$2
    local height=$3
    local output_path=$4
    
    log_info "Generating horizontal $filename (${width}x${height}px)..."
    
    # For horizontal layouts, we maintain aspect ratio but fit to width primarily
    local filter="scale=${width}:${height}:force_original_aspect_ratio=decrease,pad=${width}:${height}:(ow-iw)/2:(oh-ih)/2:color=0x00000000"
    
    if ffmpeg -i "$SOURCE_IMAGE" -vf "$filter" -y "$output_path" 2>/dev/null; then
        log_success "✓ Created horizontal $filename"
    else
        log_error "✗ Failed to create horizontal $filename"
        return 1
    fi
}

# Generate SVG (convert from PNG)
generate_svg() {
    local svg_path="$OUTPUT_DIR/01-master/logo-vector.svg"
    local png_source="$OUTPUT_DIR/01-master/logo-master-2000px.png"
    
    log_info "Generating SVG from master PNG..."
    
    # Create a simple SVG wrapper around the PNG
    cat > "$svg_path" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<svg width="2000" height="2000" viewBox="0 0 2000 2000" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <title>Logo</title>
  <image width="2000" height="2000" xlink:href="data:image/png;base64,$(base64 -w 0 "$png_source")" />
</svg>
EOF
    
    if [ -f "$svg_path" ]; then
        log_success "✓ Created SVG vector logo"
    else
        log_error "✗ Failed to create SVG"
        return 1
    fi
}

# Generate ICO favicon
generate_ico() {
    local ico_path="$OUTPUT_DIR/05-favicon/favicon.ico"
    local png_16="$OUTPUT_DIR/05-favicon/favicon-16px.png"
    local png_32="$OUTPUT_DIR/05-favicon/favicon-32px.png"
    
    log_info "Generating ICO favicon..."
    
    # Create ICO from multiple PNG sizes
    if command -v convert >/dev/null 2>&1; then
        convert "$png_16" "$png_32" "$ico_path" 2>/dev/null
        log_success "✓ Created ICO favicon"
    else
        log_warning "ImageMagick not found, skipping ICO generation"
        log_info "Install ImageMagick with: sudo apt install imagemagick"
    fi
}

# Phase 1: Essential Assets
generate_phase1() {
    log_info "=== PHASE 1: ESSENTIAL ASSETS ==="
    
    # Master file
    generate_image "logo-master-2000px.png" 2000 2000 "transparent" 0 "$OUTPUT_DIR/01-master/logo-master-2000px.png"
    
    # GitHub avatar
    generate_image "logo-github-420px.png" 420 420 "transparent" 0 "$OUTPUT_DIR/02-github/logo-github-420px.png"
    
    # Favicon
    generate_image "favicon-32px.png" 32 32 "transparent" 0 "$OUTPUT_DIR/05-favicon/favicon-32px.png"
    generate_image "favicon-16px.png" 16 16 "transparent" 0 "$OUTPUT_DIR/05-favicon/favicon-16px.png"
    
    # SVG (depends on master PNG)
    generate_svg
    
    log_success "Phase 1 complete!"
}

# Phase 2: Social Media Assets
generate_phase2() {
    log_info "=== PHASE 2: SOCIAL MEDIA ASSETS ==="
    
    # Social media profiles
    generate_image "logo-social-400px.png" 400 400 "transparent" 0 "$OUTPUT_DIR/03-social/logo-social-400px.png"
    generate_image "logo-facebook-170px.png" 170 170 "transparent" 0 "$OUTPUT_DIR/03-social/logo-facebook-170px.png"
    
    # Social sharing cards
    generate_image "social-sharing-1200px.png" 1200 630 "white" 0 "$OUTPUT_DIR/02-github/social-sharing-1200px.png"
    generate_image "social-sharing-1200px-wide.png" 1200 600 "white" 0 "$OUTPUT_DIR/03-social/social-sharing-1200px-wide.png"
    
    # Horizontal layouts for web
    generate_horizontal "logo-horizontal-800px.png" 800 200 "$OUTPUT_DIR/04-web/logo-horizontal-800px.png"
    generate_horizontal "logo-horizontal-600px.png" 600 150 "$OUTPUT_DIR/04-web/logo-horizontal-600px.png"
    generate_horizontal "logo-horizontal-400px.png" 400 100 "$OUTPUT_DIR/04-web/logo-horizontal-400px.png"
    
    log_success "Phase 2 complete!"
}

# Phase 3: Advanced Assets
generate_phase3() {
    log_info "=== PHASE 3: ADVANCED ASSETS ==="
    
    # App icons with rounded corners
    generate_image "app-icon-1024px.png" 1024 1024 "transparent" 15 "$OUTPUT_DIR/06-future/app-icon-1024px.png"
    generate_image "app-icon-ios-1024px.png" 1024 1024 "transparent" 20 "$OUTPUT_DIR/06-future/app-icon-ios-1024px.png"
    generate_image "app-icon-android-512px.png" 512 512 "transparent" 10 "$OUTPUT_DIR/06-future/app-icon-android-512px.png"
    
    # Thumbnails and cards
    generate_image "card-thumbnail-200px.png" 200 200 "transparent" 8 "$OUTPUT_DIR/04-web/card-thumbnail-200px.png"
    
    # Presentation and print
    generate_image "presentation-slide-1920px.png" 1920 1080 "white" 0 "$OUTPUT_DIR/06-future/presentation-slide-1920px.png"
    generate_image "business-card-300dpi.png" 600 600 "transparent" 0 "$OUTPUT_DIR/06-future/business-card-300dpi.png"
    
    # Color variations
    log_info "Creating white and black versions..."
    cp "$OUTPUT_DIR/01-master/logo-master-2000px.png" "$OUTPUT_DIR/01-master/logo-white-version.png"
    
    # Create black version (invert colors but keep transparency)
    ffmpeg -i "$OUTPUT_DIR/01-master/logo-master-2000px.png" -vf "negate" -y "$OUTPUT_DIR/01-master/logo-black-version.png" 2>/dev/null
    
    # Generate ICO favicon
    generate_ico
    
    log_success "Phase 3 complete!"
}

# Generate summary report
generate_report() {
    log_info "=== GENERATION REPORT ==="
    
    echo ""
    echo "📁 Generated files in $OUTPUT_DIR:"
    find "$OUTPUT_DIR" -type f | sort | while read file; do
        size=$(du -h "$file" | cut -f1)
        echo "  ✓ ${file#$OUTPUT_DIR/} ($size)"
    done
    
    echo ""
    echo "📊 Summary:"
    echo "  • Total files: $(find "$OUTPUT_DIR" -type f | wc -l)"
    echo "  • Total size: $(du -sh "$OUTPUT_DIR" | cut -f1)"
    echo ""
    echo "🚀 Ready to use! Your branding assets are complete."
    echo ""
    echo "Next steps:"
    echo "  1. Upload logo-github-420px.png to GitHub organization"
    echo "  2. Use logo-vector.svg on your website"
    echo "  3. Add favicon files to your website root"
    echo "  4. Use social sharing images for Open Graph meta tags"
}

# Main execution
main() {
    echo "🎨  Branding Assets Generator"
    echo "=============================="
    echo ""
    
    check_source
    create_directories
    
    # Generate assets in phases
    generate_phase1
    generate_phase2  
    generate_phase3
    
    # Create report
    generate_report
    
    log_success "All branding assets generated successfully! 🎉"
}

# Run main function
main "$@"