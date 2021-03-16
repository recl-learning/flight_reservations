defmodule FlightReservations.Bookings.CreateOrUpdate do
  alias FlightReservations.Bookings.{BookingAgent, Booking}

  def call(user_id, %{} = payload) do
    %{payload | id_usuario: user_id}
    |> Booking.build()
    |> save_booking()
  end

  defp save_booking({:ok, %Booking{} = booking}), do: BookingAgent.save(booking)
  defp save_booking({:error, _reason} = error), do: error
end
