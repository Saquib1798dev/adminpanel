module Api
  module V1
    module FilterCategoryService
      class << self
        def call(search)
          @category = Category.where("lower(name) LIKE :q or CAST(price AS TEXT) LIKE :q or lower(description) LIKE :q or CAST(availability AS TEXT) LIKE :q",q: "%#{search}%")
          @category
        end 
      end
    end 
  end 
end
