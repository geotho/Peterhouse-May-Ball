class AddTicketToCharges < ActiveRecord::Migration
  def change
    add_reference :charges, :ticket, index: true
  end
end
