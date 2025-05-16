# Create directories if they don't exist
New-Item -ItemType Directory -Force -Path "assets/fonts"
New-Item -ItemType Directory -Force -Path "assets/images"
New-Item -ItemType Directory -Force -Path "assets/icons"

# Download Poppins fonts
$fontUrls = @{
    "Poppins-Regular.ttf" = "https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-Regular.ttf"
    "Poppins-Medium.ttf" = "https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-Medium.ttf"
    "Poppins-SemiBold.ttf" = "https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-SemiBold.ttf"
    "Poppins-Bold.ttf" = "https://github.com/google/fonts/raw/main/ofl/poppins/Poppins-Bold.ttf"
}

foreach ($font in $fontUrls.GetEnumerator()) {
    Write-Host "Downloading $($font.Key)..."
    Invoke-WebRequest -Uri $font.Value -OutFile "assets/fonts/$($font.Key)"
}

# Download some test images
$imageUrls = @{
    "fashion1.jpg" = "https://images.asos-media.com/products/armani-exchange-denim-jacket-in-light-blue/207841717-1-bluedenim?$n_640w$&wid=513&fit=constrain"
    "fashion2.jpg" = "https://images.asos-media.com/products/asos-design-pleated-midi-skirt-in-black/204111768-1-black"
    "fashion3.jpg" = "https://images.asos-media.com/products/asos-design-cropped-hoodie-in-grey-marl/204111768-1-greymarl"
}

foreach ($image in $imageUrls.GetEnumerator()) {
    Write-Host "Downloading $($image.Key)..."
    Invoke-WebRequest -Uri $image.Value -OutFile "assets/images/$($image.Key)"
}

# Download some icons
$iconUrls = @{
    "style.png" = "https://raw.githubusercontent.com/google/material-design-icons/master/png/action/style/materialicons/48dp/2x/baseline_style_black_48dp.png"
    "mood.png" = "https://raw.githubusercontent.com/google/material-design-icons/master/png/social/mood/materialicons/48dp/2x/baseline_mood_black_48dp.png"
    "analytics.png" = "https://raw.githubusercontent.com/google/material-design-icons/master/png/action/analytics/materialicons/48dp/2x/baseline_analytics_black_48dp.png"
}

foreach ($icon in $iconUrls.GetEnumerator()) {
    Write-Host "Downloading $($icon.Key)..."
    Invoke-WebRequest -Uri $icon.Value -OutFile "assets/icons/$($icon.Key)"
}

Write-Host "All assets downloaded successfully!" 