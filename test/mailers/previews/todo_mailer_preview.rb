# Preview all emails at http://localhost:3000/rails/mailers/todo_mailer
class TodoMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/todo_mailer/upcoming_todo
  def upcoming_todo
    TodoMailer.upcoming_todo
  end

end
