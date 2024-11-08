#!/bin/bash 
# Dependencies: tesseract-ocr imagemagick scrot xsel gnome-screenshot libnotify-bin

TESS_LANG="eng+fra"
TMP_DIR="/tmp"
LOG_FILE="$TMP_DIR/lens_last.log"
SCR_IMG=$(mktemp "$TMP_DIR/lens_screenshot_XXXXXX.png")

> "$LOG_FILE"
trap "rm -f ${SCR_IMG}*" EXIT
export DISPLAY=:0

echo "Taking screenshot..." | tee -a "$LOG_FILE"
gnome-screenshot -a -f "$SCR_IMG" 2>> "$LOG_FILE"
convert "$SCR_IMG" -resample 100 "$SCR_IMG" 2>> "$LOG_FILE"

if [[ ! -f "$SCR_IMG" ]]; then
    echo "Screenshot failed. Check error log in $LOG_FILE" | tee -a "$LOG_FILE"
    exit 1
else
    echo "Screenshot saved to: $SCR_IMG" | tee -a "$LOG_FILE"
fi

mogrify -modulate 100,0 -resize 400% "$SCR_IMG" 2>> "$LOG_FILE"
echo "Running Tesseract OCR..." | tee -a "$LOG_FILE"
tesseract "$SCR_IMG" "$SCR_IMG" -l $TESS_LANG &>> "$LOG_FILE"

if [[ ! -f "$SCR_IMG.txt" ]]; then
    echo "Tesseract failed to create output text file." | tee -a "$LOG_FILE"
    exit 1
fi

cat "$SCR_IMG.txt" > "$TMP_DIR/lens_last_recognized.txt"
cat "$SCR_IMG.txt" | xsel -bi

notify-send --app-name "Text copier" --icon "./ubuntu-lens.png" "Text copied from the screen" "Now you can paste it wherever you like" | tee -a "$LOG_FILE"

exit

