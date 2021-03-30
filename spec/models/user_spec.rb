require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it 'should validate presence of required fields' do
      should validate_presence_of(:email)
      should validate_presence_of(:password)
      should validate_presence_of(:total_budget)
    end

    it 'should validate relations' do
      should have_many(:expenses)
    end
  end
end
