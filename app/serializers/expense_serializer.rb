class ExpenseSerializer < ActiveModel::Serializer 
  attributes :id, :name, :description, :ammount, :type, :user_id
end