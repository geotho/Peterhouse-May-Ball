class AddMedwardsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :medwards, :boolean
  end
end
