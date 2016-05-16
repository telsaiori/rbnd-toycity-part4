class Module
  
  # def create_finder_methods(*attributes)
  #   attributes.each do |find|
  #     p find
  #     self.send(:define_singleton_method, "find_by_#{find}") do |params = ""|
  #       all.each do |product|
  #         return product if product.find == params
  #       end
  #     end
  #   end
  def create_finder_methods(*attributes)
    attributes.each do |name|
      self.class_eval("
        def self.find_by_#{name}(search)
          all.each do |product|
            return product if product.#{name} == search
          end
        end
      
      ")
    end


    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
  end
end
