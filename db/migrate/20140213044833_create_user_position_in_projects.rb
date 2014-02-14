class CreateUserPositionInProjects < ActiveRecord::Migration
  def change
    create_table :user_position_in_projects do |t|
      t.integer :user_id
      t.integer :position_id, default: 1
      t.integer :project_id

      t.timestamps
    end
  end
end
