class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :page
      t.text :note
      t.integer :book_id

      t.timestamps
    end
  end
end
