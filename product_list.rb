require_relative 'database.rb' # Reading, writing, saving database
# Represents a warehouse, a list of products.
class ProductList
  attr_reader :list
  def initialize(filename, table_name, columns)
    @db = Database.new("#{filename}.db")
    @db.new_table(table_name, columns)
    @table = table_name

    @list = []
    @db.read(@table).each do |data|
      @list << Product.new(data[1], data[2], data[3]) # Bypass 0 (ID)
    end
  end

  def save
    @db.delete(@table, '')
    @list.each do |pro|
      @db.write(@table, @list.index(pro).to_s + ',' + pro.create_string)
    end
  end

  def <<(other)
    @list << other
    save
    puts 'Eklendi.'
    self
  end

  def sell(index, quantity)
    return unless available?(index)

    @list[index].sell(quantity)
    save
  end

  def available?(index)
    return true if @list.size >= index && !@list[index].nil?

    puts 'Geçersiz ürün numarası girildi.'
    false
  end

  def -(other)
    return unless available?(other)

    @list.delete_at(other)
    save
    puts 'Silindi.'
    self
  end

  def refill(index, stock)
    return unless available?(index)

    @list[index] += stock
    save
  end

  def print_all
    i = 0
    @list.each do |pro|
      puts "#{i += 1}-#{pro.print_info}"
    end
    puts 'ürün yok' if i.zero?
  end
end
