class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
      t.integer :status
      t.timestamps null: false
    end
  end
end
