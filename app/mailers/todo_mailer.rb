class TodoMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.todo_mailer.upcoming_todo.subject
  #
  def upcoming_todo
    @greeting = "Hi"
    @email, @name, @todo_text, @due_date = params[:email], params[:name], params[:todo_text], params[:due_date]

    mail(to: @email, subject: "Your todo due date is tomorow")
  end
end
