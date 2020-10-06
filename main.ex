defmodule M do

  def main do

    # INSTRUCTIONS: Uncomment what you want to run
    # basic_term_stuff()
    # data_stuff()
    # comparisons()
    # decision_making()
    # tuyples()
    # lists()
    # maps()
    # some_pattern_matching()
    # anonymous_functions()
    # recursion()
    # looping() # major issues here - probably Elixir version issues
    # enumerables()
    # list_comprehensions()
    # exception_handling()
    concurrency()
  end

  def concurrency do

    spawn(fn() -> loop(50, 1) end)
    spawn(fn() -> loop(100, 50) end)

    # sending this 'concurrency' function process a message
    send(self(), {:french, "Bob"})

    receive do
      {:german, name} -> IO.puts "Guten tag #{name}"
      {:french, name} -> IO.puts "Bonjour #{name}"
      {:english, name} -> IO.puts "Hello #{name}"

    after
      500 -> IO.puts "Time up"

    end

  end

  def exception_handling do

    err = try do
      5 / 0

    rescue
      ArithmeticError -> "Can't divide by 0"
    end

    IO.puts err

  end

  def list_comprehensions do
    # for (generator), (function to filter), 'do' instructions
    # you can optionall return values into a different structure
    #   than a list using the :into option (not shown)
    # !! pattern matching is supported by the generator, providing
    #   a means of quick-and-dirty means of a first filtering operation

    dbl_list = for n <- [1,2,3], do: n * 2
    IO.inspect dbl_list

    even_list = for n <- [1,2,3,4], rem(n, 2) == 0, do: n
    IO.inspect even_list
  end

  def enumerables do
    IO.puts "Even list : #{Enum.any?([1,2,3], fn(n) -> rem(n, 2) == 0 end)}"
    Enum.each([1,2,3], fn(n) -> IO.puts n end)

    dbl_list = Enum.map([1,2,3], fn(n) -> n * 2 end)
    IO.inspect dbl_list

    # reduce actions
    sum_vals = Enum.reduce([1,2,3], fn(n, sum) -> n + sum end)
    IO.puts "Sum : #{sum_vals}"

    IO.inspect Enum.uniq([1,2,2])
  end

  def looping do
    # IO.puts "Sum : #{sum([1,2,3])}" # major compilation error, unsure why. Version?
  end

  # def sum([]), do: 0
  # def sum(h|t), do: h + sum(t)

  def loop(0,_), do: nil
  def loop(max, min) do
    if max < min do
      loop(0, min)
    else
      IO.puts "Num : #{max}"
      loop(max - 1, min)
    end
  end

  def recursion do
    # factorials are the most common way to demonstrate recursion
    IO.puts "Factorial of 3 : #{factorial(4)}"
  end

  def factorial(num) do
    if num <= 1 do
      1
    else
      result = num * factorial(num - 1)
      result
    end
  end

  def anonymous_functions do
    get_sum = fn (x, y) -> x + y end
    IO.puts "5 + 5 = #{get_sum.(5,5)}" # note the . in the anon fn call

    # shorthand notation is a bit arcane, but very efficient. Pretty cool
    get_less = &(&1 - &2)
    IO.puts "7 - 6 = #{get_less.(7, 6)}"

    # pattern matching / conditionals with anonymous functions
    add_sum = fn
      {x, y} -> IO.puts "#{x} + #{y} = #{x+y}"
      {x, y, z} -> IO.puts "#{x} + #{y} + #{z} = #{x+y+z}"
    end

    add_sum.({1, 2})
    add_sum.({1, 2, 3})

    # default values
    IO.puts do_it()

  end

  def do_it(x \\ 1, y \\ 1) do
    x + y
  end

  def some_pattern_matching do
    [length, width] = [20,30]
    IO.puts "Width : #{width}" # 30

    [_, [_, a]] = [20, [30, 40]]
    IO.puts "Get Num : : #{a}" # 40

    # can use multiple underscores
    [_, _, b] = [1,2,3]
    IO.puts b

  end

  def maps do
    # elixir's implemenation of key-value pairs / dictionaries
    capitals = %{"Alabama" => "Montgomery",
      "Alaska" => "Juneau",
      "Arizona" => "Phoenix"}

    IO.puts "Capital of Alaska is #{capitals["Alaska"]}"

    capitals2 = %{alabama: "Montgomery",
      alaska: "Juneau",
      arizona: "Phoenix"}
    IO.puts "Capital of Arizona is #{capitals2.arizona}"

    capitals3 = Dict.put_new(capitals, "Arkansas", "Little Rock")

  end

  def lists do
    list1 = [1,2,3]
    list2 = [4,5,6]

    # concatenate lists
    list3 = list1 ++ list2

    # subtract a list from a list
    list4 = list3 -- list1
    IO.inspect list4, label: "list 4: " # how to print lists in a string!

    IO.puts 6 in list4

    [head | tail] = list3
    IO.puts "Head : #{head}"

    IO.write "Tail : "
    IO.inspect tail

    IO.inspect [97, 98] # prints as character codes, not numbers
    IO.inspect [97, 98], charlists: :as_lists

    Enum.each tail, fn item ->
      IO.puts item
    end

    words = ["Random", "Words", "in a", "list"]
    Enum.each words, fn word ->
      IO.puts word
    end

    # using recursion
    display_list(words)

    IO.puts display_list(List.delete(words, "Random"))
    IO.puts display_list(List.delete(words, 1))
    IO.puts display_list(List.insert_at(words, 4, "Yeah"))

    IO.puts List.first(words)
    IO.puts List.last(words)

    # list of key-value pairs
    my_stats = [name: "Derek", height: 6.25]

  end


  def display_list([word|words]) do
    IO.puts word
    display_list(words)
  end

  def display_list([]), do: nil



  def tuyples do
    # not supposed to enumerate through tuples, slow operations
    my_stats = {175, 6.25, :Derek}
    IO.puts "Tuyple #{is_tuple(my_stats)}"

    # append, get
    my_stats2 = Tuple.append(my_stats, 42)
    IO.puts "Age #{elem(my_stats2, 3)}"
    IO.puts "Size : #{tuple_size(my_stats2)}"
    my_stats3 = Tuple.delete_at(my_stats2, 0)
    my_stats4 = Tuple.insert_at(my_stats3, 0, 1974)
    many_zeroes = Tuple.duplicate(0, 5)

    # pattern matching with tuples
    {weight, height, name} = {175, 6.25, "Derek"}
    IO.puts "Weight : #{weight}"
  end


  def decision_making do
    age = 16

    if age >= 18 do
      IO.puts "Can vote"
    else
      IO.puts "Can't vote"
    end


    unless age === 18 do
      IO.puts "You're not 18"
    else
      IO.puts "You are 18"
    end

    cond do
      age >= 18 -> IO.puts "You can vote"
      age >= 16 -> IO.puts "You can drive"
      age >= 14 -> IO.puts "You can wait"
      true -> IO.puts "Default"
    end

    case 2 do
      1 -> IO.puts "Entered 1"
      2 -> IO.puts "Entered 2"
      _ -> IO.puts "Default"
    end

    # ternary operators are a bit funky
    IO.puts "Ternary : #{if age > 18, do: "Can Vote", else: "Can't vote"}"

  end

  def comparisons do
    # == compares only values, ignoring data types
    # === compares both values and data types
    IO.puts "4 == 4.0 : #{4 == 4.0}"
    IO.puts "4 === 4.0 : #{4 === 4.0}"
    IO.puts "4 != 4.0 : #{4 != 4.0}"
    IO.puts "4 !== 4.0 : #{4 !== 4.0}"

    age = 16
    IO.puts "Vote & Drive : #{(age >= 16) and (age >= 18)}"
    IO.puts "Vote or Drive : #{(age >= 16) or (age >= 18)}"

    IO.puts not true # false

    # other comparisons are exactly what you'd expect
  end

  def data_stuff do
    # integers
    my_int = 123
    IO.puts "Integer #{is_integer(my_int)}"

    # floats
    my_float = 1.123
    IO.puts "Float #{is_float(my_float)}"

    # atoms
    my_atom = :Pittsburgh
    my_atom = :"New York" # how to handle spaces in atom names
    IO.puts "Atom is #{is_atom(my_atom)}"


    # strings
    my_str = "My Sentence"
    IO.puts "Length : #{String.length(my_str)}"

    longer_str = my_str <> " " <> "is longer" # concatenation
    IO.puts "Strings equal : #{"Egg" === "egg"}"

    IO.puts "My ? #{String.contains?(my_str, "My")}"
    IO.puts "Index 4 : #{String.at(my_str, 4)}"
    IO.puts "Substring : #{String.slice(my_str, 3, 8)}"

    IO.inspect String.split(longer_str, " ")
    IO.puts String.reverse(longer_str)
    IO.puts String.upcase(longer_str)
    IO.puts String.downcase(longer_str)
    IO.puts String.capitalize(longer_str)

    4 * 10 |> IO.puts

    # arithmetic : normal, with the following things to note
    IO.puts "5 / 4 = #{5/4}" # this is float divisions
    IO.puts "5 div 4 = #{div(5,4)}" # this is integer division, removes decimals
    IO.puts "5 rem 4 = #{rem(5,4)}" # rem = modulus

  end


  def basic_term_stuff do
    # Basic command line functions:
    name = IO.gets("What is your name? ") |> String.trim
    IO.puts "Hello #{name}"
  end
end
