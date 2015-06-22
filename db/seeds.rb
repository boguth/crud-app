10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password: 'password'
  )
end

15.times do
  Question.create!(
    author: User.all.sample,
    title: Faker::Name.title,
    content: Faker::Lorem.paragraph,
  )
end

20.times do
  Answer.create!(
    author: User.all.sample,
    question: Question.all.sample,
    content: Faker::Hacker.say_something_smart
  )
end

20.times do
  QuestionComment.create!(
    author: User.all.sample,
    question: Question.all.sample,
    content: Faker::Hacker.say_something_smart
  )
end

20.times do
  AnswerComment.create!(
    author: User.all.sample,
    answer: Answer.all.sample,
    content: Faker::Hacker.say_something_smart
  )
end

30.times do
  QuestionVote.create!(
    voter: User.all.sample,
    question: Question.all.sample,
    value: 1
  )
end

30.times do
  QuestionCommentVote.create!(
    voter: User.all.sample,
    question_comment: QuestionComment.all.sample,
    value: 1
  )
end

30.times do
  AnswerVote.create!(
    voter: User.all.sample,
    answer: Answer.all.sample,
    value: 1
  )
end

30.times do
  AnswerCommentVote.create!(
    voter: User.all.sample,
    answer_comment: AnswerComment.all.sample,
    value: 1
  )
end
