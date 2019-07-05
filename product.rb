# Represents every product in the shop
class Product
  def initialize(name, price, quantity)
    @name = name
    @price = price
    @quantity = quantity
  end

  attr_reader :name, :price, :quantity

  def sell(how_many)
    if @quantity >= how_many
      print "#{commify(how_many)} adet #{@name} alındı."
      puts " Ücreti: #{commify(@price * how_many)} lira."
      puts "Stokta #{commify(@quantity -= how_many)} adet #{@name} kaldı"
    else
      puts "Elimizde o kadar #{@name} yok."
    end
  end

  def +(other)
    puts 'Stok dolduruldu.'
    puts "Artık #{commify(@quantity += other)} adet #{@name} var."
    self
  end

  def create_string
    "'#{@name}',#{@price},#{@quantity}"
  end

  def print_info
    "#{@name}->#{commify(@price)} lira. Stok: #{commify(@quantity)} adet."
  end

  def commify(number)
    return number if number < 1000

    index = 3
    text = number.to_i.to_s.reverse
    (text.length / 3).times do
      text.insert(index, ',')
      index += 4
    end
    text.chomp!(',')
    "#{text.reverse!}.#{number.to_s.partition('.').last}"
  end
end
