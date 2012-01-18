# Site:   http://rubykoans.com
# Code:   https://github.com/edgecase/ruby_koans
# Online: http://koans.heroku.com

# about_objects.rb
    # test
    assert_equal __(0), false.object_id
    assert_equal __(2), true.object_id
    assert_equal __(4), nil.object_id

    # test
    assert_equal __(1), 0.object_id
    assert_equal __(3), 1.object_id
    assert_equal __(5), 2.object_id
    assert_equal __(201), 100.object_id

    # test
    obj = Object.new
    copy = obj.clone
    assert_equal __(true), obj           != copy
    assert_equal __(true), obj.object_id != copy.object_id

# about_arrays.rb
    # test
    array = [:peanut, :butter, :and, :jelly]
    assert_equal __([]), array[4,0]
    assert_equal __([]), array[4,100]
    assert_equal __(nil), array[5,0]

# about_array_assignment.rb
    # test
    first_name, last_name = ["John", "Smith", "III"]
    assert_equal __("John"), first_name
    assert_equal __("Smith"), last_name

    # test
    first_name, *last_name = ["John", "Smith", "III"]
    assert_equal __("John"), first_name
    assert_equal __(["Smith","III"]), last_name

# about_hashes.rb
    # test
    hash = { :one => "uno" }
    assert_raise(___(IndexError, KeyError)) do
      hash.fetch(:doesnt_exist)
    end

    # test
    # default_value_is_the_same_object
    hash = Hash.new([])
    hash[:one] << "uno"
    hash[:two] << "dos"
    assert_equal __(["uno", "dos"]), hash[:one]
    assert_equal __(["uno", "dos"]), hash[:two]
    assert_equal __(["uno", "dos"]), hash[:three]
    assert_equal __(true), hash[:one].object_id == hash[:two].object_id

    # test
    hash = Hash.new {|hash, key| hash[key] = [] }
    hash[:one] << "uno"
    hash[:two] << "dos"
    assert_equal __(["uno"]), hash[:one]
    assert_equal __(["dos"]), hash[:two]
    assert_equal __([]), hash[:three]

# about_strings.rb
    # test
    long_string = %{
It was the best of times,
It was the worst of times.
}
    assert_equal __(54), long_string.length
    assert_equal __(3), long_string.lines.count

    # test
    long_string = <<EOS
It was the best of times,
It was the worst of times.
EOS
    assert_equal __(53), long_string.length
    assert_equal __(2), long_string.lines.count

    # test
    original_string = "Hello, "
    hi = original_string
    there = "World"
    hi += there
    assert_equal __("Hello, "), original_string

    # test
    string = "Bacon, lettuce and tomato"
    assert_equal __(97, 'a'), string[1]

# about_regular_expressions.rb
    # test
    assert_equal __("match"), "some matching content"[/match/]

    # test
    assert_equal __(""), "abbcccddddeeeee"[/z*/]
    assert_equal __(nil), "abbcccddddeeeee"[/z/]

    # test
    assert_equal __(nil), "start end"[/\Aend/]

    # test
    assert_equal __("Gray"), "Gray, James"[/(\w+), (\w+)/, 1]
    assert_equal __("James"), "Gray, James"[/(\w+), (\w+)/, 2]

    # test
    grays = /(James|Dana|Summer) Gray/
    assert_equal __("James Gray"), "James Gray"[grays]
    assert_equal __("Summer"), "Summer Gray"[grays, 1]
    assert_equal __(nil), "Jim Gray"[grays, 1]

    # test
    assert_equal __(["one", "two", "three"]), "one two-three".scan(/\w+/)

    # test
    assert_equal __("one t-three"), "one two-three".sub(/(t\w*)/) { $1[0, 1] }

# about_methods.rb
    # test
    def method_with_var_args(*args)
      args
    end
    assert_equal __([]), method_with_var_args
