.PHONY: clean all

all:
	ooc plot -g -sourcepath=.:../ooc-cairo/ -shout

clean: rm -rf ooc_tmp/ plot
