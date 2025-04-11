class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  # has_many :orders

  validates :nickname, presence: true
  validates :password, format: { with: /\A(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z\d]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\u30fc]+\z/ }
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\u30fc]+\z/ }
  validates :date_of_birth, presence: true
end
