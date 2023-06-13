mkdir upload && cp ./result/*vma.zst ./$(basename ./result/*vma.zst .vma.zst)_$(sha256sum ./result/*vma.zst | awk '{print $1}').vma.zst
