class Sale < ActiveRecord::Base
  has_many :payments, dependent: :destroy
  accepts_nested_attributes_for :payments, :allow_destroy => true

  has_many :line_item, dependent: :destroy
  # has_many :furnitures, :through => :line_items
  accepts_nested_attributes_for :line_items, :allow_destroy => true
end
