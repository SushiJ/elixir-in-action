defmodule Todolist.Todolist do
  alias Todolist.Todolist

  defstruct auto_id: 1, entries: %{}

  def new(), do: %Todolist{}

  def add_entry(todo_list, entry) do
    # Sets the new entry's ID
    entry = Map.put(entry, :id, todo_list.auto_id)
    # Adds the new entry to the entries list
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    # Updates the struct
    %Todolist{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def entries(todo_list, date) do
    todo_list.entries
    # Filtering for a given date
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    # Takes only the values
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def update_entry(todo_list, id, lambda) do
    # Check if entry exists
    case Map.fetch(todo_list.entries, id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        old_entry_id = old_entry.id
        new_entry = %{id: ^old_entry_id} = lambda.(old_entry)
        #                 ^ matching on value
        new_entry = Map.put(todo_list.entries, new_entry.id, new_entry)
        %Todolist{todo_list | entries: new_entry}
    end
  end

  def delete_entry(todo_list, id) do
    %Todolist{todo_list | entries: Map.delete(todo_list.entries, id)}
  end
end
