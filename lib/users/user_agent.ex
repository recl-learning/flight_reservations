defmodule FlightReservations.Users.UserAgent do
  use Agent

  alias FlightReservations.Users.User

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{id: id} = user) do
    Agent.update(__MODULE__, fn state -> Map.put(state, id, user) end)
    {:ok, user}
  end

  def get(id) do
    Agent.get(__MODULE__, fn state -> Map.get(state, id) end)
  end


  def get_all() do
    Agent.get(__MODULE__, & &1)
  end

end
