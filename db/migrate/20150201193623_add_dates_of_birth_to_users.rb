class AddDatesOfBirthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_guest_date_of_birth, :date
    add_column :users, :second_guest_date_of_birth, :date
  end
end
