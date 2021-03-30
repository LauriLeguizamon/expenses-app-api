class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password, :total_budget
end