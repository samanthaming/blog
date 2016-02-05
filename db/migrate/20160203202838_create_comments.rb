class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body, presence: true, uniqueness: true
      t.timestamps null: false
    end
  end
end
