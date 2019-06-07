#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

MSWORD="/Applications/Microsoft Word.app/Contents/Resources/Style"

cd $DIR

if [[ ! -e "BurgmannHarvard.xsl" ]]; then
  echo "ERROR: Reference Bibliography XSL File Doesn't Exist"
elif [[ -e "BurgmannHarvard.xsl" ]]; then
  echo "INFO: Reference File Exists!"
fi

if [[ -e $MSWORD ]]; then
  echo "INFO: Installed Microsoft Word Found"
elif [[ ! -e $MSWORD ]]; then
  echo "ERROR: No Microsoft Word Application Found"
fi

sudo cp -R ./BurgmannHarvard.xsl "$MSWORD"

if [[ -e "$MSWORD/BurgmannHarvard.xsl" ]]; then
  echo "INFO: Installed Burgmann Harvard Bibliography Successfully"
elif [[ ! -e "$MSWORD/BurgmannHarvard.xsl" ]]; then
  echo "ERROR: Installation Unsuccessful"
fi
