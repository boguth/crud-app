class CreateQuestionComments < ActiveRecord::Migration
  def change
    create_table :question_comments do |t|
      t.references :author, null: false
      t.references :question, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
