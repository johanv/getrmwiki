# getrmwiki

This bash script downloads the wiki pages from a Redmine project, and
stores them as markdown documents.

## how to

Open [the script](getrmwiki.sh) in a text editor, and adapt the value of `PROJECT` and
`OUT` to your needs. Then just run it, and wait for the files.

## shortcomings

* This script only works for public projects. (The use of API keys is not
  yet supported.)
* Attached files are ignored.
* It makes a mess of `<pre>..</pre>` blocks.
* Lots of other problems ;-)
