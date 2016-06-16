class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :type
      t.text :description
      t.references :list, index: true
      t.timestamps null: false
    end
  end
end
