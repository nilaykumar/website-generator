#!/usr/bin/env bash
set -euo pipefail

# TeX files to be visible on the blog are stored here
texDir="$HOME/Documents/projects/writing/public/"
# the blog/website itself is stored here
webDir="$HOME/Documents/projects/website/"

cd $texDir
# clean out all old generated blog post pages
rm -f $webDir/src/posts/*.html
# for each TeX file in texDir do the following:
for file in *.tex; do
    [ -f "$file" ] || continue
    echo "Processing $file"
    outputFile="${file/.tex/.html}"
    # convert the TeX to HTML via pandoc
    # the metadata option -M ensures that the references come in with a heading
    # the provided --csl option chooses the citation/bibliography styling
    # notice that the bibliography files are assumed to be in texDir
    pandoc $file -f latex -t html --mathjax -C -o $outputFile -M reference-section-title="References" --csl=aims-mathematics.csl
    # parse some of the metadata from the TeX
    if ! title1=$(grep -m 1 "\\\title" $file)
    then
        echo "No title found in $file! Exiting..."
        exit 1
    fi
    if ! title=$(echo $title1 | sed 's/^[^{]*{\([^{}]*\)}.*/\1/')
    then
        echo "Could not parse title in $file! Exiting..."
        exit 1
    fi
    if ! date1=$(grep -m 1 "\\\date" $file)
    then
        echo "No date found in $file! Exiting..."
        exit 1
    fi
    if ! dateCreated=$(echo $date1 | sed 's/^[^{]*{\([^{}]*\)}.*/\1/')
    then
        echo "Could not parse date in $file! Exiting..."
        exit 1
    fi
    # add the metadata as YAML to be parsed by metalsmith-layouts
    printf -- "---\ntitle: $title\nlayout: post.njk\ncollection: posts\ndate: $dateCreated\n---\n" > temp.html
    cat $outputFile >> temp.html
    # place the resulting html file/layout in the right directory
    mv temp.html $webDir/src/posts/$outputFile
    rm -f $outputFile
done
cd - > /dev/null
