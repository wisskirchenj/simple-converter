setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    SRC_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/../src"
}

function do_convert() {
    echo -e $1 | bash $SRC_DIR/converter.bash
}

# ---------- happy case testing -------

@test "feet_to_meter 0.304" {
    run do_convert "feet_to_meter 0.304\n100"
    assert_output --partial "Enter a value to convert:"
    assert_output --partial "Result: 30.4"
}

@test "miles_to_km 1.6\n20" {
    run do_convert "miles_to_km 1.6\n20"
    assert_output --partial "Enter a definition:"
    assert_output --partial "Result: 32"
}


@test "miles_to_km 1.6\na\n1" {
    run do_convert "miles_to_km 1.6\na\n1"
    assert_output --partial "Result: 1.6"
    assert_output --partial "Enter a float or integer value!"
    assert_output --partial "Enter a value to convert:"
}

@test "a_to_b 0\n-12" {
    run do_convert "a_to_b 0\n-12"
    assert_output --partial "Result: 0"
}

# ---------- error case testing -------

@test "kgtoounce 35.27" {
    run do_convert "kgtoounce 35.27"
    assert_output --partial "The definition is incorrect!"
}

@test "kg_to_ounce 35.27 gr" {
    run do_convert "kg_to_ounce 35.27 gr"
    assert_output --partial "The definition is incorrect!"
}

@test "feet_to_meter" {
    run do_convert "feet_to_meter"
    assert_output --partial "The definition is incorrect!"
}

@test "empty" {
    run do_convert ""
    assert_output --partial "The definition is incorrect!"
}

@test "a_to_ -12.2" {
    run do_convert ""
    assert_output --partial "The definition is incorrect!"
}

@test "_to_b -12.2" {
    run do_convert ""
    assert_output --partial "The definition is incorrect!"
}

@test "a_TO_b -12.2" {
    run do_convert ""
    assert_output --partial "The definition is incorrect!"
}