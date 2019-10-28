# googletest-macos

Project derived from https://gist.github.com/butuzov/e7df782c31171f9563057871d0ae444a gist.

The scripts to install [Google Test](https://github.com/google/googletest) on macOS platform.

## Prerequisites

- [Brew](https://brew.sh/)
    `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
- [CMake](https://cmake.org/)
    `brew install cmake`

It will install gmock and gtest under brew directories.

### Usage

```bash
chmod +x ./install.sh
sudo ./install.sh
```

### Example

```cpp
#include "gtest/gtest.h"

TEST( ExampleTest, First ) {
  EXPECT_TRUE(  true );
}

int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
```

```bash
clang++ -lgtest test.cpp -o  ./test -std=c++14 && ./test
```
