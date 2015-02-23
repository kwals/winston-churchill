class CreateTaskTable < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :complete
      t.integer :priority_level
      t.date :due
      t.belongs_to :area
    end
  end
end
