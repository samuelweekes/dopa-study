class CreateStudies < ActiveRecord::Migration[5.2]
  def change
    create_table :studies do |t|
      t.integer :time
      t.integer :reward

      t.timestamps
    end
  end
end
