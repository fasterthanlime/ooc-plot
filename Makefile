.PHONY: clean all

all:
	ooc plot -g -sourcepath=./source:../ooc-cairo/:../ooc-lua -shout

test:
	make all && ./plot && feh output/graphic.png

clean: rm -rf ooc_tmp/ plot
