class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :abbreviation
      t.datetime :startdate
      t.datetime :enddate
      t.integer :team_id, default: 1

      t.timestamps
    end
  end
end
