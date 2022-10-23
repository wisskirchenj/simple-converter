setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'
    SRC_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )/../src"
    cd $SRC_DIR
    rm -f definitions.txt
}

function do_menu() {
    echo -e $1 | bash $SRC_DIR/menu.bash
}

#-------- Tests ---------

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

@test "delete def no file" {
    run do_menu "3\n0"
    assert_output --partial "Please add a definition first!"
    assert_output --partial "Goodbye!"
}

@test "delete def empty file" {
    touch definitions.txt
    run do_menu "3\n0"
    assert_output --partial "Please add a definition first!"
    assert_output --partial "Goodbye!"
}

@test "add def invalid ab" {
    run do_menu "2\nab\na_to_b 2\n0"
    assert_output --partial "Enter a definition:"
    assert_output --partial "The definition is incorrect!"
    assert_output --partial "Goodbye!"
}

@test "add def invalid atob 2" {
    run do_menu "2\natob 2\na_to_b 2\n0"
    assert_output --partial "Enter a definition:"
    assert_output --partial "The definition is incorrect!"
    assert_output --partial "Goodbye!"
}

@test "add def invalid a_to_b 2a" {
    run do_menu "2\na_to_b 2a\na_to_b 3\n0"
    assert_output --partial "Enter a definition:"
    assert_output --partial "The definition is incorrect!"
    assert_output --partial "Goodbye!"
    run cat definitions.txt
    assert_output --partial "a_to_b 3"
}

@test "del def 2 lines no del" {
    echo "a_to_b 1.0" >> definitions.txt
    echo "c_to_d 2.0" >> definitions.txt
    run do_menu "3\n0\n0"
    assert_output --partial "Type the line number to delete or '0' to return"
    assert_output --partial "1. a_to_b 1.0"
    assert_output --partial "2. c_to_d 2.0"
    assert_output --partial "Goodbye!"
    run cat definitions.txt
    assert_output --partial "a_to_b 1.0"
    assert_output --partial "c_to_d 2.0"
}

@test "del def 2 lines 3 chosen" {
    echo "a_to_b 1.0" >> definitions.txt
    echo "c_to_d 2.0" >> definitions.txt
    run do_menu "3\n3\n0\n0"
    assert_output --partial "Type the line number to delete or '0' to return"
    assert_output --partial "Enter a valid line number!"
    assert_output --partial "Goodbye!"
    run cat definitions.txt
    assert_output --partial "a_to_b 1.0"
    assert_output --partial "c_to_d 2.0"
}

@test "del def 2 lines '' chosen" {
    echo "a_to_b 1.0" >> definitions.txt
    echo "c_to_d 2.0" >> definitions.txt
    run do_menu "3\n\n0\n0"
    assert_output --partial "Type the line number to delete or '0' to return"
    assert_output --partial "Enter a valid line number!"
    assert_output --partial "Goodbye!"
    run cat definitions.txt
    assert_output --partial "a_to_b 1.0"
    assert_output --partial "c_to_d 2.0"
}

@test "del def 2 lines abc chosen" {
    echo "a_to_b 1.0" >> definitions.txt
    echo "c_to_d 2.0" >> definitions.txt
    run do_menu "3\nabc\n0\n0"
    assert_output --partial "Type the line number to delete or '0' to return"
    assert_output --partial "Enter a valid line number!"
    assert_output --partial "Goodbye!"
    run cat definitions.txt
    assert_output --partial "a_to_b 1.0"
    assert_output --partial "c_to_d 2.0"
}

@test "del def 2 lines del sequentially" {
    echo "a_to_b 1.0" >> definitions.txt
    echo "c_to_d 2.0" >> definitions.txt
    run do_menu "3\n1\n3\n1\n3\n0"
    assert_output --partial "Type the line number to delete or '0' to return"
    assert_output --partial "1. a_to_b 1.0"
    assert_output --partial "1. c_to_d 2.0"
    assert_output --partial "Please add a definition first!"
    assert_output --partial "Goodbye!"
    run cat definitions.txt
    refute_output --partial "a_to_b 1.0"
    refute_output --partial "c_to_d 2.0"
}

@test "convert no file" {
    run do_menu "1\n0"
    assert_output --partial "Please add a definition first!"
    assert_output --partial "Goodbye!"
}

@test "convert empty file" {
    touch definitions.txt
    run do_menu "1\n0"
    assert_output --partial "Please add a definition first!"
    assert_output --partial "Goodbye!"
}

@test "convert with 2 lines 0 chosen" {
    echo "a_to_b 1.0" >> definitions.txt
    echo "c_to_d 2.0" >> definitions.txt
    run do_menu "1\n0\n0"
    assert_output --partial "Type the line number to convert units or '0' to return"
    assert_output --partial "1. a_to_b 1.0"
    assert_output --partial "2. c_to_d 2.0"
    assert_output --partial "Goodbye!"
}

@test "convert with 2 lines 3 chosen" {
    echo "a_to_b 1.0" >> definitions.txt
    echo "c_to_d 2.0" >> definitions.txt
    run do_menu "1\n3\n0\n0"
    assert_output --partial "Type the line number to convert units or '0' to return"
    assert_output --partial "Enter a valid line number!"
    assert_output --partial "Goodbye!"
}

@test "convert with 2 lines '' chosen" {
    echo "a_to_b 1.0" >> definitions.txt
    echo "c_to_d 2.0" >> definitions.txt
    run do_menu "1\n\n0\n0"
    assert_output --partial "Type the line number to convert units or '0' to return"
    assert_output --partial "Enter a valid line number!"
    assert_output --partial "Goodbye!"
}

@test "convert with 2 lines abc chosen" {
    echo "a_to_b 1.0" >> definitions.txt
    echo "c_to_d 2.0" >> definitions.txt
    run do_menu "1\nabc\n0\n0"
    assert_output --partial "Type the line number to convert units or '0' to return"
    assert_output --partial "Enter a valid line number!"
    assert_output --partial "Goodbye!"
}

@test "convert with 2 lines value 2.3 * 2 in 2nd try" {
    echo "a_to_b 1.0" >> definitions.txt
    echo "c_to_d 2.0" >> definitions.txt
    run do_menu "1\n2\none\n2.3\n0"
    assert_output --partial "Type the line number to convert units or '0' to return"
    assert_output --partial "Enter a value to convert:"
    assert_output --partial "Enter a float or integer value!"
    assert_output --partial "Result: 4.60"
    assert_output --partial "Goodbye!"
}
