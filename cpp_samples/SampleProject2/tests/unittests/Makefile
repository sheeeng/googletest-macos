GTEST_DIR = ${HOME}/Downloads/googletest-release-1.10.0/googletest
GMOCK_DIR = ${HOME}/Downloads/googletest-release-1.10.0/googlemock

CPPFLAGS = -I../../src -I$(GTEST_DIR) -I$(GMOCK_DIR)

# # Flags passed to the C++ compiler.
# # https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html
# CXXFLAGS = -g -std=c++17

# LIBS = -lpthread -lgtest $(GTEST_DIR)/libgtest.a $(BUILD_DIR)/libcomponents.a
LIBS = -lpthread ../libgtest.a  $(BUILD_DIR)/libcomponents.a

TESTS = $(BUILD_DIR)/test_component1

all: $(TESTS)

# libgtest.a:
# 	$(CC) $(CPPFLAGS) $(CXXFLAGS) -c $(GTEST_DIR)/src/gtest-all.cc -o gtest-all.o
# 	$(CC) $(CPPFLAGS) $(CXXFLAGS) -c $(GTEST_DIR)/src/gtest_main.cc -o gtest_main.o
# 	$(AR) -r libgtest.a gtest-all.o gtest_main.o

$(BUILD_DIR)/test_component1: $(BUILD_DIR)/libcomponents.a test_component1.o
	$(LD) $^ $(LIBS) $(LDFLAGS) -o $@

%.o : %.cc
	$(CC) -c $(CPPFLAGS) $(CXXFLAGS) $< -o $@

clean:
	rm --force *.a *.o *.gc*
