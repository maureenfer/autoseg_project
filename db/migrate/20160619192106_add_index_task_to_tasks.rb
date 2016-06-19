class AddIndexTaskToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :index_task, :integer
  end
end
