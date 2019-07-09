class AddMaxBalanceToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :maxBalance, :integer
  end
end
