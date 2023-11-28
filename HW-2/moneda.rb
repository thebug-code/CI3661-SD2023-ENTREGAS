# 3.
# Tasas de cambio
$USD_TO_JPY_EXR = 148.225
$USD_TO_EUR_EXR = 0.912747
$USD_TO_VED_EXR = 35.4784
$USD_TO_BTC_EXR = 0.0000269283
$EUR_TO_JPY_EXR = 162.366
$EUR_TO_VED_EXR = 38.92015958
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

  def compare_two_coins(c1, c2)
    if c1 > c2
      return :mayor
    elsif c1 < c2
      return :menor
    else
      return :igual
    end
  end
end

class Dolar < Moneda
  def yens
    (@cnt * $USD_TO_JPY_EXR).round(2)
  end
  
  def euros
    (@cnt * $USD_TO_EUR_EXR).round(2)
  end

  def bolivares
    (@cnt * $USD_TO_VED_EXR).round(2)
  end

  def bitcoins
    (@cnt * $USD_TO_BTC_EXR).round(2)
  end

  def comparar(other)
    other.compare_wth_dolar(self)
  end

  def compare_wth_yen(yen)
    compare_two_coins(yen.dolares, @cnt)
  end

  def compare_wth_euro(euro)
    compare_two_coins(euro.dolares, @cnt)
  end

  def compare_wth_bolivar(bolivar)
    compare_two_coins(bolivar.dolares, @cnt)
  end

  def compare_wth_bitcoin(bitcoin)
    compare_two_coins(bitcoin.dolares, @cnt)
  end
end

class Yen < Moneda
  def dolares
    (@cnt / $USD_TO_JPY_EXR).round(2)
  end

  def euros
    (@cnt / $EUR_TO_JPY_EXR).round(2)
  end

  def bolivares
    (@cnt / $VED_TO_JPY_EXR).round(2)
  end

  def bitcoins
    (@cnt * $JPY_TO_BTC_EXR).round(2)
  end

  def comparar(other)
    other.compare_wth_yen(self)
  end

  def compare_wth_dolar(dolar)
    compare_two_coins(dolar.yens, @cnt)
  end

  def compare_wth_euro(euro)
    compare_two_coins(euro.yens, @cnt)
  end

  def compare_wth_bolivar(bolivar)
    compare_two_coins(bolivar.yens, @cnt)
  end

  def compare_wth_bitcoin(bitcoin)
    compare_two_coins(bitcoin.yens, @cnt)
  end
end

class Euro < Moneda
  def dolares
    (@cnt / $USD_TO_EUR_EXR).round(2)
  end

  def bolivares
    (@cnt * $EUR_TO_VED_EXR).round(2)
  end

  def yens
    (@cnt * $EUR_TO_JPY_EXR).round(2)
  end

  def bitcoins
    (@cnt * $EUR_TO_BTC_EXR).round(2)
  end

  def comparar(other)
    other.compare_wth_euro(self)
  end

  def compare_wth_dolar(dolar)
    compare_two_coins(dolar.euros, @cnt)
  end

  def compare_wth_yen(yen)
    compare_two_coins(yen.euros, @cnt)
  end

  def compare_wth_bolivar(bolivar)
    compare_two_coins(bolivar.euros, @cnt)
  end

  def compare_wth_bitcoin(bitcoin)
    compare_two_coins(bitcoin.euros, @cnt)
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

  def comparar(other)
    other.compare_wth_bolivar(self)
  end

  def compare_wth_dolar(dolar)
    compare_two_coins(dolar.bolivares, @cnt)
  end

  def compare_wth_yen(yen)
    compare_two_coins(yen.bolivares, @cnt)
  end

  def compare_wth_euro(euro)
    compare_two_coins(euro.bolivares, @cnt)
  end

  def compare_wth_bitcoin(bitcoin)
    compare_two_coins(bitcoin.bolivares, @cnt)
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

  def comparar(other)
    other.compare_wth_bitcoin(self)
  end

  def compare_wth_dolar(dolar)
    compare_two_coins(dolar.bitcoins, @cnt)
  end

  def compare_wth_yen(yen)
    compare_two_coins(yen.bitcoins, @cnt)
  end 

  def compare_wth_euro(euro)
    compare_two_coins(euro.bitcoins, @cnt)
  end

  def compare_wth_bolivar(bolivar)
    compare_two_coins(bolivar.bitcoins, @cnt)
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
