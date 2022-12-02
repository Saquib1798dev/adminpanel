module Api
  module V1
    module FilterItemService
      class << self
        def call(q)
          result = process(q.downcase)
          result
        end

        private

        def process(search)
          return Item.all if search.blank?
          Item.where("lower(name) LIKE :q or CAST(price AS TEXT) LIKE :q or lower(description) LIKE :q or CAST(availability AS TEXT) LIKE :q",q: "%#{search.downcase}%")
        end
      end
    end 
  end 
end
