defmodule FlightReservations.Reports.Report do
  alias FlightReservations.Bookings.Booking
  alias FlightReservations.Bookings.GetBookings

  def create_report() do
    content = GetBookings.call()
    |> Enum.map(fn {_k, booking} -> transform_booking(booking) end)
    |> Enum.reduce("", fn line, acc -> line <> acc end)
    File.write!("./reports/report.csv", content)
  end

  defp transform_booking(%Booking{} = booking) do
    "#{booking.id_usuario},#{booking.cidade_origem}," <>
      "#{booking.cidade_destino},#{booking.data_completa}\n"
  end
end
