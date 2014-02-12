class AddLeaderFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :leader_flag, :integer
  end
end
