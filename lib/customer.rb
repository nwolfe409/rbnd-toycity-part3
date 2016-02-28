# lib/customer.rb

class Customer
  attr_reader :name

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    add_to_customers
  end

  def self.all
    @@customers
  end
 
  def self.find_by_name(name) #returns customer by name
   all.find { |customer| customer.name == name }
  end
  
  def purchase(item)
    Transaction.new self, item
  end
  
  def self.print_customers
    puts "*" * 25
    puts "Customers"
    puts "-" * 25
    all.each do |customer|
      puts "#{customer.name}"
    end
    puts "*" * 25
  end

  private

  def add_to_customers
    @@customers.each do |customer|
      raise DuplicateCustomerError, "#{@name} already exists." if customer.name == @name
    end
    @@customers << self
  end

end