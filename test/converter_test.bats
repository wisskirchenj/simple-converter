setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    SRC_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/../src"
}

function do_convert() {
    echo -e $1 | bash $SRC_DIR/converter.bash
}

# ---------- happy case testing -------
@test "xy" {
    run do_convert "55 + 65"
#    assert_output --partial 120
}

# ---------- error case testing -------
