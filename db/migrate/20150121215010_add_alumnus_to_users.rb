class AddAlumnusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :alumnus, :boolean
  end
end
