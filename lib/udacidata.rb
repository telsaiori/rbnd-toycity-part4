require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
    def self.create(attributes = {})
        #Product.create(brand: "WalterToys", name: "Sticky Notes", price: 34.00)
        data_path = File.dirname(__FILE__) + "/../data/data.csv"
        new_product = Product.new(attributes)
        CSV.open(data_path, "a+") do |csv|
            csv << [new_product.id, new_product.brand, new_product.name, new_product.price]
        end


    end

end
