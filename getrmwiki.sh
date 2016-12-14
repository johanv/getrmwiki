#!/bin/bash

# location of your Redmine project
PROJECT=https://websites.chiro.be/projects/chirocivi
# output directory
OUT=out
# your API key
KEY=YOURAPIKEY

mkdir -p $OUT 2> /dev/null
pushd $OUT

pages=`curl -H "X-Redmine-API-Key: $KEY" -s $PROJECT/wiki/index.xml | sed "s_</title>_\n</title>_g" |  xmllint --xpath '//*/title/text()' -`

for page in $pages
do
	echo Downloading $page...
	curl -H "X-Redmine-API-Key: $KEY" -s $PROJECT/wiki/$page.xml \
		| xmllint --xpath '//wiki_page/text/text()' - \
		| pandoc --from=textile --to=markdown \
		| sed 's_&lt;/*pre&gt;\\*_```_g' \
		| sed 's/\\$//' \
		| sed 's/\\\[\\\[\([^\]*\)\\\]\\\]/\[\1\]\(\1.md\)/g' > $page.md
done

popd

