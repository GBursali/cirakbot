require_relative 'product.rb'
require_relative 'product_list.rb'

# A Menu, takes user inputs and calls the proper functions
class Menu
  def initialize(products)
    @products = products
  end

  # Add a new product for sale
  def add_product
    name = input('Ürün adı:')
    price = input('Fiyatı:').to_f
    quantity = input('Stokta bulunan ürün sayısı:').to_i

    @products << Product.new(name, price, quantity)
  end

  # Owner filled his stock.
  def add_stock
    @products.print_all
    target_index = input('Ürün seçiniz:').to_i - 1
    stock = input('Stoğa kaç ürün eklemek istiyorsunuz:').to_i
    @products.refill(target_index, stock)
  end

  # The product is nor out of sale or not sellable
  def delete_product
    @products.print_all
    @products -= input('Ürün seçiniz:').to_i - 1
  end

  # The user wants to buy a product
  def buy_product
    @products.print_all
    index = input('Satın alınacak ürünü seçiniz:').to_i - 1
    quantity = input('Kaç tane almak istiyorsunuz?:').to_i
    @products.sell(index, quantity)
  end

  def print_goods
    @products.print_all
  end

  def input(text)
    print(text)
    gets.chomp
  end
end

def clear
  Gem.win_platform? ? (system 'cls') : (system 'clear')
end
@products = ProductList.new('CirakBot', 'products',
                            'Id Int PRIMARY KEY,Name Text,Price Real,Stock Int')
menu = Menu.new(@products)
loop do
  clear
  puts '!Aşağıdakilerden olmayan her giriş, programı sonlandırır.'
  puts '1-Ürün ekle'
  puts '2-Stok ekle'
  puts '3-Ürün sil'
  puts '4-Ürün satın al'
  puts '5-Ürün listele'

  user_input = menu.input('Seçiminiz:').to_i
  clear

  case user_input
  when 1 then menu.add_product
  when 2 then menu.add_stock
  when 3 then menu.delete_product
  when 4 then menu.buy_product
  when 5 then menu.print_goods
  else
    break
  end

  menu.input('Devam etmek için enter...')
end
