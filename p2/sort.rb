# Problem 2
def get_digits(s)
  i = s[/\d+/]
  r = if i.nil?
        -1
      else
        i.to_i
      end
  r
end

def funny_sort(array)
  array.sort { |s1, s2| get_digits(s1) <=> get_digits(s2) }
end

puts funny_sort(['abc99.6', '-100x500', 'asdasd'])
puts
puts funny_sort(['99.6', '100', '-2', 'abs23', 'abew', '2.6we'])
