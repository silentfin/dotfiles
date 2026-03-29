#!/bin/bash
grim -g "$(slurp -c '#ff0000ff')" -t ppm - | tesseract stdin stdout | wl-copy
