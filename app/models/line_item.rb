# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :item
  belongs_to :cart

  # def total_price
  #   self.quantity * self.product.price
  # end
end
