class User < ApplicationRecord
  has_many :expenses

  validates :email, presence: true
  validates :password, presence: true
  validates :total_budget, presence: true
end
