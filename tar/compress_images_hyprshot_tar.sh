#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Enable verbose mode if the first argument is "verbose", "-v", or "--verbose"
verbose=false
if [[ $1 == "verbose" || $1 == "-v" || $1 == "--verbose" ]]; then
    verbose=true
fi

# Create an associative array to hold the files for each archive
declare -A archives
declare -A year_count
declare -A month_count

# Loop through all PNG files in the current directory
total_files=0
for file in *.png; do
    # Check if the file matches the pattern
    if [[ $file =~ ^([0-9]{4})-([0-9]{2})-.*_hyprshot\.png$ ]]; then
        # Increment total files count
        ((total_files++))
        
        # Extract year and month
        year="${BASH_REMATCH[1]}"
        month="${BASH_REMATCH[2]}"
        
        # Create the tar.gz filename
        archive_name="${year}-${month}-hyprshot.tar.gz"
        
        # Add the file to the corresponding archive in the associative array
        archives["$archive_name"]+="$file "
        
        # Count files per year and month
        ((year_count[$year]++))
        ((month_count["$year-$month"]++))
    fi
done

# Display total PNG files detected
if $verbose; then
    echo -e "${GREEN}Total PNG files detected: $total_files${NC}"
fi

# Display year and month counts
echo -e "${YELLOW}Yearly counts:${NC}"
for year in "${!year_count[@]}"; do
    echo -e "  Year $year: ${year_count[$year]} files"
done

echo -e "${YELLOW}Monthly counts:${NC}"
for month in "${!month_count[@]}"; do
    echo -e "  Month $month: ${month_count[$month]} files"
done

# Ask for confirmation before proceeding with compression
while true; do
    read -p "Do you want to proceed with compression? (y/n): " confirm
    case $confirm in
        [yY] | [yY][eE][sS])
            break  # Exit the loop to proceed with compression
            ;;
        [nN] | [nN][oO])
            echo -e "${RED}Compression aborted.${NC}"
            exit 1
            ;;
        *)
            echo "Please enter 'y' or 'yes' to proceed, or 'n' or 'no' to abort."
            ;;
    esac
done

# Create the archives
total_archives=0
for archive in "${!archives[@]}"; do
    tar -czvf "$archive" ${archives["$archive"]}
    ((total_archives++))
    
    if $verbose; then
        echo -e "${BLUE}Created archive: $archive${NC}"
    fi
done

# Display total tar.gz archives created
if $verbose; then
    echo -e "${GREEN}Total tar.gz archives created: $total_archives${NC}"
    echo -e "${GREEN}Archives created:${NC}"
    for archive in "${!archives[@]}"; do
        echo -e "  $archive"
    done
fi

# Ask if the user wants to delete the original PNG files
while true; do
    read -p "Do you want to delete all the PNG files with the hyprshot pattern? (y/n): " delete_confirm
    case $delete_confirm in
        [yY] | [yY][eE][sS])
            # Delete the files
            for file in *.png; do
                if [[ $file =~ ^([0-9]{4})-([0-9]{2})-.*_hyprshot\.png$ ]]; then
                    rm "$file"
                    if $verbose; then
                        echo -e "${BLUE}Deleted file: $file${NC}"
                    fi
                fi
            done
            echo -e "${GREEN}All matching PNG files have been deleted.${NC}"
            break
            ;;
        [nN] | [nN][oO])
            echo -e "${GREEN}Original PNG files retained.${NC}"
            break
            ;;
        *)
            echo "Please enter 'y' or 'yes' to delete the files, or 'n' or 'no' to retain them."
            ;;
    esac
done
