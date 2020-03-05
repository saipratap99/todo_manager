class Todo < ActiveRecord::Base
  def to_pleasant_string
    status = completed ? "[X]" : "[ ]"
    "#{id}. #{due_date.to_s(:short)} #{todo_text} #{status}"
  end
end
