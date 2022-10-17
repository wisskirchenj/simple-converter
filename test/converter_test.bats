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
    run do_convert "feet_to_meter 0.304"
    assert_output --partial "The definition is correct!"
}

@test "miles_to_km 1.6" {
    run do_convert "miles_to_km 1.6"
    assert_output --partial "The definition is correct!"
}


@test "miles_to_km -1.6" {
    run do_convert "miles_to_km -1.6"
    assert_output --partial "The definition is correct!"
}

@test "miles_to_km 1" {
    run do_convert "miles_to_km 1"
    assert_output --partial "The definition is correct!"
}

@test "miles_to_km 0.0" {
    run do_convert "miles_to_km 0.0"
    assert_output --partial "The definition is correct!"
}

@test "miles_to_km -1" {
    run do_convert "miles_to_km -1"
    assert_output --partial "The definition is correct!"
}

@test "miles_to_km 112345" {
    run do_convert "miles_to_km 112345"
    assert_output --partial "The definition is correct!"
}

@test "miles_to_km -2." {
    run do_convert "miles_to_km -2."
    assert_output --partial "The definition is correct!"
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