class Order < ApplicationRecord
  belongs_to :cart
  enum status: [ :completed, :incomplete ]
  enum payment_status: [:requires_action, :succeeded]
  self.table_name = "orders"
end
