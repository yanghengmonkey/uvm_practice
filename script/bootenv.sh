#!/usr/sh
STEM=`git rev-parse --show-toplevel`
export STEM=$STEM
module remove modulefile
module load modulefile
