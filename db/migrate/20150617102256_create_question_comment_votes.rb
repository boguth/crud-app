class CreateQuestionCommentVotes < ActiveRecord::Migration
  def change
    create_table :question_comment_votes do |t|
      t.references :question_comment, null: false
      t.references :voter, null: false
      t.integer :value, null: false

      t.timestamps
    end
  end
end
