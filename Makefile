CELLAR_DIR=/usr/local/Cellar
GTEST_DIR=${CELLAR_DIR}/gtest
GMOCK_DIR=${CELLAR_DIR}/gmock

# https://stackoverflow.com/a/4134861
INCLUDE_DIRECTORIES=$(CELLAR_DIR) $(GTEST_DIR) $(GMOCK_DIR)
INCLUDE_PARAMETERS=$(foreach d, $(INCLUDE_DIRECTORIES), -I$d)
LIBRARIES=gtest gmock
LIBRARIES_PARAMETERS=$(addprefix -l,$(LIBRARIES))

CXX = clang++
CXXFLAGS = -g -Wall -Wextra -Werror -std=c++17
TARGET = test

.PHONY: all
all: $(TARGET)

.PHONY: $(TARGET)
$(TARGET): $(TARGET).cpp
	$(CXX) $(CXXFLAGS) $(INCLUDE_PARAMETERS) $(LIBRARIES_PARAMETERS) -o $(TARGET) $(TARGET).cpp

.PHONY: clean
clean:
	$(RM) $(TARGET)
