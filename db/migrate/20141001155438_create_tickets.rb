class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.integer :type
      t.integer :status
      t.integer :donation
      t.references :user, index: true

      t.timestamps
    end
  end
end
