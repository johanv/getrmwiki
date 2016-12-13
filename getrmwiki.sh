#!/bin/bash

# location of your Redmine project
PROJECT=https://websites.chiro.be/projects/gap
# output directory
OUT=out

mkdir -p $OUT 2> /dev/null
pushd $OUT

# TODO: use API key for authentication.
# For now it works with public projects.

pages=`curl -s $PROJECT/wiki/index.xml | sed "s_</title>_\n</title>_g" |  xmllint --xpath '//*/title/text()' -`

for page in $pages
do
	echo Downloading $page...
	curl -s $PROJECT/wiki/$page.xml \
		| xmllint --xpath '//wiki_page/text/text()' - \
		| pandoc --from=textile --to=markdown \
		| sed 's/\\\[\\\[\([^\]*\)\\\]\\\]/\[\1\]\(\1.md\)/g' > $page.md
done

popd

