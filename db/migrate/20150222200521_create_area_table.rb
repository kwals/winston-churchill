class CreateAreaTable < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.timestamp :created_at
      t.integer :hierarchy
      t.belongs_to :user
    end
  end
end
