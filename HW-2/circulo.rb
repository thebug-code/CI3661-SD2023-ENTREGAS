# 1.

class Circulo
  attr_accessor :radio

  # constructor
  def initialize(radio)
    if radio < 0
      raise 'Radio invalido'
    end

    @radio = radio
  end

  # area del circulo
  def area
    Math::PI * @radio * @radio
  end
end

# 2. 
class Cilindro < Circulo
  attr_accessor :altura

  # constructor
  def initialize(radio, altura)
    if altura < 0
      raise 'Altura invalida'
    end
    super(radio)

    @altura = altura
  end

  # volumen del cilindro
  def volumen
    Math::PI * @radio * @radio * @altura
  end
end
