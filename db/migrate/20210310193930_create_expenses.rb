class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.text :description
      t.float :ammount
      t.string :type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
