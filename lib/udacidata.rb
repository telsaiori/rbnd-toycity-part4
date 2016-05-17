require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
    create_finder_methods("brand", "name")
    @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
    
    
    def self.create(attributes = {})
        new_product = Product.new(attributes)
        CSV.open(@@data_path, "a+") do |csv|
            csv << [new_product.id, new_product.brand, new_product.name, new_product.price]
        end
        new_product
    end
    
    def self.all
        products = []
        CSV.read(@@data_path, headers: true).each do |product|
            products << self.new(id: product["id"], brand: product["brand"], name: product["product"], price: product["price"])
        end
        products
        #CSV.read(@@data_path).drop(1).map{ |product| @@products << self.new(id: product[0], brand: product[1], name: product[2], pricd: product[3])}
    end
    
    def self.first(n = 1)
        if n == 1
            all.first
        else 
            all.first(n)
        end

    end
    
    def self.last(n = 1)
        if n == 1
            all.last
        else
            all.last(n)
        end
    end
    
    def self.find(n)
        # raise ProductNotFoundError, "Can not found product id#{n}" if all[n-1].nil?
        find = all.find{ |product| product.id == n }
        raise ProductNotFoundError, "Can not found product id#{n}" if find.nil?
        find
        
    end
    
    def self.destroy(n)
         products = []
         database = CSV.table(@@data_path)
         database.each do |data|
             products << new(id: data[:id], brand: data[:brand], name: data[:product], price: data[:price])
         end
             
         
         database.delete_if do |row|
             row[:id] == 2
         end
         
         File.open(@@data_path, "w") do |f|
             f.write(database.to_csv)
         end
         
        raise ProductNotFoundError, "Can not found product id#{n}" if products[n-1].nil?
         products[n-1]
         
       
         
    end
    
    def self.where(options = {})
        if options[:brand]
            all.select{|product| product.brand == options[:brand]}
        else
            all.select{|product| product.name == options[:name]}
        end
    end
    
    def update(options = {})
        products = []
        data = CSV.table(@@data_path)
        data.each do |product|
            if product[:id] == self.id
                product[:price] = options[:price] ? options[:price] : product[:price]
                product[:brand] = options[:brand] ? options[:brand] : product[:brand]
                product[:name] = options[:name] ? options[:name] :  product[:name]
                products = Product.new(id: product[:id], brand: product[:brand], name: product[:product], price: product[:price])
            end
        end
        File.open(@@data_path, "w") do |f|
            f.write(data.to_csv)
        end
        products
        
    end
    

end
