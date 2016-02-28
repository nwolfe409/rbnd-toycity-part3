# lib/transaction.rb

class Transaction
  attr_reader :id, :product, :customer

  @@transactions = []

  def initialize(customer, product)
    @id = @@transactions.length + 1
    @customer = customer
    @product = product
    
    add_to_transactions
  end

  def self.all
    @@transactions
  end
  
  def self.find(id)
    @@transactions.find { |transaction| transaction.id == id }
  end
  
  def self.total_sales
    @@transactions.inject(0) { |sales, transaction| sales + transaction.product.price }
    puts "Total sales to date: #{ @@transactions.inject(0) { |sales, transaction| sales + transaction.product.price } }"
  end
      

  private

  def add_to_transactions
    if product.in_stock? then
      @@transactions.each do |transaction|
        raise DuplicateTransactionError, "#{@id} already exists." if transaction.id == @id
      end
      @@transactions << self
      product.decrease_stock
    else
      raise OutOfStockError, "'#{product.title}' is out of stock."
    end
  end


end