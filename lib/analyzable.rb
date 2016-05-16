module Analyzable
  # Your code goes here!
  
  def average_price(products)
    average_price = 0.00
    products.each do |product|
      average_price += (product.price.to_f)/products.size
    end
    average_price.round(2)
    
  end
  
  def count_by_brand(products)
    count = {}
    all_brand = []
    products.each do |product|
      all_brand << product.brand
    end
    
   all_brand.uniq.each do |brand|
      products.each do |product|
        product.brand == brand
        count[brand] = count[brand].nil? ? 1 : count[brand]+=1
      end
    end
    count
  end
  
  
  def count_by_name(products)
    count = {}
    all_name = []
    products.each do |product|
      all_name << product.name
    end
    
    all_name.uniq.each do |name|
      products.each do |product|
        product.name == name
        count[name] = count[name].nil? ? 1 : count[name]+=1
      end
    end
    count
  end
  
  def print_report(all_data)
    result = "Average Price: $#{average_price(all_data)}\n"
    result += "Inventory by Brand: \n"
    count_by_brand(all_data).each do |key, value|
      result += " - #{key}: #{value} \n"
    end
    result += "Inventory by Name: \n"
    count_by_name(all_data).each do |key, value|
      result += " - #{key}: #{value}"
    end
    result
  end
end
