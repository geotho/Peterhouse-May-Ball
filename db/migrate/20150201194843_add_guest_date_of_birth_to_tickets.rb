class AddGuestDateOfBirthToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :first_guest_date_of_birth, :date
    add_column :tickets, :second_guest_date_of_birth, :date
  end
end
