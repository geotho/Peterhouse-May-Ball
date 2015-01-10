class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :user, index: true
      t.decimal :amount, precision: 6, scale: 2
      t.string :description

      t.timestamps
    end
  end
end
