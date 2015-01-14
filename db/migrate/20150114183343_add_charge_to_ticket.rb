class AddChargeToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :charge, index: true
  end
end
