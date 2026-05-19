#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
OUTPUT_DIR="${PROJECT_ROOT}/_output"
INPUT_FILE="${1:-${PROJECT_ROOT}/workspace/final-report/mindflow-methodology-paper-20260311.md}"
CHROME_BIN="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: input file not found: $INPUT_FILE"
  exit 1
fi

TITLE=$(awk -F': ' '/^title:/ {print $2; exit}' "$INPUT_FILE")
if [ -z "$TITLE" ]; then
  TITLE=$(grep -m 1 '^# ' "$INPUT_FILE" | sed 's/^# //')
fi
if [ -z "$TITLE" ]; then
  echo "Error: no title found in markdown"
  exit 1
fi

SAFE_TITLE=$(echo "$TITLE" | sed 's/[:<>"|?*\/\\]/-/g' | sed 's/  */ /g')
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BASENAME="${SAFE_TITLE} [${TIMESTAMP}]"

mkdir -p "$OUTPUT_DIR"

DOCX_TEMPLATE="${SCRIPT_DIR}/docx-template.docx"
LATEX_HEADER="${SCRIPT_DIR}/latex-header.tex"

if command -v pandoc >/dev/null 2>&1; then
  TMP_DIR=$(mktemp -d)
  NORMALIZED_MD="${TMP_DIR}/normalized.md"
  DOCX_MD="${TMP_DIR}/docx.md"
  PDF_MD="${TMP_DIR}/pdf.md"
  RENDERED_DOCX_MD="${TMP_DIR}/rendered-docx.md"
  RENDERED_PDF_MD="${TMP_DIR}/rendered-pdf.md"
  TEX_FILE="${TMP_DIR}/document.tex"

  python3 - "$INPUT_FILE" "$NORMALIZED_MD" "$DOCX_MD" "$PDF_MD" <<'PY'
from pathlib import Path
import sys
import re

src = Path(sys.argv[1]).read_text()
normalized = Path(sys.argv[2])
docx_out = Path(sys.argv[3])
pdf_out = Path(sys.argv[4])
lines = src.splitlines()

title = ""
author = ""
body = []

idx = 0
while idx < len(lines) and not lines[idx].strip():
    idx += 1

if idx < len(lines) and lines[idx].startswith("# "):
    title = lines[idx][2:].strip()
    idx += 1

while idx < len(lines) and not lines[idx].strip():
    idx += 1

if idx < len(lines) and lines[idx].startswith("作者："):
    author = lines[idx].replace("作者：", "", 1).strip()
    idx += 1

while idx < len(lines):
    body.append(lines[idx])
    idx += 1

while body and not body[0].strip():
    body.pop(0)

processed_body = []
in_fence = False
for line in body:
    stripped = line.strip()
    if stripped.startswith("```"):
        in_fence = not in_fence
        processed_body.append(line)
        continue
    if not in_fence:
        line = re.sub(r'`([^`]+)`', r'\1', line)
    processed_body.append(line)

docx_processed = []
pdf_processed = []
in_references = False
for line in processed_body:
    if line.startswith("# 参考文献"):
        in_references = True
        docx_processed.append(line)
        pdf_processed.append(line)
        pdf_processed.append("")
        pdf_processed.append("\\begingroup\\small")
        continue
    if not in_references:
        docx_line = re.sub(r'\[(\d+)\]', r'<sup>[\1]</sup>', line)
        pdf_line = re.sub(r'\[(\d+)\]', r'\\textsuperscript{[\1]}', line)
    else:
        docx_line = line
        if line.strip():
            escaped = line.replace("\\", "\\\\")
            pdf_line = rf"\noindent\hangindent=2em\hangafter=1 {escaped}\par"
        else:
            pdf_line = ""
    docx_processed.append(docx_line)
    pdf_processed.append(pdf_line)

if in_references:
    pdf_processed.append("\\endgroup")

