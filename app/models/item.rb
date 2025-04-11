class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :condition_id, presence: true
  validates :category_id, presence: true
  validates :shipping_cost_id, presence: true
  validates :shipping_region_id, presence: true
  validates :shipping_time_id, presence: true
end
