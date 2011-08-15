#!/usr/bin/env bash
# Development environment setup script for Vertigo.
#
# Author: Benjamin Oakes <hello@benjaminoakes.com>
set -o errexit

if [ "Darwin" != `uname` ]; then
  echo "This script assumes you're running Mac OS X 10.6, but you seem to be running something else."
  echo "Please install git, git-flow <https://github.com/nvie/gitflow>, rvm, and rubygems"
  exit -1
else
  if [ `which brew` == '' ]; then
    echo "Please install homebrew <http://mxcl.github.com/homebrew/>"
    exit -1
  else
    brew install git-flow
  fi
fi

# Use git flow, please (https://github.com/nvie/gitflow, http://codesherpas.com/screencasts/on_the_path_gitflow.mov)
yes "" | git flow init # use the defaults
gem install bundler --version "~> 1.0"
bundle install