front_matter = [
    "---",
    f'title: "{title}"',
    f'author: "{author}"',
    "---",
    "",
]
normalized.write_text("\n".join(front_matter + processed_body) + "\n")
docx_out.write_text("\n".join(front_matter + docx_processed) + "\n")
pdf_out.write_text("\n".join(front_matter + pdf_processed) + "\n")
PY

  cp "$DOCX_MD" "$RENDERED_DOCX_MD"
  cp "$PDF_MD" "$RENDERED_PDF_MD"

  if command -v mmdc >/dev/null 2>&1; then
    python3 - "$DOCX_MD" "$RENDERED_DOCX_MD" "$TMP_DIR/docx" "$CHROME_BIN" <<'PY'
from pathlib import Path
import subprocess
import sys
import re
import os

src = Path(sys.argv[1]).read_text().splitlines()
out = Path(sys.argv[2])
tmp_dir = Path(sys.argv[3])
chrome = sys.argv[4]
tmp_dir.mkdir(parents=True, exist_ok=True)

result = []
i = 0
figure_idx = 1
figure_widths = {1: "72%", 2: "42%", 3: "96%", 4: "100%", 5: "100%", 6: "52%", 7: "66%"}

while i < len(src):
    line = src[i]
    if line.strip() == "```mermaid":
        i += 1
        mermaid_lines = []
        while i < len(src) and src[i].strip() != "```":
            mermaid_lines.append(src[i])
            i += 1
        if i < len(src) and src[i].strip() == "```":
            i += 1

        caption = f"图 {figure_idx}"
        while i < len(src) and not src[i].strip():
            i += 1
        if i < len(src) and re.match(r"^图\s*\d+", src[i].strip()):
            caption = src[i].strip()
            i += 1
        alt = re.sub(r"^图\s*\d+\s*", "", caption).strip() or f"Figure {figure_idx}"

        mmd = tmp_dir / f"figure-{figure_idx:02d}.mmd"
        png = tmp_dir / f"figure-{figure_idx:02d}.png"
        cfg = tmp_dir / f"puppeteer-{figure_idx:02d}.json"
        mermaid_cfg = tmp_dir / f"mermaid-{figure_idx:02d}.json"
        mmd.write_text("\n".join(mermaid_lines) + "\n")
        cfg.write_text('{"executablePath": "%s", "args": ["--no-sandbox"]}\n' % chrome.replace("\\", "\\\\"))
        mermaid_cfg.write_text(
            '{\n'
            '  "theme": "base",\n'
            '  "themeVariables": {\n'
            '    "fontFamily": "Times New Roman, Songti SC, serif",\n'
            '    "fontSize": "18px",\n'
            '    "primaryColor": "#ffffff",\n'
            '    "primaryTextColor": "#222222",\n'
            '    "primaryBorderColor": "#666666",\n'
            '    "lineColor": "#666666",\n'
            '    "secondaryColor": "#ffffff",\n'
            '    "tertiaryColor": "#ffffff",\n'
            '    "background": "#ffffff"\n'
            '  }\n'
            '}\n'
        )

        subprocess.run(
            ["mmdc", "-i", str(mmd), "-o", str(png), "-b", "white", "-p", str(cfg), "-c", str(mermaid_cfg), "-s", "2"],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )

        width = figure_widths.get(figure_idx, "70%")
        result.append(f"![{alt}]({png}){{ width={width} }}")
        result.append("")
        figure_idx += 1
        continue

    result.append(line)
    i += 1

out.write_text("\n".join(result) + "\n")
PY
    python3 - "$PDF_MD" "$RENDERED_PDF_MD" "$TMP_DIR/pdf" "$CHROME_BIN" <<'PY'
from pathlib import Path
import subprocess
import sys
import re
import os

src = Path(sys.argv[1]).read_text().splitlines()
out = Path(sys.argv[2])
tmp_dir = Path(sys.argv[3])
chrome = sys.argv[4]
tmp_dir.mkdir(parents=True, exist_ok=True)

