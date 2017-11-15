class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :firstline
      t.string :postcode

      t.timestamps
    end
  end
end
