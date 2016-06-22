module IntegerStuff
  def self.add(a, b)
    a+b
  end

  def self.fibonacci_cr(n)
    n <= 1 ? n :  fibonacci_cr(n - 1) + fibonacci_cr(n - 2)
  end
end
