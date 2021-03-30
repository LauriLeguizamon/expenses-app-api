class Expense < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :description, presence: true
  validates :ammount, presence: true
  validates :type, presence: true

  self.inheritance_column = :_type_disabled
end
