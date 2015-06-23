class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :author, null: false
      t.references :publisher, null: false
      t.string :title

      t.timestamps
    end
  end
end
