class PriceCalculator
  attr_accessor :items

  PRICE_HASH = {"milk": 
                  { unit_price: { price: 3.97 },
                    sale_price: { price: 5, quantity: 2 }
                  },
              "bread":
                  { unit_price: { price: 2.17 },
                    sale_price: { price: 6, quantity: 3 }
                  },
              "banana":
                  { unit_price: { price: 0.99 }},
              "apple":
                  { unit_price: { price: 0.89 }}
                  }
                }
  def initialize
    @prices = PRICE_HASH
    @sale_price_hash = {}
    @unit_price_hash = {}
  end

  def items=()
    puts "Please enter all the items purchased separated by a comma"
    @items = gets.chomp
  end

  def get_items
    calculate_price_for_items(items)
  end

  private

  def calculate_price_for_items(items)
    items = items.split(",")
    items = items.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
    items = filter_items(items)
    items.each do |item,count|
      @unit_price_hash[item.to_sym] = @prices[item.to_sym][:unit_price][:price]*count
      if @prices[item.to_sym].key?(:sale_price)
        reminder = (count % @prices[item.to_sym][:sale_price][:quantity])
        if reminder > 0
          @sale_price_hash[item.to_sym] = @prices[item.to_sym][:sale_price][:price] + (@prices[item.to_sym][:unit_price][:price]*reminder)
        elsif reminder == 0
          @sale_price_hash[item.to_sym] = @prices[item.to_sym][:sale_price][:price]
        else
          @sale_price_hash[item.to_sym] = @prices[item.to_sym][:unit_price][:price]
        end 
      else
        @sale_price_hash[item.to_sym] = @prices[item.to_sym][:unit_price][:price]
      end
    end
    display_total_price(items)
  end

  def filter_items(items)
    price_hash = @prices.keys.map{|x|x.to_s}
    rejected_items = items.reject{|x,v| price_hash.include?(x)}
    rejected_items.each do |k,v|
      items.tap { |hs| hs.delete(k) }
    end
    items
  end

  def display_total_price(items)
    puts "-----------------------------------------------------------------------------"
    puts "Items           quantity             Price"
    puts "-----------------------------------------------------------------------------"
    items.each do |item,count|
      puts "#{item.upcase}          #{count}                    $#{@sale_price_hash[item.to_sym]}" 
    end
    final_sale_price = @sale_price_hash.values.inject(:+)
    final_unit_price = @unit_price_hash.values.inject(:+)
    puts "Total price : $#{final_sale_price}"
    puts "You saved $ #{(final_unit_price-final_sale_price).round(2)} today."
  end

end


PriceCalculator.new.get_items