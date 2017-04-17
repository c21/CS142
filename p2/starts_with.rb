# Problem 3
def each_starts_with(s_array, pattern)
  s_array.each do |s|
    yield s if s.index(pattern).zero?
  end
end

each_starts_with(%w[abcd axyz able xyzab qrst], 'ab') { |s| puts s }
