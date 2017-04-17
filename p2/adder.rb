# Problem 6
class Adder
  def initialize(num)
    @num = num
  end

  def method_missing(m)
    if m =~ /\Aplus\d+\z/
      i = m[/\d+/].to_i
      Adder.class_eval do
        define_method m do
          @num + i
        end
      end
      eval(m.to_s)
    else
      super(m)
    end
  end
end
