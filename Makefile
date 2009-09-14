.PHONY: clean all

all:
	ooc plot -g -sourcepath=.:../ooc-cairo/:../ooc-lua -shout

clean: rm -rf ooc_tmp/ plot
