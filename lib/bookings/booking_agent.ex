defmodule FlightReservations.Bookings.BookingAgent do
  use Agent

  alias FlightReservations.Bookings.Booking

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Booking{} = booking) do
    Agent.update(__MODULE__, &update_booking(&1, booking))
    {:ok, booking}
  end

  def get(id) do
    Agent.get(__MODULE__, &get_booking(&1, id))
  end

  def get_all() do
    Agent.get(__MODULE__, & &1)
  end

  defp update_booking(state, %Booking{id: id} = booking) do
    Map.put(state, id, booking)
  end

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Booking with id '#{id}' not found."}
      booking -> {:ok, booking}
    end
  end
end
