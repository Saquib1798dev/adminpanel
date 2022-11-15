class Variant < ApplicationRecord
  belongs_to :item, foreign_key: "item_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
end