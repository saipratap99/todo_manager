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
    due_date = todo[:due_date].empty? ? nil : Date.parse(todo[:due_date])
    new_todo = Todo.new(todo_text: todo_text, due_date: due_date, completed: false, user_id: current_user.id)
    if new_todo.save
      flash[:notice] = "Your todo is successfully created"
      redirect_to todos_path
    else
      flash[:error] = new_todo.errors.full_messages
      redirect_to todos_path
    end
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
