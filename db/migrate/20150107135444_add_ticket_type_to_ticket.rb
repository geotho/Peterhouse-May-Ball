class AddTicketTypeToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :ticket_type, index: true
  end
end
