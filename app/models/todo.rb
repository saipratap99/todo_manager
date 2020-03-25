class Todo < ActiveRecord::Base
  def to_pleasant_string
    status = completed ? "[X]" : "[ ]"
    "#{id}. #{due_date.to_s(:short)} #{todo_text} #{status}"
  end

  def self.overdue
    where("due_date < ?", Date.parse(Date.today.to_s))
    #return Todo object array for due_date is less than Date.today"
  end

  def self.due_today
    where("due_date = ?", Date.parse(Date.today.to_s))
  end

  def self.due_later
    where("due_date > ?", Date.parse(Date.today.to_s))
  end
end
