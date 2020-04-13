class Todo < ActiveRecord::Base
  belongs_to :user

  def to_pleasant_string
    status = completed ? "[X]" : "[ ]"
    "#{id}. #{due_date.to_s(:short)} #{todo_text} #{status}"
  end

  def self.overdue
    where("due_date < ? and completed = ?", Date.parse(Date.today.to_s), false)
    #return Todo object array for due_date is less than Date.today"
  end

  def self.due_today
    where("due_date = ?", Date.parse(Date.today.to_s))
  end

  def self.due_later
    where("due_date > ?", Date.parse(Date.today.to_s))
  end

  def self.completed_todos
    where("completed = ?", true)
  end
end
