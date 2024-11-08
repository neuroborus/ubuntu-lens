# Lens Text Copier

This script captures a screenshot of a selected area, performs OCR (Optical Character Recognition) on the image, and copies the recognized text to the clipboard. It's especially useful for quickly grabbing text from the screen without needing to type it manually.

## Requirements

To use this script, the following dependencies must be installed:
- `tesseract-ocr` (for text recognition)
- `imagemagick` (for image processing)
- `gnome-screenshot` (for screenshot capture)
- `xsel` (for clipboard management)
- `libnotify-bin` (for notifications)

On Ubuntu, you can install these with:
```bash
sudo apt update
sudo apt install tesseract-ocr imagemagick gnome-screenshot xsel libnotify-bin

