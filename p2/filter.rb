# Problem 4
def filter(num_array, options = nil)
  num_array.each do |n|
    next if !options.nil? &&
            ((options.key?(:min) && n < options[:min]) ||
            (options.key?(:max) && n > options[:max]) ||
            (options.key?(:odd) && n.even?) ||
            (options.key?(:even) && n.odd?))
    n *= options[:scale] if !options.nil? && options.key?(:scale)
    yield n
  end
end

nums = [6, -5, 319, 400, 18, 94, 11]
filter(nums, min: 10, max: 350, odd: 1, scale: 2) { |n| puts n }
filter(nums, max: 0) { |n| puts n }
filter(nums) { |n| puts n }
