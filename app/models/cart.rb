# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :items, through: :line_items
  has_many :orders
  
  belongs_to :user
  # def sub_total
  #   sum = 0
  #   self.line_items.each do |line_item|
  #     sum+= line_item.total_price
  #   end
  #   sum
  # end
end
