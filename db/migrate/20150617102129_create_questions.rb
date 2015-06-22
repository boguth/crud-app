class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :author, null: false
      t.string  :title, null: false
      t.text  :content, null: false
      t.references :best_answer

      t.timestamps
    end
  end
end
