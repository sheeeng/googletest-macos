export BUILD_DIR = $(shell "pwd")/build

# Flags passed to the C++ compiler.
# https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html
# export CXXFLAGS = -g -pthread --coverage
export CXXFLAGS = -g -Wall -Wextra -Werror -std=c++17
# export CXXFLAGS = -g -pthread --coverage -std=c++11 -Wc++11-extensions -Werror -ferror-limit=4

# Flags passed to the linker.
# https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html
export LDFLAGS = -pthread --coverage

export CC = clang++
export LD = clang++
export AR = ar

.PHONY: all
all:
	@$(MAKE) build
	@$(MAKE) --directory tests/


.PHONY: build
build:
	@mkdir --parents build/
	@$(MAKE) --directory src/

.PHONY: clean
clean:
	rm --force --recursive --verbose build/
	@$(MAKE) clean --directory src/
	@$(MAKE) clean --directory tests/


############################ Sonar-related rules ###############################

sonar: sonar_cppcheck sonar_vera sonar_rats sonar_runtests sonar_coverage sonar_sonar

CPPCHECK_INCLUDES = -Isrc
SOURCES_TO_ANALYSE = src

# Run cppcheck, a general purpose static code checker
sonar_cppcheck:
	cppcheck -v --enable=all --xml $(CPPCHECK_INCLUDES) $(SOURCES_TO_ANALYSE) 2> $(BUILD_DIR)/cppcheck-report.xml

# Run vera: static code checker focusing on code style issues
sonar_vera:
	bash -c 'find src -regex ".*\.cc\|.*\.hh" | vera++ - -showrules -nodup |& vera++Report2checkstyleReport.perl > $(BUILD_DIR)/vera++-report.xml'

# Run rats: static code checker focusing on (potential) security problems
sonar_rats:
	rats -w 3 --xml $(SOURCES_TO_ANALYSE) > $(BUILD_DIR)/rats-report.xml

# Run some tests. This run provides:
# 1) test execution report
# 2) valgrind/memcheck report
# 3) raw coverage data (.gcda-files)
sonar_runtests:
	-valgrind --xml=yes --xml-file=$(BUILD_DIR)/valgrind-report.xml $(BUILD_DIR)/test_component1 --gtest_output=xml:$(BUILD_DIR)/xunit-report.xml

# Collect the coverage data and convert it to cobertura-format
sonar_coverage:
	gcovr -x -r . > $(BUILD_DIR)/gcovr-report.xml

# Parse collected data and feed it into sonar
sonar_sonar:
	sonar-scanner -X
