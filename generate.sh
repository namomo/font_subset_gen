#!/bin/bash

source .venv/bin/activate

# fonts 디렉토리 확인
if [ ! -d fonts ]; then
  echo "fonts 디렉토리가 존재하지 않습니다. fonts 디렉토리를 확인하세요."
  exit 1
fi

GLYPHS="glyphs/TetraTheta-glyphs.txt"

# fonts 디렉토리 내 모든 TTF 파일 반복 처리
for font_file in fonts/*.ttf; do
  # 파일 이름 및 경로 추출
  BASE_NAME=$(basename "$font_file")
  FILE_NAME="${BASE_NAME%.*}"  # 확장자 제외
  INPUT_FILE="fonts/$BASE_NAME"
  OUTPUT_DIR="dist/$FILE_NAME"

  # 출력 디렉토리 생성
  mkdir -p $OUTPUT_DIR 2> /dev/null

  # 서브셋 TTF 파일 생성
  echo "Converting $FILE_NAME font to TTF subset..."
  pyftsubset "$INPUT_FILE" --output-file="$OUTPUT_DIR/$FILE_NAME.ttf" --text-file=$GLYPHS --layout-features='*' --glyph-names --symbol-cmap --legacy-cmap --notdef-glyph --notdef-outline --recommended-glyphs --name-legacy --name-IDs='*' --name-languages='*' --drop-tables=

  echo "Converting $FILE_NAME font to woff subset..."
  pyftsubset "$INPUT_FILE" --output-file="$OUTPUT_DIR/$FILE_NAME.woff" --flavor="woff" --with-zopfli --text-file=$GLYPHS --layout-features='*' --glyph-names --symbol-cmap --legacy-cmap --notdef-glyph --notdef-outline --recommended-glyphs --name-legacy --name-IDs='*' --name-languages='*' --drop-tables=

  echo "Converting $font_file font to WOFF2..."
  pyftsubset "$INPUT_FILE" --output-file="$OUTPUT_DIR/$FILE_NAME.woff2" --flavor="woff2" --text-file=$GLYPHS --layout-features='*' --glyph-names --symbol-cmap --legacy-cmap --notdef-glyph --notdef-outline --recommended-glyphs --name-legacy --name-IDs='*' --name-languages='*' --drop-tables=
done
