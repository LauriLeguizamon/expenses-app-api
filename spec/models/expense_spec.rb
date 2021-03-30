require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe "validations" do
    it "validate precense of required fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:description)
      should validate_presence_of(:ammount)
      should validate_presence_of(:type)
    end
  end
end
