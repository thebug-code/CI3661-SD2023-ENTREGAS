# 3.
# Tasas de cambio
$USD_TO_JPY_EXR = 148.225
$USD_TO_EUR_EXR = 0.912747
$USD_TO_VED_EXR = 3542580
$USD_TO_BTC_EXR = 0.0000269283
$EUR_TO_JPY_EXR = 162.366
$EUR_TO_VED_EXR = 3880550
$EUR_TO_BTC_EXR = 0.0000294921
$VED_TO_JPY_EXR = 0.0000418389
$VED_TO_BTC_EXR = 0.00000000000759570
$JPY_TO_BTC_EXR = 0.000000181656

class Moneda
  def initialize(cnt)
    @cnt = cnt
  end

  def en(coin_sym)
    send(coin_sym)
  end
end

class Dolar < Moneda
  def yens
    @cnt * $USD_TO_JPY_EXR
  end
  
  def euros
    @cnt * $USD_TO_EUR_EXR
  end

  def bolivares
    @cnt * $USD_TO_VED_EXR
  end

  def bitcoins
    @cnt * $USD_TO_BTC_EXR
  end
end

class Yen < Moneda
  def dolares
    @cnt / $USD_TO_JPY_EXR
  end

  def euros
    @cnt / $EUR_TO_JPY_EXR
  end

  def bolivares
    @cnt / $VED_TO_JPY_EXR
  end

  def bitcoins
    @cnt * $JPY_TO_BTC_EXR
  end
end

class Euro < Moneda
  def dolares
    @cnt / $USD_TO_EUR_EXR
  end

  def bolivares
    @cnt * $EUR_TO_VED_EXR
  end

  def yens
    @cnt * $EUR_TO_JPY_EXR
  end

  def bitcoins
    @cnt * $EUR_TO_BTC_EXR
  end
end

class Bolivar < Moneda
  def dolares
    @cnt / $USD_TO_VED_EXR
  end

  def euros
    @cnt / $EUR_TO_VED_EXR
  end

  def yens
    @cnt * $VED_TO_JPY_EXR
  end

  def bitcoins
    @cnt * $VED_TO_BTC_EXR
  end
end

class Bitcoin < Moneda
  def dolares
    @cnt / $USD_TO_BTC_EXR
  end

  def euros
    @cnt / $EUR_TO_BTC_EXR
  end

  def yens
    @cnt / $JPY_TO_BTC_EXR
  end

  def bolivares
    @cnt / $VED_TO_BTC_EXR
  end
end

class Float
  def dolares
    Dolar.new(self)
  end

  def yens
    Yen.new(self)
  end

  def euros
    Euro.new(self)
  end

  def bolivares
    Bolivar.new(self)
  end

  def bitcoins
    Bitcoin.new(self)
  end
end
