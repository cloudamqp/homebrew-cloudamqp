#!/bin/bash

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <formula> <version>"
    echo "Example: $0 lavinmq 2.6.2"
    echo ""
    echo "Available formulas:"
    ls Formula/*.rb | sed 's|Formula/||;s|\.rb||'
    exit 1
fi

FORMULA=$1
VERSION=$2
FORMULA_FILE="Formula/${FORMULA}.rb"

if [ ! -f "${FORMULA_FILE}" ]; then
    echo "Error: Formula file ${FORMULA_FILE} not found"
    exit 1
fi

# Derive the download URL from the existing url in the formula
BASE_URL=$(grep -oP 'url "\K[^"]+' "${FORMULA_FILE}" | sed 's|/v[^/]*$||')
URL="${BASE_URL}/v${VERSION}.tar.gz"
TARBALL=$(mktemp)

echo "Updating ${FORMULA} formula to version ${VERSION}..."

echo "Downloading ${URL}..."
curl -fSL -o "${TARBALL}" "${URL}"

echo "Calculating SHA256..."
SHA256=$(sha256sum "${TARBALL}" | cut -d' ' -f1)
echo "SHA256: ${SHA256}"
rm "${TARBALL}"

echo "Updating ${FORMULA_FILE}..."
sed -i "s|url \".*\"|url \"${URL}\"|" "${FORMULA_FILE}"
sed -i "s|sha256 \".*\"|sha256 \"${SHA256}\"|" "${FORMULA_FILE}"

echo ""
echo "Changes:"
git diff "${FORMULA_FILE}"
