class Module
  
  # def create_finder_methods(*attributes)
  #   attributes.each do |name|
  #     self.send(:define_method, "self.find_by_#{name}(search)") do
  #       all.select{|brand| brand.brand == search}
  #     end
  #   end
  def create_finder_methods(*attributes)
    attributes.each do |name|
      self.class_eval("
        def self.find_by_#{name}(search)
          p all.select{ |product| product.#{name} == search}
        end
      
      ")
    end


    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
  end
end
