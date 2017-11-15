class CreatePostcodes < ActiveRecord::Migration[5.1]
  def change
    create_table :postcodes do |t|
      t.string :code
      t.decimal :lon
      t.decimal :lat

      t.timestamps
    end
  end
end
