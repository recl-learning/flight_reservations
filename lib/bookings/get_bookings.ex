defmodule FlightReservations.Bookings.GetBookings do
  alias FlightReservations.Bookings.BookingAgent

  defdelegate call(), to: BookingAgent, as: :get_all
end
