# a) Defina la clase en cuestion, con el campo propuesto
# b) Implemente setters y getters para el campo radio de Circulo.
# c) Implemente un metodo initialize (constructor) para Circulo que
# reciba un numero e inicialice el radio del circulo con dicho
# numero. En caso de que el numero propuesto sea negativo, se debe
# arrojar un error con el mensaje: 'Radio invalido'.

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
