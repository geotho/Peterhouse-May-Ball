class CreateAlumni < ActiveRecord::Migration
  def change
    create_table :alumni do |t|
      t.string :title
      t.string :first_name
      t.string :surname
      t.integer :matric

      t.timestamps null: false
    end
  end
end
