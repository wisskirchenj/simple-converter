setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    SRC_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/../src"
}

function do_menu() {
    echo -e $1 | bash $SRC_DIR/menu.bash
}

# ---------- happy case testing -------

@test "0" {
    run do_menu "0"
    assert_output --partial "Welcome to the Simple converter!"
    assert_output --partial "Select an option"
    assert_output --partial "Goodbye!"
}

@test "quit" {
    run do_menu "quit"
    assert_output --partial "Welcome to the Simple converter!"
    assert_output --partial "Select an option"
    assert_output --partial "1. Convert units"
    assert_output --partial "Goodbye!"
}

@test "1 0" {
    run do_menu "1\n0"
    assert_output --partial "Not implemented!"
    assert_output --partial "Goodbye!"
}

@test "2 0" {
    run do_menu "2\n0"
    assert_output --partial "Not implemented!"
    assert_output --partial "Goodbye!"
}

@test "3 0" {
    run do_menu "3\n0"
    assert_output --partial "Not implemented!"
    assert_output --partial "Goodbye!"
}

@test "4 0" {
    run do_menu "4\n0"
    assert_output --partial "Invalid option!"
    assert_output --partial "Goodbye!"
}

@test "'' 0" {
    run do_menu "\n0"
    assert_output --partial "Invalid option!"
    assert_output --partial "Goodbye!"
}

@test "blabla 0" {
    run do_menu "blabla\n0"
    assert_output --partial "Invalid option!"
    assert_output --partial "Goodbye!"
}