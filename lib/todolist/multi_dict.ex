defmodule Todolist.MultiDict do
  def new(), do: %{}

  def add(todo_list, date, title) do
    Map.update(todo_list, date, [title], &[title | &1])
  end

  def get(todo_list, date) do
    Map.get(todo_list, date)
  end
end
