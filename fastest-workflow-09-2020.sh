#!/usr/bin/env ocrd-wf

ocrd-cis-ocropy-binarize \
	-I OCR-D-IMG \
	-O OCR-D-BIN
ocrd-anybaseocr-crop \
	-I OCR-D-BIN \
	-O OCR-D-CROP
ocrd-skimage-binarize \
	-I OCR-D-CROP \
	-O OCR-D-BIN2 \
	-P method li
ocrd-skimage-denoise \
	-I OCR-D-BIN2 \
	-O OCR-D-BIN-DENOISE \
	-P level-of-operation page
ocrd-tesserocr-deskew \
	-I OCR-D-BIN-DENOISE \
	-O OCR-D-BIN-DENOISE-DESKEW \
	-P operation_level page
ocrd-tesserocr-segment-region \
	-I OCR-D-BIN-DENOISE-DESKEW \
	-O OCR-D-SEG-REG
ocrd-segment-repair \
	-I OCR-D-SEG-REG \
	-O OCR-D-SEG-REPAIR \
	-P plausibilize true
ocrd-tesserocr-deskew \
	-I OCR-D-SEG-REPAIR \
	-O OCR-D-SEG-REG-DESKEW
ocrd-cis-ocropy-clip \
	-I OCR-D-SEG-REG-DESKEW \
	-O OCR-D-SEG-REG-DESKEW-CLIP
ocrd-tesserocr-segment-line \
	-I OCR-D-SEG-REG-DESKEW-CLIP \
	-O OCR-D-SEG-LINE
ocrd-cis-ocropy-dewarp \
	-I OCR-D-SEG-LINE \
	-O OCR-D-SEG-LINE-RESEG-DEWARP
ocrd-tesserocr-recognize \
	-I OCR-D-SEG-LINE-RESEG-DEWARP \
	-O OCR-D-OCR -P textequiv_level glyph \
	-P overwrite_words true \
	-P model GT4HistOCR_50000000.997_191951
