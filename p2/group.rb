# Problem 5
module Enumerable
  def each_group_by_first_char
    r = group_by { |s| s[0] }
    r.each { |k, v| yield(k, v) }
  end
end

x = %w[abcd axyz able xyzab qrst]
x.each_group_by_first_char do |char, words|
  printf("%s: %s\n", char, words.join(' '))
end
