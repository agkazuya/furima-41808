class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_region
  belongs_to_active_hash :shipping_time
  belongs_to :user
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    format: { with: /\A\d+\z/ }
  validates :condition_id, numericality: { other_than: 1 }, presence: true
  validates :category_id, numericality: { other_than: 1 }, presence: true
  validates :shipping_cost_id, numericality: { other_than: 1 }, presence: true
  validates :shipping_region_id, numericality: { other_than: 1 }, presence: true
  validates :shipping_time_id, numericality: { other_than: 1 }, presence: true
  validates :image, presence: true
end
