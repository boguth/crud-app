class CreateAnswerCommentVotes < ActiveRecord::Migration
  def change
    create_table :answer_comment_votes do |t|
      t.references :answer_comment, null: false
      t.references :voter, null: false
      t.integer :value, null: false

      t.timestamps
    end
  end
end
