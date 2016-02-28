# lib/product.rb

class Product
  attr_reader :title, :stock, :price

  @@products = []

  def initialize(options={})
    @title = options[:title]
    @stock = options[:stock]
    @price = options[:price]
    add_to_products
  end

  def self.all
    @@products
  end
  
  def in_stock? #checks if the item is in stock
    @stock > 0
  end
  
  def self.in_stock #returns an array of instock items
    all.select { |product| product.in_stock? }
  end
  
  def self.find_by_title(title) #returns produce by title
   all.find { |product| product.title == title }
  end
  
  def decrease_stock
    @stock -= 1
  end

  private

  def add_to_products
    @@products.each do |product|
      raise DuplicateProductError, "#{@title} already exists." if product.title == @title
    end
    @@products << self
  end

end