#!/usr/sh
rm -rf $(git rev-parse --show-toplevel)/.git/hooks && ln -snf $(git rev-parse --show-toplevel)/.git_hooks/ $(git rev-parse --show-toplevel)/.git/hooks
STEM=`git rev-parse --show-toplevel`
export STEM=$STEM
module remove modulefile
module load modulefile
