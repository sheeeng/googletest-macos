GTEST_DIR = ${HOME}/Downloads/googletest-release-1.10.0/googletest

CPPFLAGS = -I$(GTEST_DIR)/include -I$(GTEST_DIR)

# # Flags passed to the C++ compiler.
# # https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html
# CXXFLAGS = -g -std=c++17

all: libgtest
all:
	@$(MAKE) -C unittests

libgtest:
	$(CC) $(CPPFLAGS) $(CXXFLAGS) -c $(GTEST_DIR)/src/gtest-all.cc -o gtest-all.o
	$(CC) $(CPPFLAGS) $(CXXFLAGS) -c $(GTEST_DIR)/src/gtest_main.cc -o gtest_main.o
	$(AR) -r libgtest.a gtest-all.o gtest_main.o

clean:
	rm --force --verbose *.a *.o *.gc*
	@$(MAKE) clean --directory unittests
