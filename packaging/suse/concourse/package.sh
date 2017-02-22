#!/bin/bash

set -e

log()   { echo ">>> $1" ; }

sed -i "s|<username>|$OSC_USERNAME|g" /root/.oscrc
sed -i "s|<password>|$OSC_PASSWORD|g" /root/.oscrc

# build the spec file
log "building the spec file"
velum-git/packaging/suse/make_spec.sh velum

pushd velum-osc/devel:CaaSP:1.0:ControllerNode/velum 1> /dev/null
  log "updating osc checkout to newest revision"
  osc up
  log "removing old specfile"
  osc rm velum.spec
  log "adding new specfile"
  cp ../../../velum-git/packaging/suse/velum.spec .
  log "fetching newest release from github"
  wget -O master.tar.gz https://github.com/kubic-project/velum/archive/master.tar.gz
popd 1> /dev/null

cp -a velum-osc/devel:CaaSP:1.0:ControllerNode/velum/. velum-osc-updated/
