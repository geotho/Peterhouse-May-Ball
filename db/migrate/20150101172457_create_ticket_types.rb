class CreateTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_types do |t|
      t.string :name
      t.decimal :price, precision: 6, scale: 2
      t.integer :max_number
      t.integer :number_allocated
      t.boolean :for_sale
      t.integer :size

      t.timestamps
    end
  end
end
