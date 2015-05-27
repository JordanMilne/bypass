SNUDOWN_DIR = snudown

.PHONY: all snudown clean

all: snudown

snudown:
	 cd $(SNUDOWN_DIR) && python setup.py build

clean:
	 cd $(SNUDOWN_DIR) && python setup.py clean
	 cd $(SNUDOWN_DIR) && rm -rf build/temp.*
	 cd $(SNUDOWN_DIR) && rm -rf build/lib.*

