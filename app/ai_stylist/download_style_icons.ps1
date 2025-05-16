# Create icons directory if it doesn't exist
New-Item -ItemType Directory -Force -Path "assets/icons"

# Download style type icons from Remix Icon CDN (SVG)
$iconUrls = @{
    "shape.svg" = "https://cdn.jsdelivr.net/npm/remixicon@3.5.0/icons/Fashion/dress-line.svg"
    "fabric.svg" = "https://cdn.jsdelivr.net/npm/remixicon@3.5.0/icons/Design/grid-line.svg"
    "print.svg" = "https://cdn.jsdelivr.net/npm/remixicon@3.5.0/icons/Design/brush-line.svg"
    "coats.svg" = "https://cdn.jsdelivr.net/npm/remixicon@3.5.0/icons/Fashion/t-shirt-line.svg"
    "blazers.svg" = "https://cdn.jsdelivr.net/npm/remixicon@3.5.0/icons/Business/suit-line.svg"
    "blouses.svg" = "https://cdn.jsdelivr.net/npm/remixicon@3.5.0/icons/Fashion/shirt-line.svg"
    "skirts.svg" = "https://cdn.jsdelivr.net/npm/remixicon@3.5.0/icons/Fashion/skirt-line.svg"
    "dresses.svg" = "https://cdn.jsdelivr.net/npm/remixicon@3.5.0/icons/Fashion/women-line.svg"
    "pants.svg" = "https://cdn.jsdelivr.net/npm/remixicon@3.5.0/icons/Fashion/pants-line.svg"
    "shoes.svg" = "https://cdn.jsdelivr.net/npm/remixicon@3.5.0/icons/Fashion/shoe-line.svg"
}

foreach ($icon in $iconUrls.GetEnumerator()) {
    Write-Host "Downloading $($icon.Key)..."
    Invoke-WebRequest -Uri $icon.Value -OutFile "assets/icons/$($icon.Key)"
} 