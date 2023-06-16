#!/usr/bin/env bash

# Default values
BUCKET=""
RELEASE=""
NIX_RELEASE=""
COMMIT=""
VM_NUMBER=""

# Usage function to display script usage
usage() {
    echo "Usage: scriptname -b BUCKET -v VM_NUMBER -f FILENAME"
}

# Function to extract values from the filename
extract_values_from_filename() {
    filename="$1"

    # Validate filename format
    if [[ ! "$filename" =~ vzdump-qemu-v(.*)-(.*)-(.*)\.vma\.zst ]]; then
        echo "Invalid filename format: $filename"
        exit 1
    fi

    # Extracting RELEASE, NIX_RELEASE, and COMMIT using string manipulation
    RELEASE="${BASH_REMATCH[1]}"
    NIX_RELEASE="${BASH_REMATCH[2]}"
    COMMIT="${BASH_REMATCH[3]}"
}

# Parsing command-line arguments
while getopts ":b:v:f:" opt; do
    case "${opt}" in
        b)
            BUCKET="${OPTARG}"
            ;;
        v)
            VM_NUMBER="${OPTARG}"
            ;;
        f)
            FILENAME="${OPTARG}"
            extract_values_from_filename "$FILENAME"
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done

# Check if required arguments are provided
if [ -z "$BUCKET" ] || [ -z "$RELEASE" ] || [ -z "$NIX_RELEASE" ] || [ -z "$COMMIT" ] || [ -z "$VM_NUMBER" ]; then
    usage
    exit 1
fi

# Rest of your script logic using the variables
echo "Bucket: $BUCKET"
echo "Release: $RELEASE"
echo "Nix Release: $NIX_RELEASE"
echo "Commit: $COMMIT"
echo "VM Number: $VM_NUMBER"

# Continue with the rest of your script logic...

commands=(
    "uplink cp sj://${BUCKET}/vzdump-qemu-v${RELEASE}-${NIX_RELEASE}-${COMMIT}.vma.zst /var/lib/vz/dump/"
    "qmrestore /var/lib/vz/dump/vzdump-qemu-v${RELEASE}-${NIX_RELEASE}-${COMMIT}.vma.zst ${VM_NUMBER} --unique true"
    "qm set ${VM_NUMBER} --ide2 local-lvm:cloudinit --boot c --bootdisk scsi0"
    "qm template ${VM_NUMBER}"
)

for cmd in "${commands[@]}"; do
    eval "$cmd; wait"
done
