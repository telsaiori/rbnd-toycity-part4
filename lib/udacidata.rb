require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
    @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
    @@products = []
    def self.create(attributes = {})
        new_product = Product.new(attributes)
        CSV.open(@@data_path, "a+") do |csv|
            csv << [new_product.id, new_product.brand, new_product.name, new_product.price]
        end
        new_product
    end
    
    def self.all
        CSV.read(@@data_path, headers: true).each do |product|
            @@products << self.new(id: product["id"], brand: product["brand"], name: product["product"], price: product["price"])
        end
        @@products
        #CSV.read(@@data_path).drop(1).map{ |product| @@products << self.new(id: product[0], brand: product[1], name: product[2], pricd: product[3])}
    end
    
    def self.first
        @@products.first
    end

end
