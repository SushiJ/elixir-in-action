defmodule Expense.Application do
  alias Expense.Application

  defstruct(
    title: "",
    date: nil,
    amount: 0
  )

  @type t :: %Application{
          title: String.t(),
          date: Date.t() | nil,
          amount: number()
        }

  @spec sample :: [t()]
  def sample do
    [
      %Application{
        title: "Crafting Interpretor in Go",
        date: ~D[2023-01-12],
        amount: 29.99
      },
      %Application{
        title: "Crafting Compiler in Go",
        date: ~D[2023-01-14],
        amount: 29.99
      },
      %Application{
        title: "The Go programming language",
        date: ~D[2023-01-11],
        amount: 29.99
      }
    ]
  end

  @spec total(list(t())) :: number()
  def total(expenses) do
    expenses
    |> Enum.reduce(0, fn expense, acc -> expense.amount + acc end)
  end

  def sort_by_date(expenses) do
    expenses
    |> Enum.sort_by(fn %{date: date} -> date end, {:desc, Date})
  end

  def add_expense(%Application{} = expense) do
    [expense | sample()]
  end

  def update_expense(title, amount) do
    [item] = Enum.filter(sample(), fn %{title: e_title} -> title == e_title end)
    new_item = %{item | amount: amount}

    [new_item | sample() |> List.delete(item)]
  end
end
