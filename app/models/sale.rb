class Sale < ActiveRecord::Base
  has_many :payments, dependent: :destroy
  has_one :client, dependent: :destroy
  accepts_nested_attributes_for :payments, :allow_destroy => true
  has_many :lineFurnitures, dependent: :destroy
  has_many :furnitures, :through => :lineFurnitures
  accepts_nested_attributes_for :lineFurnitures, :allow_destroy => true
end
