top:; @date

SHELL := bash

Makefile:;

################

-include self.mk
self ?= $(notdir $(shell pwd))

roll :=
# find . \( -name '*.yml' -o -name '*.j2' -o -name '*.md' \) | grep -v LICENSE | sort | sed -e 's/^/roll += /'

roll += $(self)-play.yml
roll += $(self)-setup.yml

ifeq ($(and $(filter $(MAKECMDGOALS),roll unroll),T),T)
include roll.mk
endif

################

skl.d := ../ar-skl

skl := LICENSE.md
skl += roll.mk

# find setup -type f | grep -v '~$' | sort | sed -e 's/^/skl += /'
skl += setup/defaults/main.yml
skl += setup/tasks/main.yml
skl += setup/templates/meta/main.yml.j2
skl += setup/templates/README.md.j2

$(self)-play.yml $(self)-setup.yml: $(self)-% : $(skl.d)/skl-%; install $< $@

$(skl): % : $(skl.d)/%; install --backup=t -D $< $@
skl: $(skl) $(self)-play.yml $(self)-setup.yml

################

notilde:; find -type f -name '*~' | xargs -r rm

################

ifeq ($(and $(filter $(MAKECMDGOALS),copy),T),T)
. := $(or $(to),$(error must define "to" with target "copy"))
endif

DRY :=
DRY := -n

copy.exclude :=

copy.exclude += .git/
copy.exclude += .gitignore
copy.exclude += .hg/
copy.exclude += .hgignore
copy.exclude += .hide/
copy.exclude += .unroll
copy.exclude += mkfile
copy.exclude += $(self)-roll.yml

copy  =
copy += rsync -avC $(DRY) $(copy.exclude:%=--exclude %) . $(to)

copy:; $($@)

################

f2rm :=
f2rm += handlers/main.yml
ifdef NEVER
f2rm += vars/main.yml
endif

d2rm :=
d2rm += handlers
d2rm += files
d2rm += templates
ifdef NEVER
d2rm += vars
endif

clean:; rm $(f2rm); rmdir $(d2rm)

################

run    := DRY :=
vartar := run

$(vartar):; @: $(eval $($@))
