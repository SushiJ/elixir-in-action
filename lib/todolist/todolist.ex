defmodule Todolist.Todolist do
  alias Todolist.MultiDict
  @type todo_list() :: %{date: Date.t(), title: String.t()}
  @type entry() :: %{date: Date.t(), title: String.t()}

  def new(), do: MultiDict.new()

  @spec add_entry(todo_list(), entry()) :: todo_list()
  def add_entry(todo_list, entry) do
    MultiDict.add(todo_list, entry.date, entry)
  end

  @spec entries(todo_list(), Date.t()) :: String.t()
  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end
end
