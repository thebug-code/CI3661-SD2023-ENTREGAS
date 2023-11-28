# 3.
def producto_cartesiano(a, b)
  if a.empty? || b.empty?
    yield
  end

  a.map do |x|
    b.map do |y|
      yield [x, y]
    end
  end
end
