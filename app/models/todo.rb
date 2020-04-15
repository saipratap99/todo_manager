class Todo < ActiveRecord::Base
  belongs_to :user
  validates :todo_text, presence: true, length: { in: 3..50 }
  validates :due_date, presence: true

  def to_pleasant_string
    status = completed ? "[X]" : "[ ]"
    "#{id}. #{due_date.to_s(:short)} #{todo_text} #{status}"
  end

  def self.overdue
    where("due_date < ? and completed = ?", Date.parse(Date.today.to_s), false)
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
