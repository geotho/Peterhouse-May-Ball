class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user, index: true
      t.decimal :amount, precision: 6, scale: 2
      t.integer :method

      t.timestamps
    end
  end
end
