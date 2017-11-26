class Sale < ActiveRecord::Base
  has_one :configuracion, dependent: :destroy
  has_one :client, dependent: :destroy
  has_many :lineFurnitures, dependent: :destroy
  has_many :furnitures, :through => :lineFurnitures
  accepts_nested_attributes_for :configuracion, :allow_destroy => true
  accepts_nested_attributes_for :lineFurnitures, :allow_destroy => true
end
