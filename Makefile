SRC_DIR  = src
TEST_DIR = test
DEP_DIR	 = dep
FUZZ_DIR = fuzzing

.PHONY: all dep lib check clean

all: check

dep:
	$(MAKE) -C $(DEP_DIR)

lib: dep
	$(MAKE) -C $(SRC_DIR)

check: lib
	$(MAKE) -C $(TEST_DIR)

clean:
	$(MAKE) -C $(TEST_DIR) clean
	$(MAKE) -C $(SRC_DIR) clean
	$(MAKE) -C $(DEP_DIR) clean
	$(MAKE) -C $(FUZZ_DIR) clean
