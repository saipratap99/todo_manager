class TodosController < ApplicationController
  def index
  end

  def show
    id = params[:id]
    render plain: Todo.find(id).to_pleasant_string
  end

  def create
    todo = params[:todo]
    todo_text = todo[:todo_text]
    due_date = Date.parse(todo[:due_date])
    new_todo = Todo.create!(todo_text: todo_text, due_date: due_date, completed: false, user_id: current_user.id)
    redirect_to todos_path
  end

  def update
    id = params[:id]
    completed = params[:completed]
    todo = current_user.todos.find(id)
    todo.completed = completed
    todo.save!
    redirect_to todos_path
  end

  def destroy
    current_user.todos.find(params[:id]).destroy
    redirect_to todos_path
  end
end
