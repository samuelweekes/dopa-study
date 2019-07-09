class AddUserTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
    t.string :name
    t.string :email
    t.timestamps
    end
    create_table :accounts do |t|
    t.integer :user_id
    t.integer :balance
    t.timestamps
    end

    add_index :accounts, :user_id
  end
end
