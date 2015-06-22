class CreateAnswerComments < ActiveRecord::Migration
  def change
    create_table :answer_comments do |t|
      t.references :author, null: false
      t.references :answer, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
