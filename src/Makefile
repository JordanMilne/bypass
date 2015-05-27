SRC      = $(wildcard *.cpp)
OBJ      = $(SRC:.cpp=.o)
HOUDOBJ   = $(wildcard ../dep/snudown/houdini/*.o)
DEPOBJ   = $(wildcard ../dep/snudown/src/*.o)
CPPFLAGS = -Wall
CXXFLAGS = -I../dep/snudown/src -I../dep/snudown/houdini -g -O3 -fPIC

.PHONY: all clean

all: $(OBJ)

%.o: %.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $(HOUDOBJ) $(DEPOBJ) $<

clean:
	rm -f *.o
	rm -f *.a