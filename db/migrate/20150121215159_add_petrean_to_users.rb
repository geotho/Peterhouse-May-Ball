class AddPetreanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :petrean, :boolean
  end
end
