class AddTotalBudgetToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :total_budget, :float
  end
end
