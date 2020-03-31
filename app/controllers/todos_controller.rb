class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def show
    id = params[:id]
    render plain: Todo.find(id).to_pleasant_string
  end

  def create
    todo_text = params[:todo_text]
    due_date = Date.parse(params[:due_date])
    new_todo = Todo.create!(todo_text: todo_text, due_date: due_date, completed: false)
    render plain: "Your newly created todo id is #{new_todo.id}"
  end

  def update
    id = params[:id]
    completed = params[:completed]
    todo = Todo.find(id)
    todo.completed = completed
    todo.save!
    render plain: "The todo with id #{id} and marked as completed as #{completed}"
  end

  def destroy
    Todo.find(params[:id]).destroy
    redirect_to todos_path
  end
end
