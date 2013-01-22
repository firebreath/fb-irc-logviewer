#!/bin/bash
export PATH=$PATH:/usr/local/bin
pushd $( dirname "$0" )
bundle exec rails runner script/load-logs.rb ~/.znc/users/taxilian_freenode/moddata/log/default_#firebreath_`eval date -d "$1" +%Y%m%d`.log
popd