result = []
i = 0
figure_idx = 1
figure_widths = {1: "72%", 2: "42%", 3: "96%", 4: "100%", 5: "100%", 6: "52%", 7: "66%"}

while i < len(src):
    line = src[i]
    if line.strip() == "```mermaid":
        i += 1
        mermaid_lines = []
        while i < len(src) and src[i].strip() != "```":
            mermaid_lines.append(src[i])
            i += 1
        if i < len(src) and src[i].strip() == "```":
            i += 1

        caption = f"图 {figure_idx}"
        while i < len(src) and not src[i].strip():
            i += 1
        if i < len(src) and re.match(r"^图\s*\d+", src[i].strip()):
            caption = src[i].strip()
            i += 1
        alt = re.sub(r"^图\s*\d+\s*", "", caption).strip() or f"Figure {figure_idx}"

        mmd = tmp_dir / f"figure-{figure_idx:02d}.mmd"
        png = tmp_dir / f"figure-{figure_idx:02d}.png"
        cfg = tmp_dir / f"puppeteer-{figure_idx:02d}.json"
        mermaid_cfg = tmp_dir / f"mermaid-{figure_idx:02d}.json"
        mmd.write_text("\n".join(mermaid_lines) + "\n")
        cfg.write_text('{"executablePath": "%s", "args": ["--no-sandbox"]}\n' % chrome.replace("\\", "\\\\"))
        mermaid_cfg.write_text(
            '{\n'
            '  "theme": "base",\n'
            '  "themeVariables": {\n'
            '    "fontFamily": "Times New Roman, Songti SC, serif",\n'
            '    "fontSize": "18px",\n'
            '    "primaryColor": "#ffffff",\n'
            '    "primaryTextColor": "#222222",\n'
            '    "primaryBorderColor": "#666666",\n'
            '    "lineColor": "#666666",\n'
            '    "secondaryColor": "#ffffff",\n'
            '    "tertiaryColor": "#ffffff",\n'
            '    "background": "#ffffff"\n'
            '  }\n'
            '}\n'
        )

        subprocess.run(
            ["mmdc", "-i", str(mmd), "-o", str(png), "-b", "white", "-p", str(cfg), "-c", str(mermaid_cfg), "-s", "2"],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )

        width = figure_widths.get(figure_idx, "70%")
        result.append(f"![{alt}]({png}){{ width={width} }}")
        result.append("")
        figure_idx += 1
        continue

    result.append(line)
    i += 1

out.write_text("\n".join(result) + "\n")
PY
  else
    echo "Warning: Mermaid CLI not installed; Mermaid blocks will remain as code."
  fi

  if [ -f "$DOCX_TEMPLATE" ]; then
    pandoc "$RENDERED_DOCX_MD" --standalone --number-sections --reference-doc="$DOCX_TEMPLATE" -o "${OUTPUT_DIR}/${BASENAME}.docx"
  else
    pandoc "$RENDERED_DOCX_MD" --standalone --number-sections -o "${OUTPUT_DIR}/${BASENAME}.docx"
  fi

  if [ -f "$LATEX_HEADER" ]; then
    pandoc "$RENDERED_PDF_MD" --standalone --number-sections -V documentclass=ctexart -V classoption=fontset=none -H "$LATEX_HEADER" -t latex -o "$TEX_FILE"
  else
    pandoc "$RENDERED_PDF_MD" --standalone --number-sections -V documentclass=ctexart -V classoption=fontset=none -t latex -o "$TEX_FILE"
  fi

  xelatex -interaction=nonstopmode -halt-on-error -output-directory="$TMP_DIR" "$TEX_FILE" >/dev/null
  cp "${TMP_DIR}/document.pdf" "${OUTPUT_DIR}/${BASENAME}.pdf"
  rm -rf "$TMP_DIR"

  echo "Export complete: ${OUTPUT_DIR}/${BASENAME}.docx and .pdf"
else
  echo "pandoc is not installed; export skipped"
  exit 2
fi
