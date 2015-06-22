class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :author, null: false
      t.text  :content, null: false
      t.references :question, null: false

      t.timestamps
    end
  end
end
