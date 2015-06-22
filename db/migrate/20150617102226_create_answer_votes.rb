class CreateAnswerVotes < ActiveRecord::Migration
  def change
    create_table :answer_votes do |t|
      t.references :answer, null: false
      t.references :voter, null: false
      t.integer :value, null: false

      t.timestamps
    end
  end
end
