#!/bin/bash

xmlformat()
{
	while test -n "$1"; do
        echo xmlformat "$1"
        xmllint --format  "$1"  --output "$1"
        shift
	done
}

base="story"
odt="${base}.odt"

odt2xml() # ODT -> XML
{
	mkdir "$odt".d
	unzip -o "$odt" -d "$odt".d 
	xmlformat "$odt".d/content.xml  "$odt".d/meta.xml  "$odt".d/settings.xml  "$odt".d/styles.xml
}

xml2odt() # XML -> ODT
{
	mv "$odt" "$odt".save
	( cd "$odt".d; zip -r ../"$odt" . -x *.svn-base -x ".svn/*" -x "*/.svn/*" -x "*/*/.svn/*" )
  	unzip -t "$odt"
}
