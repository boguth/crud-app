class CreateQuestionVotes < ActiveRecord::Migration
  def change
    create_table :question_votes do |t|
      t.references :question, null: false
      t.references :voter, null: false
      t.integer :value, null: false

      t.timestamps
    end
  end
end
