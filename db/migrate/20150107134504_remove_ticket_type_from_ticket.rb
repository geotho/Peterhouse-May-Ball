class RemoveTicketTypeFromTicket < ActiveRecord::Migration
  def change
    remove_column :tickets, :ticket_type, :integer
  end
end
