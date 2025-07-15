#!/usr/bin/env -S make -f

MAKEFLAGS += -Rr --warn-undefined-variables
SHELL != which bash
.SHELLFLAGS := -euo pipefail -c

_WS := $(or ) $(or )
_comma := ,
.RECIPEPREFIX := $(_WS)
.DEFAULT_GOAL := main

main :=

.ONESHELL:
.DELETE_ON_ERROR:
.PHONY: phony
self := $(firstword $(MAKEFILE_LIST))

cmd/jqsh.sh: src/jqsh.yml src/dist.jq src/jqsh.jq
 < $< yq -oj | src/dist.jq --args ns | src/jqsh.jq | { cat; echo as-cmd jqsh; } | bash -O expand_aliases > $@
jqsh: cmd/jqsh.sh

std := std
git-to-md := git2md
ejq := EJQ
libs := std git-to-md ejq
libs: phony $(libs)
cmd/%.sh: cmd/jqsh.sh lib/%.yml
 source cmd/jqsh.sh
 load lib/$*.yml
 as-cmd $(or $($*),$*) > $@

cmds := addpath.sh delpath.sh dist.jq ejq.sh git-to-md.sh jqsh.jq jqsh.sh jsm4.jq with.sh
cmds += $(libs:%=%.sh)
install:: $(cmds:%=cmd/%); install $^ /usr/local/bin

lib = install:: lib/$(strip $1).yml; install $$< /usr/local/lib/jqsh
$(foreach _,$(libs),$(eval $(call lib, $_)))

main:; date

# Local Variables:
# Mode: GNUmakefile
# indent-tabs-mode: nil
# End:
