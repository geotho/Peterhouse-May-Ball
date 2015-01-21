class AddTicketGroupToTicketType < ActiveRecord::Migration
  def change
    add_column :ticket_types, :ticket_group, :integer
  end
end
