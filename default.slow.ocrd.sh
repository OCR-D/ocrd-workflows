#!/usr/bin/env ocrd-wf

ocrd-olena-binarize           -I OCR-D-IMG                   -O OCR-D-BIN                 -P impl sauvola
ocrd-anybaseocr-crop          -I OCR-D-BIN                   -O OCR-D-CROP
ocrd-olena-binarize           -I OCR-D-CROP                  -O OCR-D-BIN2                -P impl kim
ocrd-cis-ocropy-denoise       -I OCR-D-BIN2                  -O OCR-D-BIN-DENOISE         -P level-of-operation page
ocrd-tesserocr-deskew         -I OCR-D-BIN-DENOISE           -O OCR-D-BIN-DENOISE-DESKEW  -P operation_level page
ocrd-tesserocr-segment-region -I OCR-D-BIN-DENOISE-DESKEW    -O OCR-D-SEG-REG
ocrd-segment-repair           -I OCR-D-SEG-REG               -O OCR-D-SEG-REPAIR          -P plausibilize true
ocrd-cis-ocropy-deskew        -I OCR-D-SEG-REPAIR            -O OCR-D-SEG-REG-DESKEW      -P level-of-operation region
ocrd-cis-ocropy-clip          -I OCR-D-SEG-REG-DESKEW        -O OCR-D-SEG-REG-DESKEW-CLIP -P level-of-operation region
ocrd-tesserocr-segment-line   -I OCR-D-SEG-REG-DESKEW-CLIP   -O OCR-D-SEG-LINE
ocrd-segment-repair           -I OCR-D-SEG-LINE              -O OCR-D-SEG-REPAIR-LINE     -P sanitize true
ocrd-cis-ocropy-dewarp        -I OCR-D-SEG-REPAIR-LINE       -O OCR-D-SEG-LINE-RESEG-DEWARP
ocrd-calamari-recognize       -I OCR-D-SEG-LINE-RESEG-DEWARP -O OCR-D-OCR \
  # This parameter should point to a glob of all the .ckpt.json files of a calamari model directory
  -P checkpoint /path/to/models/\*.ckpt.json
