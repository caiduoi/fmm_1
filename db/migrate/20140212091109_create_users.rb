class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :name
      t.string      :email
      t.datetime    :birth_date
      t.integer     :permission, default: 1
      t.string      :profile

      t.timestamps
    end
  end
end
