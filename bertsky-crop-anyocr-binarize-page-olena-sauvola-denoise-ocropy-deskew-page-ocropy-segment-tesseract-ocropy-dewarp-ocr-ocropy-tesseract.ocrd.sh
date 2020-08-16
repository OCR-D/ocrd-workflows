#!/usr/bin/env ocrd-wf

ocrd-olena-binarize -I OCR-D-IMG -O OCR-D-IMG-BINPAGE-sauvola -P impl sauvola-ms-split
ocrd-anybaseocr-crop -I OCR-D-IMG-BINPAGE-sauvola -O OCR-D-SEG-PAGE-anyocr
ocrd-olena-binarize -I OCR-D-GT-SEG-PAGE-anyocr -O OCR-D-GT-SEG-PAGE-anyocr-BINPAGE-sauvola -P impl sauvola-ms-split
ocrd-cis-ocropy-denoise -I OCR-D-GT-SEG-PAGE-anyocr-BINPAGE-sauvola -O OCR-D-GT-SEG-PAGE-anyocr-BINPAGE-sauvola-DENOISE-ocropy \
    -P level-of-operation page \
    -P noise_maxsize 3.0
ocrd-tesserocr-deskew \
    -I OCR-D-GT-SEG-PAGE-anyocr-BINPAGE-sauvola-DENOISE-ocropy \
    -O OCR-D-GT-SEG-PAGE-anyocr-BINPAGE-sauvola-DENOISE-ocropy-DESKEW-tesseract \
    -P operation_level page
ocrd-cis-ocropy-deskew \
    -I OCR-D-GT-SEG-PAGE-anyocr-BINPAGE-sauvola-DENOISE-ocropy \
    -I OCR-D-GT-SEG-PAGE-anyocr-BINPAGE-sauvola-DENOISE-ocropy-DESKEW-ocropy \
    -P level-of-operation page \
    -P maxskew 5
ocrd-tesserocr-segment-region \
    -I OCR-D-GT-SEG-PAGE-anyocr-BINPAGE-sauvola-DENOISE-ocropy-DESKEW-ocropy \
    -O OCR-D-SEG-BLOCK-tesseract \
    -P padding 5 \
    -P find_tables false
ocrd-segment-repair \
    -I OCR-D-SEG-BLOCK-tesseract \
    -O OCR-D-SEG-BLOCK-tesseract-plausible \
    -P plausibilize true \
    -P plausibilize_merge_min_overlap: 0.7
ocrd-cis-ocropy-clip \
    -I OCR-D-SEG-BLOCK-tesseract \
    -O OCR-D-SEG-BLOCK-tesseract-CLIP
ocrd-tesserocr-deskew \
    -I OCR-D-SEG-BLOCK-tesseract-CLIP \
    -O OCR-D-SEG-BLOCK-tesseract-CLIP-DESKEW-tesseract \
    -P operation_level page
ocrd-cis-ocropy-segment \
    -I OCR-D-SEG-BLOCK-tesseract-CLIP-DESKEW-tesseract \
    -O OCR-D-SEG-LINE-tesseract-ocropy \
    -P spread 2.4
ocrd-cis-ocropy-dewarp \
    -I OCR-D-SEG-LINE-tesseract-ocropy \
    -O OCR-D-SEG-LINE-tesseract-ocropy-DEWARP
ocrd-cis-ocropy-recognize \
    -I OCR-D-SEG-LINE-tesseract-ocropy-DEWARP \
    -O OCR-D-OCR-OCRO-fraktur-SEG-LINE-tesseract-ocropy-DEWARP \
    -P textequiv_level glyph -P model fraktur.pyrnn
ocrd-cis-ocropy-recognize \
    -I OCR-D-SEG-LINE-tesseract-ocropy-DEWARP \
    -O OCR-D-OCR-OCRO-frakturjze-SEG-LINE-tesseract-ocropy-DEWARP \
    -P textequiv_level glyph -P model fraktur-jze.pyrnn
ocrd-tesserocr-recognize \
    -I OCR-D-SEG-LINE-tesseract-ocropy-DEWARP \
    -O OCR-D-OCR-TESS-Fraktur-SEG-LINE-tesseract-ocropy-DEWARP \
    -P textequiv_level glyph -P overwrite_words true -P model script/Fraktur
ocrd-tesserocr-recognize \
    -I OCR-D-SEG-LINE-tesseract-ocropy-DEWARP \
    -O OCR-D-OCR-TESS-Fraktur-Latin-SEG-LINE-tesseract-ocropy-DEWARP \
    -P textequiv_level glyph -P overwrite_words true -P model 'script/Fraktur+script/Latin'
ocrd-tesserocr-recognize \
    -I OCR-D-SEG-LINE-tesseract-ocropy-DEWARP \
    -O OCR-D-OCR-TESS-frk-SEG-LINE-tesseract-ocropy-DEWARP \
    -P textequiv_level glyph -P overwrite_words true -P model 'frk'
ocrd-tesserocr-recognize \
    -I OCR-D-SEG-LINE-tesseract-ocropy-DEWARP \
    -O OCR-D-OCR-TESS-frk-deu-SEG-LINE-tesseract-ocropy-DEWARP \
    -P textequiv_level glyph -P overwrite_words true -P model 'frk+deu'
ocrd-tesserocr-recognize \
    -I OCR-D-SEG-LINE-tesseract-ocropy-DEWARP \
    -O OCR-D-OCR-TESS-gt4histocr-SEG-LINE-tesseract-ocropy-DEWARP \
    -P textequiv_level glyph -P overwrite_words true -P model 'GT4HistOCR_2000000+GT4HistOCR_300000+GT4HistOCR_100000'
ocrd-calamari-recognize \
    -I OCR-D-SEG-LINE-tesseract-ocropy-DEWARP \
    -O OCR-D-OCR-CALA-gt4histocr-SEG-LINE-tesseract-ocropy-DEWARP \
    -P checkpoint "$(VIRTUAL_ENV)/share/calamari/GT4HistOCR/*.ckpt.json"
