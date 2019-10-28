#!/usr/bin/env bash


echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
# https://askubuntu.com/a/691237
# figlet -w 72 -c -k Google Test | gzip | base64
base64 -d <<< "\
H4sIAGXBtl0AA4VPwQnEMAz7dwo9r1DIQgZ3EA1fy3ab3FE4PSIhK44CFDyAd0zff1LSW+uhKTPT
0aIIEbdPmc7UOiinN1QqF8FWOkHN2sCj9WJM4pgbokFYH9+/KE1miVG50hYVbO0A8/yFaGChI660
T224NTNhs8M7KvYH2wV3RSXxjAEAAA==" | gunzip
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"


echo "▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣"

# https://stackoverflow.com/a/246128
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "\${SCRIPT_DIR}: ${SCRIPT_DIR}"

# https://stackoverflow.com/a/192337
SCRIPT_FILENAME="$(basename "$(test -h "$0" && readlink "$0" || echo "$0")")"
echo "\${SCRIPT_FILENAME}: ${SCRIPT_FILENAME}"

source "${SCRIPT_DIR}/commons.sh"
source "${SCRIPT_DIR}/colors.sh"

echo "▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣▣"


echo "▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢"
echo $(date --universal +"%Y-%m-%dT%H:%M:%SZ")
echo "▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢▢"


INITIAL_WORKING_DIRECTORY=$(pwd)
GOOGLETEST_VERSION=1.10.0

function download {
    printf "\n  Downloading....\n\n"
    # https://unix.stackexchange.com/a/29521
    curl "${CURL_OPTIONS[@]/#/--}" \
        --remote-name \
        --remote-time \
        "https://github.com/google/googletest/archive/release-${GOOGLETEST_VERSION}.tar.gz"
    tar -xf release-${GOOGLETEST_VERSION}.tar.gz
}

function build {
    printf "\n  Building....\n\n"
    cd googletest-release-${GOOGLETEST_VERSION}

    # $_ expands to the last argument to the previous simple command* or to previous command if it had no arguments.
    # The bash manual defines a simple command as "a sequence of optional variable assignments followed by blank-separated words and redirections, and terminated by a control operator. " where control operator refers to one of || & && ; ;; ( ) | |& <newline>.
    # In practice$_ works like I've described but only with ||, &&, ;, or newline as the control operator.
    # https://stackoverflow.com/a/30154711
    mkdir --parent build/ && cd $_

    # https://stackoverflow.com/a/13199942
    cmake -Dgtest_build_samples=OFF -Dgtest_build_tests=OFF -std=c++11 -stdlib=libc++ -U__STRICT_ANSI__ -DGTEST_USE_OWN_TR1_TUPLE=1 ../
    make
}

function install {
    printf "\n  Installing....\n\n"

    USR_LOCAL_INC="/usr/local/include"
    GTEST_DIR="/usr/local/Cellar/gtest/"
    GMOCK_DIR="/usr/local/Cellar/gmock/"

    rm --force --recursive --verbose ${USR_LOCAL_INC}/gtest
    rm --force --recursive --verbose ${USR_LOCAL_INC}/gmock
    rm --force --recursive --verbose ${GTEST_DIR}
    rm --force --recursive --verbose ${GMOCK_DIR}

    mkdir --parents ${GTEST_DIR}
    cp --verbose lib/libgtest*.a ${GTEST_DIR}
    cp --recursive --verbose ../googletest/include/gtest/ ${GTEST_DIR}
    ln --symbolic --no-dereference --force ${GTEST_DIR} ${USR_LOCAL_INC}/gtest
    ln --symbolic --no-dereference --force ${USR_LOCAL_INC}/gtest/libgtest.a /usr/local/lib/libgtest.a
    ln --symbolic --no-dereference --force ${USR_LOCAL_INC}/gtest/libgtest_main.a /usr/local/lib/libgtest_main.a

    mkdir --parents ${GMOCK_DIR}
    cp --verbose lib/libgmock*.a ${GMOCK_DIR}
    cp --recursive --verbose ../googlemock/include/gmock/ ${GMOCK_DIR}
    ln --symbolic --no-dereference --force ${GMOCK_DIR} ${USR_LOCAL_INC}/gmock
    ln --symbolic --no-dereference --force ${USR_LOCAL_INC}/gmock/libgmock.a /usr/local/lib/libgmock.a
    ln --symbolic --no-dereference --force ${USR_LOCAL_INC}/gmock/libgmock_main.a /usr/local/lib/libgmock_main.a
}

function clean {
    printf "\n  Cleaning....\n\n"
    cd ${INITIAL_WORKING_DIRECTORY}
    rm --force --recursive $(pwd)/googletest-release-${GOOGLETEST_VERSION}
    unlink $(pwd)/release-${GOOGLETEST_VERSION}.tar.gz
}

download && build && install && clean
