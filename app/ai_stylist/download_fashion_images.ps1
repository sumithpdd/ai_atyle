# Create images directory if it doesn't exist
New-Item -ItemType Directory -Force -Path "assets/images"

# Download fashion item images
$imageUrls = @{
    "Oversized Denim Jacket.jpg" = "https://images.asos-media.com/products/asos-design-oversized-denim-jacket-in-washed-blue/204111768-1-blue"
    "Pleated Midi Skirt.jpg" = "https://images.asos-media.com/products/asos-design-pleated-midi-skirt-in-black/204111768-1-black"
    "Cropped Hoodie.jpg" = "https://images.asos-media.com/products/asos-design-cropped-hoodie-in-grey-marl/204111768-1-greymarl"
    "Floral Maxi Dress.jpg" = "https://images.asos-media.com/products/asos-design-floral-maxi-dress-in-blue/204111768-1-blue"
    "Tailored Blazer.jpg" = "https://images.asos-media.com/products/asos-design-tailored-blazer-in-black/204111768-1-black"
    "Distressed Denim Shorts.jpg" = "https://images.asos-media.com/products/asos-design-distressed-denim-shorts-in-blue/204111768-1-blue"
    "Knit Sweater.jpg" = "https://images.asos-media.com/products/asos-design-knit-sweater-in-cream/204111768-1-cream"
    "Leather Biker Jacket.jpg" = "https://images.asos-media.com/products/asos-design-leather-biker-jacket-in-black/204111768-1-black"
}

foreach ($image in $imageUrls.GetEnumerator()) {
    Write-Host "Downloading $($image.Key)..."
    Invoke-WebRequest -Uri $image.Value -OutFile "assets/images/$($image.Key)"
} 