defmodule FlightReservations.Users.UserAgent do
  use Agent

  alias FlightReservations.Users.User

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    Agent.update(__MODULE__, &update_user(&1, user))
    {:ok, user}
  end

  def get(id) do
    Agent.get(__MODULE__, &get_user(&1, id))
  end

  def get_all() do
    Agent.get(__MODULE__, & &1)
  end

  defp update_user(state, %User{id: id} = user) do
    Map.put(state, id, user)
  end

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User with id '#{id}' not found."}
      user -> {:ok, user}
    end
  end
end
