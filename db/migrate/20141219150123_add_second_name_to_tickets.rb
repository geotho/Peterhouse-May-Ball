class AddSecondNameToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :second_name, :string
  end
end
