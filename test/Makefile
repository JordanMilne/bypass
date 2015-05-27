DEPOBJ   = $(wildcard ../dep/snudown/build/temp.*/src/*.o)
HOUDOBJ   = $(wildcard ../dep/snudown/build/temp.*/houdini/*.o)
SUTOBJ   = $(wildcard ../src/*.o)
SRC      = $(wildcard *.cpp)
OBJ		 = $(SRC:.cpp=.o)
TESTS    = $(SRC:.cpp=.tst)
CPPFLAGS = -Wall
CXXFLAGS = -I../src -I../dep/snudown/src -I../dep/snudown/houdini -g -O3 -Wno-unknown-pragmas

.PHONY: all clean check test
.SECONDARY:

all: check

%.o: %.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $(DEPOBJ) $<

%.tst: %.o
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $(addsuffix .tst,$(basename $<)) $(DEPOBJ) $(SUTOBJ) $(HOUDOBJ) $^

test: $(TESTS)

check: test
	for test in *.tst; do echo "• $${test}" && "./$${test}"; done

clean:
	rm -f *.o
	rm -f *.tst
	rm -rf *.dSYM
