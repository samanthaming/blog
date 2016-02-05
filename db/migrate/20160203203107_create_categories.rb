class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title, presence: true
      
      t.timestamps null: false
    end
  end
end
