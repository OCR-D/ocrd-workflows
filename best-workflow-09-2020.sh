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
ocrd-cis-ocropy-segment \
	-I OCR-D-BIN-DENOISE-DESKEW \
	-O OCR-D-SEG-REG \
	-P level-of-operation page
ocrd-tesserocr-deskew \
	-I OCR-D-SEG-REG \
	-O OCR-D-SEG-REG-DESKEW
ocrd-cis-ocropy-clip \
	-I OCR-D-SEG-REG-DESKEW \
	-O OCR-D-SEG-REG-DESKEW-CLIP
ocrd-cis-ocropy-segment \
	-I OCR-D-SEG-REG-DESKEW-CLIP \
	-O OCR-D-SEG-LINE
ocrd-cis-ocropy-clip \
	-I OCR-D-SEG-LINE \
	-O OCR-D-SEG-CLIP-LINE \
	-P level-of-operation line
ocrd-cis-ocropy-dewarp \
	-I OCR-D-SEG-CLIP-LINE \
	-O OCR-D-SEG-LINE-RESEG-DEWARP
ocrd-calamari-recognize \
	-I OCR-D-SEG-LINE-RESEG-DEWARP \
	-O OCR-D-OCR \
	-P checkpoint "$(VIRTUAL_ENV)/share/calamari/GT4HistOCR/*.ckpt.json"